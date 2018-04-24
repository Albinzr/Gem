//
//  Jsonparser.swift
//  Gem
//
//  Created by Albin CR on 4/22/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import Foundation

func parserJsonToModel<T:Codable>(data:Data,model:T.Type,Success:@escaping ( _ data:[T])->(),Error:@escaping ( _ error:Error?)->()){
    
    //1 create decoder
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    //2 parse data
//    var model:[T] = []
    
    do {

        if let model:[T] = try? decoder.decode([T].self, from: data){
            Success(model)
        } else{
            let model:[T] = [try decoder.decode(T.self, from: data)]
            Success(model)
        }

        return
    }
    catch DecodingError.valueNotFound(let key, let details){
        let valueNotFoundError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "key: \(key),errorMessage: \(details.debugDescription),more details: \(String(describing: details.underlyingError))"]) as Error
        Error(valueNotFoundError)
        return
    }catch DecodingError.typeMismatch(let key, let details){
        let typeMismatchError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "key: \(key),errorMessage: \(details.debugDescription),more details: \(String(describing: details.underlyingError))"]) as Error
        Error(typeMismatchError)
        return
    }catch DecodingError.keyNotFound(let key, let details){
        let keyNotFoundError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "key: \(key),errorMessage: \(details.debugDescription),more details: \(String(describing: details.underlyingError))"]) as Error
        Error(keyNotFoundError)
        return
    }catch{
        let jsonConvertError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "unable to convert json to model"]) as Error
        Error(jsonConvertError)
        return
    }
    
}
//func parseStringToJson(data:Any){
//    let stringData = data as? String{
//
//    }
//}

func isMatching(regex: String,status: String) -> Bool {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: status,range: NSRange(status.startIndex..., in: status))
        if results.count > 0{
            return true
        }else{
            return false
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return false
    }
}

