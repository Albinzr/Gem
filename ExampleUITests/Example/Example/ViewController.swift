//
//  ViewController.swift
//  Example
//
//  Created by Albin CR on 4/21/18.
//  Copyright © 2018 CR-creation.SwiftyHttp. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyHttp


class Test:Codable{
    
    var origin:String?
    var url:String?
    
}

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SwiftyHttp.request(url: "https://httpbin.org/get", method: Methods.GET, model:Test.self, Success: { (data, response) in
            
            print(data,response)
            print("success")
            
        }) { (error, response) in
            
            print(error,response)
            
        }

    }
}
