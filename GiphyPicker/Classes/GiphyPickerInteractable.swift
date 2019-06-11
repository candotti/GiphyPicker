//
//  GiphyPickerInteractable.swift
//  GiphyPicker
//
//  Created by daniele candotti on 11/06/2019.
//

import Foundation
import GiphyCoreSDK
    
/// GiphyPicker user events
public protocol GiphyPickerInteractable {
    /// Called when the user tap on the media
    var onTapOnMedia: ((GiphyInfo?) -> ())? { get set }
}
