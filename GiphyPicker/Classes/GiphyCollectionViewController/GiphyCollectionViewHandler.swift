//
//  GiphyCollectionViewCustomFlowLayout.swift
//  GiphyPicker
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit

typealias CollectionViewInteractable = CollectionViewEndlessLoading & UICollectionViewDelegateFlowLayout

protocol CollectionViewEndlessLoading {
    
    var isLoading: Bool { get set }
    var onPresentingLastItems: (() -> Void)? { get set }
}

/// Manage CollectionViewEndlessLoading & UICollectionViewDelegateFlowLayout implementations
final class GiphyCollectionViewHandler: NSObject, CollectionViewEndlessLoading {
    
    /// On last items presented
    var onPresentingLastItems: (() -> Void)?
    /// It is loading new data
    var isLoading: Bool = false
}

extension GiphyCollectionViewHandler: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isLoading == false else {
            return
        }

        if indexPath.row >= collectionView.numberOfItems(inSection: 0) - GiphyPickerConfig.requests.lastIndexPathToMakeNewRequest {
            onPresentingLastItems?()
            isLoading = true
        }
    }
}
