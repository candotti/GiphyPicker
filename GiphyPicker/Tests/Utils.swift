//
//  Utils.swift
//  GiphyPicker-Unit-UnitTests
//
//  Created by daniele candotti on 11/06/2019.
//

import Foundation

@testable import GiphyPicker

struct TestsUtils {
    static func getDataInteractor() -> DataInteractor {
        let searchCore = SearchCoreMock()
        let dataRetrival = DataRetrival(searchCore: searchCore)
        let dataInteractor = DataInteractor(dataRetrival: dataRetrival)
        return dataInteractor
    }
}
