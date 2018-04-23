# Gem
An extreme light weight system with high performance for managing all http request with automated parser with modal calls in app with closure

[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Xcode 9.2](https://img.shields.io/badge/Xcode-9.2-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![Gemnasium](https://img.shields.io/gemnasium/mathiasbynens/he.svg)]()
[![Ratting](https://img.shields.io/amo/rating/dustman.svg)]()
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()


Managing all http request with automated modal parser calls in app with closure

## Requirements

* iOS 10.0+
* Swift 4.1+
* Xcode 9.2+

## Installation

### CocoaPods

Task is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!

pod "Gem"
```

or

```ruby
use_frameworks!

pod 'Gem', git: 'https://github.com/Albinzr/Gem', :tag => '1.0.2'

```

### Carthage

To integrate Task into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "Albinzr/Gem"
```

## Example


### Basics - Get Request

```swift
        Gem.request(url: "https://jsonplaceholder.typicode.com/uses", method: Methods.get, model:User.self, Success: { (data, response) in
            
            print(data,response)
            print("success")
            
        }) { (error, response) in
            
            print(error,response)
            
        }

```
