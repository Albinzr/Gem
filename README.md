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

## Usage & Requirement
   1. All model class should have Codable protocol
   2. Naming for variable should be as follow
            ```swift
            //json
            {
                name:"Albin CR",
                published_on:123455,
                Time:"23.10"
                
             }
            // model class
            class Details:Codable{
                var name:String? // same variable as in json
                var publishedOn:ing? // incase of snake casing use camel casing of the same name
                var Time:String // same variable as in json
            }

## Example


### Get Request

```swift

//model

class User:Codable{
    
    var id:Int?
    var name:String?
    var username:String?
    var email:String?
    var address:Address?
    var phone:String?
    var website:String?
    var company:Company?
    
}

Gem.request(url: "https://jsonplaceholder.typicode.com/uses", method: Methods.get, model:User.self, 
    Success: { (data, response) in        
                 // success block
                print(data,response)
      
        }) { (error, response) in
              //error block
              print(error,response)
            
        }

```
response - contain all details related to network call like status code etc..


### Post Request

```swift

class User:Codable{
    
    var id:Int?
    var name:String?
    var username:String?
    var email:String?
    var address:Address?
    var phone:String?
    var website:String?
    var company:Company?
    
}

let param: [String : Any] = [
            "id":12324,
            "name":"Albin CR",
            "username":"Albi",
            "email":"albinzr@gmail.com",
            "phone":"8907575123",
            "website":"www.albin.in",
            "company":[
                "name":"Quin",
                "catchPhrase":"Time to change",
                "bs":"Pika",
            ]
        ]
        Gem.request(url: "https://jsonplaceholder.typicode.com/posts", method: Methods.post,parameter:param,header:nil, model:User.self, Success: { (data, response) in
            
            print(data,response ?? "")
            print("success")
            
        }) { (error, response) in
            
            print(error ?? "",response!.statusCode)
            
        }
        
```
### ImageUpload

```swift

class ImageUpload:Codable{
    
    var link:String?
    var width:Float?
    var height:Float?
    var id:String?
    
}

let image:UIImage = UIImage(named: "scan") // or image url 
        let imageData:Data = UIImagePNGRepresentation(image)!
        let base64Data =  imageData.base64EncodedString()
        
        let param:[String:Any] = [
            "image":base64Data
        ]
        
        let header:[String:String] = [
            "Authorization":"Client-ID {{your client key}}",//replace your client key
            "Content-type":"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'"
        ]
        
        Gem.request(url: "https://api.imgur.com/3/image", method: Methods.post,parameter:param,header:header,    model:ImageUpload.self, Success: { (data, response) in
            
            print(data,response ?? "")
            print("success")
            
        }) { (error, response) in
            
            print(error ?? "",response!.statusCode)
            
        }

```
#### PR are are always welcomed
