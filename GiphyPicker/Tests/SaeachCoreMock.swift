//
//  SaeachCoreMock.swift
//  GiphyPickerTests
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import GiphyCoreSDK
@testable import GiphyPicker

struct SearchCoreMock: Searchable {
    var media = [GPHMedia("1221", type: .gif, url: "https://giphy.com/gifs/leroypatterson-cat-glasses-CjmvTCZf2U3p09Cn0h")]
    func search(query: String, limit: Int, offset: Int, success: (([GPHMedia]?) -> Void)?, failure: ((String) -> Void)?) {
        success?(media)
    }
}
