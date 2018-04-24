//
//  ViewController.swift
//  Example
//
//  Created by Albin CR on 4/21/18.
//  Copyright © 2018 CR-creation.SwiftyHttp. All rights reserved.
//

import UIKit
import Gem

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
//        postData()
        uploadImage()
    }
    
    func getData(){
        Gem.request(url: "https://jsonplaceholder.typicode.com/users", method: Methods.get,parameter:nil,header:nil, model:User.self, Success: { (data, response) in
            
            print(data,response ?? "")
            print("success")
            
        }) { (error, response) in
            
            print(error ?? "",response!.statusCode)
            
        }
    }
    
    func postData(){
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
    }
    
    func uploadImage(){
        
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
        
        Gem.request(url: "https://api.imgur.com/3/image", method: Methods.post,parameter:param,header:header, model:ImageUpload.self, Success: { (data, response) in
            
            print(data,response ?? "")
            print("success")
            
        }) { (error, response) in
            
            print(error ?? "",response!.statusCode)
            
        }
    }
}
