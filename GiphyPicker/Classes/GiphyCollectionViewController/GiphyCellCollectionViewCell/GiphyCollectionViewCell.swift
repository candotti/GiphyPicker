//
//  GiphyCellCollectionViewCell.swift
//  GiphyPicker
//
//  Created by daniele candotti on 29/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit
import SDWebImage

let GiphyCollectionViewCellId = "GiphyCollectionViewCellId"

final class GiphyCollectionViewCell: UICollectionViewCell {

    /// Giphy imageView
    @IBOutlet weak var imageView: UIImageView!

    /// Sets the gif to imageView
    func addGifToImageViewWithUrl(_ url: URL) {
        let cache = GiphyPicker.sharedImageCache
        if let image = cache.imageFromCache(forKey: url.absoluteString) {
            imageView.image = image
        } else {
            imageView.sd_setImage(with: url) { (image, error, cacheType, _url) in
                self.imageView.image = image
                cache.store(image, forKey: url.absoluteString, completion: nil)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.sd_cancelCurrentImageLoad()
    }
}
