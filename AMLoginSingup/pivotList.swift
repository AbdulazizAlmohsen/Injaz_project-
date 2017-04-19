//
//  pivotList.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 3/14/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import Foundation
import ObjectMapper

class PivotList : Mappable {
    
    
    var type : String
 
    required init?(map: Map) {
        
        type = "type"
      
    }
    
    func mapping(map: Map) {
        
        type      <- map["type"]
 
    }
}
