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
        
        fetchData()
        
    }
    
    func fetchData(){
        Gem.request(url: "https://jsonplaceholder.typicode.com/uses", method: Methods.get, model:User.self, Success: { (data, response) in
            
            print(data,response)
            print("success")
            
        }) { (error, response) in
            
            print(error,response)
            
        }
    }
}
