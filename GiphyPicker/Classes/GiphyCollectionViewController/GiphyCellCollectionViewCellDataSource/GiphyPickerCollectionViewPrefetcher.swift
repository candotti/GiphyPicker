//
//  GiphyListCollectionViewPrefetcher.swift
//  GiphyPicker
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

let serialQueue = DispatchQueue(label: "com.GiphyPicker.prefetcher")

/// CollectionView prefetcher
final class GiphyPickerCollectionViewPrefetcher: NSObject {

    /// Data interactor
    private var dataInteractor: DataInteractable

    init(dataInteractor: DataInteractable) {
        self.dataInteractor = dataInteractor
    }
}

extension GiphyPickerCollectionViewPrefetcher: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            serialQueue.async {
                guard let data = self.dataInteractor.data else {
                    return
                }
                let urlString = data[indexPath.row].url
                if let url = URL(string: urlString) {
                    self.prefetchURLs([url])
                }
            }
        }
    }

    private func prefetchURLs(_ URLs: [URL]) {
        //TODO: Implement prefetcher
    }
}
