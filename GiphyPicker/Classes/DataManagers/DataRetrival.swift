//
//  DataRetrival.swift
//  GiphyPicker
//
//  Created by daniele candotti on 29/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import UIKit
import GiphyCoreSDK

protocol DataRetrivable {
    var limit: Int { get set }
    var query: String { get set }
    var offset: Int { get set }
    func getData(query: String,
                 limit: Int,
                 offset: Int,
                 success: (([GPHMedia]?) -> Void)?,
                 failure: ((String) -> Void)?)
    mutating func getMore(success: (([GPHMedia]?) -> Void)?,
                              failure: ((String) -> Void)?)
    mutating func search(query: String, success: (([GPHMedia]?) -> Void)?, failure: ((String) -> Void)?)
}

struct DataRetrival {
    var limit: Int
    private var queryValue = ""
    var query: String {
        set {
            offset = 0
            queryValue = newValue
        }
        get { return queryValue }
    }
    var offset: Int
    let incrementalOffset = GiphyPickerConfig.requests.maxItemsOnRequest
    var searchCore: Searchable

    init(searchCore: Searchable) {
        self.searchCore = searchCore
        self.limit = incrementalOffset
        self.offset = 0
    }
}

extension DataRetrival: DataRetrivable {

    func getData(query: String, limit: Int, offset: Int = 0,
                 success: (([GPHMedia]?) -> Void)?,
                 failure: ((String) -> Void)?) {

        searchCore.search(query: query,
                          limit: limit,
                          offset: offset,
                          success: success,
                          failure: failure)
    }

    mutating func search(query: String, success: (([GPHMedia]?) -> Void)?, failure: ((String) -> Void)?) {
        self.query = query
        getData(query: query, limit: limit, offset: offset, success: success, failure: failure)
        offset = incrementalOffset
    }

    mutating func getMore(success: (([GPHMedia]?) -> Void)?,
                              failure: ((String) -> Void)?) {
        getData(query: self.query, limit: limit, offset: offset, success: success, failure: failure)
        offset += incrementalOffset
    }
}
