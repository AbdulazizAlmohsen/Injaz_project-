//
//  MappingDriver.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 3/14/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import Foundation
import ObjectMapper

class Driverj : Mappable {

   
    
    
    var status : String?
    var name : String?
    var created_at : String?
    
    required init?(map: Map) {
    }
    required init(name: String , status : String , created_at : String )  {
        self.status = status
        self.name = name
        self.created_at = created_at
        
        
        
    }
    func mapping(map: Map) {
        
        status      <- map["status"]
        name             <- map["name"]
        created_at            <- map["created_at"]
    }
}
