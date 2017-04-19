//
//  Status.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 12/14/16.
//  Copyright © 2016 amirs.eu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Maid {
    
    private var _job : String?
    private var _status : String?
    private var _date : String?
    private var _name : String?
    
    var results: [Maid] = []

    
    var job : String{
        return _job!
    }
    var status : String {
        return _status!
    }
    var date : String {
        return _date!
    }
    
    var update : String{
        return _name!
    }
    
    init(job : String , status :String,date : String , update : String) {
        self._status = status
        self._job = job
        self._date = date
        self._name = update
    
    }
    
    

    
    
       }
    
