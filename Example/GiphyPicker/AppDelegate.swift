//
//  AppDelegate.swift
//  GiphyPickerViewController
//
//  Created by Daniele Candotti on 06/06/2019.
//  Copyright (c) 2019 Daniele Candotti. All rights reserved.
//

import UIKit
import GiphyPicker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Get your token from ghiphy.com
        GiphyPicker.defaultConfig(token: "<YOUR TOKEN>")
        return true
    }
}

