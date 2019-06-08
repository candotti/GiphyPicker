//
//  GiphyCollectionViewFlowLayout.swift
//  GiphyPicker
//
//  Created by daniele candotti on 31/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import UIKit

/// GiphyCollectionView FlowLayout
class GiphyCollectionViewFlowLayout: UICollectionViewFlowLayout {

    /// Deleting indexPaths
    private var deletingIndexPaths = [IndexPath]()
    /// Inserting indexPaths
    private var insertingIndexPaths = [IndexPath]()
    /// ContentBounds
    private var contentBounds = CGRect.zero
    /// Cached attributes
    private var cachedAttributes = [UICollectionViewLayoutAttributes]()
    /// Data interactor
    private var dataInteractor: DataInteractable

    init(dataInteractor: DataInteractable) {
        self.dataInteractor = dataInteractor
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not beeen implemented")
    }

    /// - Tag: ColumnFlowExample
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView, let data = dataInteractor.data else { return }
        cachedAttributes.removeAll()
        (cachedAttributes, contentBounds) = LayoutAttributesLoader.getAttributesFor2Columns(collectionView: collectionView,
                                                                                       data: data)
    }
    /// - Tag: CollectionViewContentSize
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }

    // MARK: Attributes for Updated Items

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else { return nil }

        if !deletingIndexPaths.isEmpty {
            if deletingIndexPaths.contains(itemIndexPath) {

                attributes.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                attributes.alpha = 0.0
                attributes.zIndex = 0
            }
        }

        return attributes
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }

        if insertingIndexPaths.contains(itemIndexPath) {
            attributes.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            attributes.alpha = 0.0
            attributes.zIndex = 0
        }

        return attributes
    }

    // MARK: Updates

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)

        for update in updateItems {
            switch update.updateAction {
            case .delete:
                guard let indexPath = update.indexPathBeforeUpdate else { return }
                deletingIndexPaths.append(indexPath)
            case .insert:
                guard let indexPath = update.indexPathAfterUpdate else { return }
                insertingIndexPaths.append(indexPath)
            default:
                break
            }
        }
    }

    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()

        deletingIndexPaths.removeAll()
        insertingIndexPaths.removeAll()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()

        // Find any cell that sits within the query rect.
        guard let lastIndex = cachedAttributes.indices.last,
            let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }

        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }

        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }

        return attributesArray
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }

    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }

        let mid = (start + end) / 2
        let attr = cachedAttributes[mid]

        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
}
