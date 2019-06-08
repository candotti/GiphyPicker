//
//  SearchBarInteractor.swift
//  GiphyPicker
//
//  Created by daniele candotti on 30/05/2019.
//  Copyright © 2019 daniele candotti. All rights reserved.
//

import Foundation
import UIKit

protocol SearchBarInteractable: UISearchBarDelegate {
    /// On text changed
    var onChangeText: ((String) -> Void)? { get set }
}

/// SearchBar Interactor
final class SearchBarInteractor: NSObject, SearchBarInteractable {

    var onChangeText: ((String) -> Void)?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onChangeText?(searchText)
    }
}
