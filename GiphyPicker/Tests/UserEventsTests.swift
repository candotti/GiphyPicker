//
//  UserEventsTests.swift
//  GiphyPicker-Unit-UnitTests
//
//  Created by daniele candotti on 11/06/2019.
//

import XCTest

@testable import GiphyPicker

class UserEventsTests: XCTestCase {
    
    func testUserTapOnCollectionViewCellShouldCallOnTapEvent() {
        let exp = expectation(description: #function)
        let dataInteractor = TestsUtils.getDataInteractor()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        let userInteractor = GiphyCollectionViewUserInteractor(dataInteractor: dataInteractor)
        userInteractor.onTapOnCollectionViewCell = { giphy in
            exp.fulfill()
        }
        userInteractor.collectionView(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        wait(for: [exp], timeout: 0.1)
    }
}
