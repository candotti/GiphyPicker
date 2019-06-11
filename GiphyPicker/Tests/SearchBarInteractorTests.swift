//
//  SearchBarInteractorTests.swift
//  GiphyPickerTests
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import XCTest
@testable import GiphyPicker

class SearchBarInteractorTests: XCTestCase {
    
    func testSearchBarShouldCallOnChangeTextWhileTextIsEditing() {
        let exp = expectation(description: #function)
        let searchBar = SearchBarInteractor()
        let SUTstring = "Ciao"
        searchBar.onChangeText = { string in
            XCTAssertEqual(string, SUTstring)
            exp.fulfill()
        }
        searchBar.searchBar(UISearchBar(), textDidChange: SUTstring)
        wait(for: [exp], timeout: 0.1)
    }
}
