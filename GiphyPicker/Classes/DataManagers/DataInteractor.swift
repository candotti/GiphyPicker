//
//  DataInteractor.swift
//  GiphyPicker
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import GiphyCoreSDK

protocol DataInteractable {

    var onNewSearchFinished: (() -> Void)? { get set }
    var onLoadMoreFinished: ((Int) -> Void)? { get set }
    var data: [GiphyInfo]? { get set }
    func search(query: String, success: (([GiphyInfo]?) -> Void)?,
                failure: ((String) -> Void)?)
    func getMore(success: (([GiphyInfo]?) -> Void)?,
                 failure: ((String) -> Void)?)
}

public struct GiphyInfo {
    public let url: String
    public let size: CGSize
}
/// Layer to manage data from DataRetrival
final class DataInteractor: DataInteractable {

    var data: [GiphyInfo]?
    var dataRetrival: DataRetrivable
    var onNewSearchFinished: (() -> Void)?
    var onLoadMoreFinished: ((Int) -> Void)?

    init(dataRetrival: DataRetrivable) {
        self.dataRetrival = dataRetrival
    }

    func search(query: String, success: (([GiphyInfo]?) -> Void)?, failure: ((String) -> Void)?) {
        dataRetrival.search(query: query, success: { [weak self] (results) in
            if let data = results?.compactMap({ (media) -> GiphyInfo? in
                guard let images = media.images, let image = images.fixedWidthDownsampled, let url = image.gifUrl else {
                    return nil
                }
                return GiphyInfo(url: url, size: CGSize(width: image.width, height: image.height))
            }) {
                self?.data = data
                self?.onNewSearchFinished?()
                success?(data)
            }
        }, failure: failure)
    }

    func getMore(success: (([GiphyInfo]?) -> Void)?,
                          failure: ((String) -> Void)?) {
        dataRetrival.getMore(success: { [weak self] (results) in
            if let data = results?.compactMap({ (media) -> GiphyInfo? in
                guard let images = media.images, let image = images.fixedWidthDownsampled, let url = image.gifUrl else {
                    return nil
                }
                return GiphyInfo(url: url, size: CGSize(width: image.width, height: image.height))
            }) {
                self?.data? += data
                self?.onLoadMoreFinished?(data.count)
                success?(data)
            }
        }, failure: failure)
    }
}
