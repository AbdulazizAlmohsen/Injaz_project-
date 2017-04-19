//
//  userdefault.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/22/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//
// sent info to database 


import Foundation


struct DefaultsKey
{
    static let dateArray = [""]
    static let token  = "token"
    static let username  = "username"
    static let user_national_id  = "رقم بطاقه الاحوال"
    static let user_street  = "user_street"
    static let user_nigborhood  = "user_nigborhood"
    static let user_email  = "user_email"
    static let user_city  = "user_city"
    static let user_phone  = "user_phone"
    static let user_house_size  = "user_house_size"
    static let from_time = "from_time"
    static let to_time = "to_time"
    static let from_date = "from_date"
    static let to_date = "to_date"
    static let region = "region"
    static let isGuest = "guest"

    
}


class UserDataSingleton
{
    static let sharedDataContainer = UserDataSingleton()
    init() {
        let defaults = UserDefaults.standard
        
        self.is_guest = defaults.object(forKey:DefaultsKey.isGuest) as? String

        self.token = defaults.object(forKey:DefaultsKey.token) as? String
        self.username = defaults.object(forKey:DefaultsKey.username) as? String
        self.user_national_id = defaults.object(forKey:DefaultsKey.user_national_id) as? String
        self.user_street = defaults.object(forKey:DefaultsKey.user_street) as? String
        self.user_nigborhood = defaults.object(forKey:DefaultsKey.user_nigborhood) as? String
        self.user_email = defaults.object(forKey:DefaultsKey.user_email) as? String
        self.user_city = defaults.object(forKey:DefaultsKey.user_city) as? String
        self.user_phone = defaults.object(forKey:DefaultsKey.user_phone) as? String
        self.user_house_size = defaults.object(forKey:DefaultsKey.user_house_size) as? String
        
        self.from_time = defaults.object(forKey:DefaultsKey.from_time) as? String
        self.to_time = defaults.object(forKey:DefaultsKey.to_time) as? String
        self.from_date = defaults.object(forKey:DefaultsKey.from_date) as? String
        self.to_date = defaults.object(forKey:DefaultsKey.to_date) as? String
        self.region = defaults.object(forKey:DefaultsKey.region) as? String


        
   
        
    }
    var is_guest : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(is_guest, forKey:DefaultsKey.isGuest)
            
        }
    }

    var to_date : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(to_date, forKey:DefaultsKey.to_date)
            
        }
    }
    
    var from_date : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(from_date, forKey:DefaultsKey.from_date)
            
        }
    }
    
    var to_time : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(to_time, forKey:DefaultsKey.to_time)
            
        }
    }
    
    var from_time : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(from_time, forKey:DefaultsKey.from_time)

        }
    }
 
    var token: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(token, forKey:DefaultsKey.token)
        }
        
        
    }
    
    
    var username: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(username, forKey:DefaultsKey.username)
        }
    }
    var user_national_id: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_national_id, forKey:DefaultsKey.user_national_id)
        }
    }
    var user_street: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_street, forKey:DefaultsKey.user_street)
        }
    }
    var user_nigborhood: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_nigborhood, forKey:DefaultsKey.user_nigborhood)
        }
    }
    var user_email: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_email, forKey:DefaultsKey.user_email)
        }
    }
    var user_city: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_city, forKey:DefaultsKey.user_city)
        }
    }
    var user_phone: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_phone, forKey:DefaultsKey.user_phone)
        }
    }
    var user_house_size: String? {
        didSet {
            
            let defaults = UserDefaults.standard
            defaults.set(user_house_size, forKey:DefaultsKey.user_house_size)
        }
    }
    var region : String?{
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(region, forKey:DefaultsKey.region)
            
        }
    }
   
    
    
    
    
}
