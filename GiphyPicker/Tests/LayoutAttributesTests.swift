//
//  LayoutAttributesTests.swift
//  GiphyPickerTests
//
//  Created by daniele candotti on 02/06/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import XCTest

@testable import GiphyPicker

class LayoutAttributesTests: XCTestCase {

    func testLoadCacheAttributesShouldReturnRightDataCount() {
        let rect = CGRect(x: 0, y: 0, width: 600, height: 1000)
        let collectionView = CollectionViewMock(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        let data = [GiphyInfo(url: "", size: CGSize(width: 200, height: 200)),
                    GiphyInfo(url: "", size: CGSize(width: 200, height: 200)),
                    GiphyInfo(url: "", size: CGSize(width: 200, height: 200)),
                    GiphyInfo(url: "", size: CGSize(width: 200, height: 200)),
                    GiphyInfo(url: "", size: CGSize(width: 200, height: 200))]
        collectionView.numberOfItems = data.count
        let result = LayoutAttributesLoader.getAttributesFor2Columns(collectionView: collectionView,
                                                                              data: data,
                                                                              maxCellWidth: 200,
                                                                              margin: 5.0)
        XCTAssertEqual(result.layoutAttributes.count, data.count)
    }
    
    func testLayoutAttributesShouldReturnCorrectBoundingRect() {
        let rect = CGRect(x: 0, y: 0, width: 500, height: 0)
        let collectionView = CollectionViewMock(frame: rect,
                                                collectionViewLayout: UICollectionViewFlowLayout())
        var data = Array<GiphyInfo>()
        for _ in 0..<100 {
            data.append(GiphyInfo(url: "", size: CGSize(width: 100, height: 100)))
        }
        collectionView.numberOfItems = data.count
        let result = LayoutAttributesLoader.getAttributesFor2Columns(collectionView: collectionView,
                                                                data: data,
                                                                maxCellWidth: 200,
                                                                margin: 5.0)
        let marginSum = 5.0 * CGFloat(data.count) / 2.0
        let numberOfRows = CGFloat(data.count / 2 + (data.count % 2 ))
        XCTAssertEqual(result.rect.size.height, (120.0 * numberOfRows) + marginSum )
    }
    
    func testLoadAttributesPerformanceWith10000Items() {
        self.measure {
            loadAttributes(numberOfItems: 10000)
        }
    }
    
    fileprivate func loadAttributes(numberOfItems: Int) {
        // Put the code you want to measure the time of here.
        let rect = CGRect(x: 0, y: 0, width: 500, height: 0)
        let collectionView = CollectionViewMock(frame: rect,
                                                collectionViewLayout: UICollectionViewFlowLayout())
        var data = Array<GiphyInfo>()
        for _ in 0..<numberOfItems {
            data.append(GiphyInfo(url: "", size: CGSize(width: 100, height: 100)))
        }
        collectionView.numberOfItems = data.count
        _ = LayoutAttributesLoader.getAttributesFor2Columns(collectionView: collectionView,
                                                          data: data,
                                                          maxCellWidth: 200,
                                                          margin: 5.0)
    }
}

final class CollectionViewMock: UICollectionView {
    var numberOfItems: Int!
    override func numberOfItems(inSection section: Int) -> Int {
        return numberOfItems
    }
}
