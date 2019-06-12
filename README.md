# GiphyPicker

<img src="ScreenShot_iPhoneX.png" height="400">

[![Version](https://img.shields.io/cocoapods/v/GiphyPicker.svg?style=flat)](https://cocoapods.org/pods/GiphyPicker)
[![License](https://img.shields.io/cocoapods/l/GiphyPicker.svg?style=flat)](https://cocoapods.org/pods/GiphyPicker)
[![Platform](https://img.shields.io/cocoapods/p/GiphyPicker.svg?style=flat)](https://cocoapods.org/pods/GiphyPicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8 or later
* Xcode 10 or later

## Installation

GiphyPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GiphyPicker'
```

## Usage
  ### Setup 

* Get a token from [Giphy website](http://giphy.com/)
* In the AppDelegate.swift add the token 
  ```
  GiphyPicker.defaultConfig(token: "<YourToken>")
  ```
### Present the picker
To present the picker modally you can the code as follows
```
let picker = GiphyPicker.getViewController()
present(picker, animated: true, completion: nil)
```

## Dependencies
 
* [GiphyCoreSDK](https://github.com/Giphy/giphy-ios-sdk-core)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)


## Author

Daniele Candotti, support-{AT}-candotti.info

## License

GiphyPicker is available under the MIT license. See the LICENSE file for more info.
