//
//  GiphyListCollectionViewDataSource.swift
//  GiphyPicker
//
//  Created by daniele candotti on 29/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit
import GiphyCoreSDK

/// CollectionView DataSource 
final class GiphyPickerCollectionViewDataSource: NSObject {
    
    /// Data interactor
    private var dataInteractor: DataInteractable

    init(dataInteractor: DataInteractable) {
        self.dataInteractor = dataInteractor
    }
}

extension GiphyPickerCollectionViewDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = dataInteractor.data else {
            return 0
        }
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCollectionViewCellId,
                                                      for: indexPath) as! GiphyCollectionViewCell
        guard let data = dataInteractor.data, data.count > indexPath.row else {
            return cell
        }
        let urlString = data[indexPath.row].url
        if let url = URL(string: urlString) {
            cell.addGifToImageViewWithUrl(url)
        }
        return cell
    }
}
