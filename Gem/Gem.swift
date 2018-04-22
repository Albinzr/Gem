//
//  Gem.swift
//  Gem
//
//  Created by Albin CR on 4/21/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//


import Foundation

public enum Methods:String{
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public func request<T:Codable>(url:String,method:Methods,model:T.Type,Success:@escaping ( _ data:[T], _ urlResponse:URLResponse?) -> (),Error:@escaping ( _ error:Error?,  _ urlResponse:URLResponse?) ->()){
    // 1. create url
    let newURL = URL(string: url)!
    var request = URLRequest(url: newURL)
    request.httpMethod = method.rawValue
    // 2. create URLSession()
    let configuration = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: configuration)
    // 3.create Task
    let task = urlSession.dataTask(with: request) { (data, response, error) in
        DispatchQueue.main.async {
            if error != nil {
                Error(error, response)
                return
            }
            
            if let recivedData = data{
                parserUserDetails(data: recivedData, model: model, Success: { (modelData) in
                    Success(modelData, response)
                }, Error: { (parserError) in
                    Error(parserError,response)
                })
                return
            }else{
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to retrive data"]) as Error
                Error(error, response)
                return
            }
            
            
        }
    }
    task.resume()
}



