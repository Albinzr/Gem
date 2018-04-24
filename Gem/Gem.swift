//
//  Gem.swift
//  Gem
//
//  Created by Albin CR on 4/21/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//


import Foundation

let httpErrorPattern = "^(1|2|3)[0-9]*$"

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

public typealias ParameterError = (error:Error?, urlResponse:HTTPURLResponse?)
public typealias RequestError = ( _ error:Error?,  _ urlResponse:HTTPURLResponse?) -> ()
public typealias Success<T> = ( _ data:[T], _ urlResponse:HTTPURLResponse?) -> ()

public func request<T:Codable>(url:String,method:Methods,parameter:[String:Any]?,header:[String:String]?,model:T.Type,Success:@escaping Success<T>,Error:@escaping RequestError){
    //  create url
    guard let newURL  = URL(string: url)else{
        let urlError = NSError(domain: "", code: 0, userInfo:
            [NSLocalizedDescriptionKey : "url format is not correct"]) as Error
        Error(urlError,nil)
        return
    }
    
    // create request
    var request = URLRequest(url: newURL)
    request.httpMethod = method.rawValue
    
    //set parameter to request
    if let parameterError =  setParameter(request: &request, parameter: parameter){
        Error(parameterError.error,parameterError.urlResponse)
    }
    
    //set header to request
    setHeader(request:&request,header:header)
    
    // 2. create URLSession()
    let configuration = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: configuration)
    
    // 3.create Task
    let task = urlSession.dataTask(with: request) { (data, response, error) in
        
        let httpResponse = response as? HTTPURLResponse
        let status:String = String(httpResponse?.statusCode.description ?? "404")
        
        if isMatching(regex: httpErrorPattern, status: status){
            
            DispatchQueue.main.async {
                if error != nil {
                    Error(error, httpResponse)
                    return
                }
                if let recivedData = data{
                    parserJsonToModel(data: recivedData, model: model, Success: { (modelData) in
                        Success(modelData, httpResponse)
                    }, Error: { (parserError) in
                        Error(parserError,httpResponse)
                    })
                    return
                }else{
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to retrive data"]) as Error
                    Error(error, httpResponse)
                    return
                }
            }
        }else{
            let error = NSError(domain: "", code: Int(status) ?? 404, userInfo: [NSLocalizedDescriptionKey : "Unable to retrive data"]) as Error
            Error(error, httpResponse)
            return
        }
    }
    task.resume()
}


fileprivate func setParameter(request:inout URLRequest,parameter:[String:Any]?) -> ParameterError?{
    
    if let requestParameter = parameter{
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameter, options: .prettyPrinted)
        }
        catch let error{
            let parameterError = NSError(domain: "", code: 0, userInfo:
                [NSLocalizedDescriptionKey : "error in parameter passed, /\(error.localizedDescription)"]) as Error
            
            return (parameterError,nil)
        }
    }
    return nil
}

fileprivate func setHeader( request:inout URLRequest,header:[String:String]?){
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    header?.forEach { (headerDetail) in
        request.addValue(headerDetail.key, forHTTPHeaderField: headerDetail.value)
    }
}







