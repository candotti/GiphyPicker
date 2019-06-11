//
//  Config.swift
//  GiphyPicker
//
//  Created by daniele candotti on 31/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation

public struct GiphyPickerConfig {
    
    struct requests {
        static let maxItemsOnRequest = 20
        static let lastIndexPathToMakeNewRequest = 4
    }
    struct gifsCache {
        static let maxDiskSize: UInt = 1000000 * 20
        static let maxMemoryCount: UInt = 130
    }
}
