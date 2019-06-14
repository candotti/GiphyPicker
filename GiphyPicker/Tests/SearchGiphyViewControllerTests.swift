//
//  GiphyPickerViewControllerTests.swift
//  GiphyPickerTests
//
//  Created by daniele candotti on 29/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import XCTest
import GiphyCoreSDK
import SDWebImage

@testable import GiphyPicker

class GiphyPickerViewControllerTests: XCTestCase {

    func testCollectionViewDataSourceSetup() {
        let dataInteractor = TestsUtils.getDataInteractor()
        dataInteractor.search(query: "Cat", success: nil, failure: nil)
        let dataSource = GiphyPickerCollectionViewDataSource(dataInteractor: dataInteractor)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1)
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), dataInteractor.data!.count)
        collectionView.register(UINib.init(nibName: "GiphyCollectionViewCell", bundle: Bundle(for: GiphyCollectionViewCell.self)), forCellWithReuseIdentifier: GiphyCollectionViewCellId)
        XCTAssertTrue(dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) is GiphyCollectionViewCell)
    }
    
    func testDataInteractorMustCallOnNewSearchFinished() {
        let exp = expectation(description: #function)

        let dataInteractor = TestsUtils.getDataInteractor()
        dataInteractor.onNewSearchFinished = {
            exp.fulfill()
        }
        dataInteractor.onLoadMoreFinished = { count in
            XCTFail("must call onNewSearchFinished instead")
        }
        dataInteractor.search(query: "Cat", success: { (results) in
            
        }) { (errorMessage) in
            XCTFail(errorMessage)
        }
        wait(for: [exp], timeout: 0.1)
    }
    
    func testDataInteractorMustCallOnLoadMoreFinished() {
        let exp = expectation(description: #function)
        let searchCore = SearchCoreMock()
        let dataRetrival = DataRetrival(searchCore: searchCore)
        let dataInteractor = DataInteractor(dataRetrival: dataRetrival)
        dataInteractor.onNewSearchFinished = {
            XCTFail("must call onLoadMoreFinished instead")
        }
        dataInteractor.onLoadMoreFinished = { count in
            exp.fulfill()
        }
        dataInteractor.getMore(success: nil) { (errorMessage) in
            XCTFail(errorMessage)
        }
        wait(for: [exp], timeout: 0.1)
    }
}
