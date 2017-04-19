//
//  StatusDriver.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 3/13/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Driver {
    
    private var _job : String?
    private var _status : String?
    private var _date : String?
    private var _name : String?
    
    var results: [Driver] = []
    
    
    var job : String{
        return _job!
    }
    var status : String {
        return _status!
    }
    var date : String {
        return _date!
    }
    
    var name : String{
        return _name!
    }
    
    init(job : String , status :String,date : String , name : String) {
        self._status = status
        self._job = job
        self._date = date
        self._name = name
        
    }
    
    
    
    
    
}

