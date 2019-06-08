//
//  LayoutAttributesLoader.swift
//  GiphyPicker
//
//  Created by daniele candotti on 02/06/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import UIKit

struct LayoutAttributesLoader {
    /// Gets the attribute for 2 columns
    static func getAttributesFor2Columns(collectionView: UICollectionView,
                                    data: [GiphyInfo],
                                    maxCellWidth: CGFloat = 200.0,
                                    margin: CGFloat = 5.0 ) ->
        (layoutAttributes: [UICollectionViewLayoutAttributes], rect: CGRect) {

        var attributesArray = [UICollectionViewLayoutAttributes]()
        var contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        let maxNumColumns: CGFloat = 2
        let availableWidth = collectionView.frame.size.width - (margin * maxNumColumns * 2.0)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        let count = collectionView.numberOfItems(inSection: 0)
        var lastFrameSx: CGRect = .zero
        var lastFrameDx: CGRect = .zero
        for n in 0..<count {
            let indexPath = IndexPath(item: n, section: 0)
            var rect = CGRect.zero
            let height = (cellWidth / maxCellWidth) * data[n].size.height
            if n % 2 == 0 {
                //SX
                rect = CGRect(x: margin, y: lastFrameSx.maxY + margin, width: cellWidth, height: height)
                lastFrameSx = rect
            } else {
                //DX
                rect = CGRect(x: lastFrameSx.maxX + margin, y: lastFrameDx.maxY + margin, width: cellWidth, height: height)
                lastFrameDx = rect
            }
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = rect
            attributesArray.append(attributes)
            contentBounds = contentBounds.union(rect)
        }
        return (attributesArray, contentBounds)
    }
}
