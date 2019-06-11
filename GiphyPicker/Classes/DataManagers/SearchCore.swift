//
//  SearchCore.swift
//  GiphyPicker
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import GiphyCoreSDK

typealias SearchableValues =  (query: String, limit: Int,
                              offset: Int,
                              success: (([GPHMedia]?) -> Void)?,
                              failure: ((String) -> Void)?)
public protocol Searchable {

    func search(query: String,
                limit: Int,
                offset: Int,
                success: (([GPHMedia]?) -> Void)?,
                failure: ((String) -> Void)? )
}

struct SearchCore: Searchable {

    func search(query: String,
                limit: Int,
                offset: Int,
                success: (([GPHMedia]?) -> Void)?,
                failure: ((String) -> Void)? ) {

        GiphyCore.shared.search(query, offset: offset, limit: limit) { (response, error) in
            if let error = error as NSError? {
                failure?(error.localizedDescription)
                return
            }

            if let response = response, let data = response.data {
                success?(data)
            } else {
                failure?("No Results Found")
            }
        }
    }
}
