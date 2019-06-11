//
//  DataRetrivalTests.swift
//  GiphyPickerTests
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import XCTest
import GiphyCoreSDK
@testable import GiphyPicker

class DataRetrivalTests: XCTestCase {
    
    var dataRetrival: DataRetrival?
    func testDataRetrivalShouldChangeOffset() {
        let searchCore = SearchCoreMock()
        var dataRetrival = DataRetrival(searchCore: searchCore)
        dataRetrival.search(query: "cat", success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset)
        dataRetrival.getMore(success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset * 2)
        dataRetrival.getMore(success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset * 3)
    }
    
    func testDataRetrivalCallSearchShouldSetTheOffset() {
        let searchCore = SearchCoreMock()
        var dataRetrival = DataRetrival(searchCore: searchCore)
        dataRetrival.search(query: "cat", success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset)
        dataRetrival.getMore(success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset * 2)
        dataRetrival.search(query: "cat", success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset)
    }
    
    func testDataRetrivalSetNewQueryShouldResetOffset() {
        let searchCore = SearchCoreMock()
        var dataRetrival = DataRetrival(searchCore: searchCore)
        dataRetrival.search(query: "cat", success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset)
        dataRetrival.getMore(success: nil, failure: nil)
        XCTAssertEqual(dataRetrival.offset, dataRetrival.incrementalOffset * 2)
        dataRetrival.query = "dog"
        XCTAssertEqual(dataRetrival.offset, 0)
    }

}


