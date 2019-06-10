//
//  NavigationBuilder.swift
//  GiphyPicker
//
//  Created by daniele candotti on 31/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit
import GiphyCoreSDK
import SDWebImage
/// NavigationBuilder builds controller for the navigation
public struct GiphyPicker {
    
    static let sharedImageCache = SDImageCache(namespace: "com.candotti.giphyPicker")
    
    public static func defaultConfig(token: String) {
        GiphyCore.configure(apiKey: token)
        GiphyPicker.sharedImageCache.config.maxDiskSize = GiphyPicker.defaults.gifsCache.maxDiskSize
        GiphyPicker.sharedImageCache.config.maxMemoryCount = GiphyPicker.defaults.gifsCache.maxMemoryCount
    }
    
    struct defaults {
        struct requests {
            static let maxItemsOnRequest = 20
            static let lastIndexPathToMakeNewRequest = 4
        }
        struct gifsCache {
            static let maxDiskSize: UInt = 1000000 * 20
            static let maxMemoryCount: UInt = 130
        }
    }
    
    /// Build the rootViewController
    public static func getViewController() -> UIViewController {
        assert(GiphyPicker.giphyCoreHasCredentials(), "Api key is missing - use Giphy.configure(apiKey:)")
        let searchBarInteractor = SearchBarInteractor()
        let searchCore = SearchCore()
        let dataRetrival = DataRetrival(searchCore: searchCore)
        let dataInteractor = DataInteractor(dataRetrival: dataRetrival)
        let collectionViewHandler = GiphyCollectionViewHandler()
        let controller = GiphyListViewController(dataInteractor: dataInteractor,
                                                 searchBarInteractor: searchBarInteractor,
                                                 collectionViewHandler: collectionViewHandler)
        dataInteractor.onNewSearchFinished = { [weak controller] in
            DispatchQueue.main.async {
                controller?.reloadForNewSearch()
            }
        }
        dataInteractor.onLoadMoreFinished = { [weak controller] (numberOfNewItems) in
            DispatchQueue.main.async {
                controller?.addNewItems(itemsCount: numberOfNewItems)
            }
        }
        collectionViewHandler.onPresentingLastItems = {
            dataInteractor.getMore(success: { [weak collectionViewHandler] (_) in
                collectionViewHandler?.isLoading = false
                }, failure: { (errorMessage) in
                DispatchQueue.main.async {
                    controller.showAlert(message: errorMessage)
                }
            })
        }

        searchBarInteractor.onChangeText = { [weak dataInteractor] string in
            dataInteractor?.search(query: string, success: nil, failure: { (errorMessage) in
                DispatchQueue.main.async {
                    controller.showAlert(message: errorMessage)
                }
            })
        }
        return controller
    }
    
    private static func giphyCoreHasCredentials() -> Bool {
        return GiphyCore.shared.apiKey.count > 0
    }
}
