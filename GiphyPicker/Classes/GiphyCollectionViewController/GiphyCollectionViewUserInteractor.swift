//
//  GiphyCollectionViewUserInteractor.swift
//  GiphyPicker
//
//  Created by daniele candotti on 11/06/2019.
//

import UIKit
import GiphyCoreSDK

class GiphyCollectionViewUserInteractor: NSObject, GiphyCollectionViewUserInteractable {
    
    /// DataInteractor
    private var dataInteractor: DataInteractable
    /// User did tap on media
    var onTapOnCollectionViewCell: ((GiphyInfo?) -> ())?
    
    init(dataInteractor: DataInteractable) {
        self.dataInteractor = dataInteractor
        super.init()
    }
}

extension GiphyCollectionViewUserInteractor: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = dataInteractor.data else {
            onTapOnCollectionViewCell?(nil)
            return
        }
        let giphyInfo = data[indexPath.row]
        onTapOnCollectionViewCell?(giphyInfo)
    }
}
