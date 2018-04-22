//
//  User.swift
//  SwiftyHttp
//
//  Created by Albin CR on 4/22/18.
//  Copyright © 2018 CR-creation.SwiftyHttp. All rights reserved.
//

import Foundation

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

class Address:Codable{
    
    var street:String?
    var suite:String?
    var city:String?
    var zipcode:String?
    var geo:Geo?
    class Geo:Codable{
        var lat:String?
        var lng:String?
        
    }
}

class Company:Codable{
    
    var name:String?
    var catchPhrase:String?
    var bs:String?
}
