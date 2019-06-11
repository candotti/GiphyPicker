//
//  GiphyCollectionViewUserInteractable.swift
//  GiphyPicker
//
//  Created by daniele candotti on 11/06/2019.
//

import Foundation

/// User events interactions with the collectionview
protocol GiphyCollectionViewUserInteractable {
    /// Called when the user tap on the collectionView cell
    var onTapOnCollectionViewCell: ((GiphyInfo?) -> ())? { get set }
}
