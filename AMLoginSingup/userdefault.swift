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
    static let token  = "token"
    static let username  = "empty"
    static let user_national_id  = "empty"
    static let user_street  = "empty"
    static let user_nigborhood  = "empty"
    static let user_email  = "empty"
    static let user_city  = "empty"
    static let user_phone  = "empty"
    static let user_house_size  = "empty"
    
}


class UserDataSingleton
{
    static let sharedDataContainer = UserDataSingleton()
    init() {
        let defaults = UserDefaults.standard
        
        
        self.token = defaults.object(forKey:DefaultsKey.token) as? String
        self.username = defaults.object(forKey:DefaultsKey.username) as? String
        self.user_national_id = defaults.object(forKey:DefaultsKey.user_national_id) as? String
        self.user_street = defaults.object(forKey:DefaultsKey.user_street) as? String
        self.user_nigborhood = defaults.object(forKey:DefaultsKey.user_nigborhood) as? String
        self.user_email = defaults.object(forKey:DefaultsKey.user_email) as? String
        self.user_city = defaults.object(forKey:DefaultsKey.user_city) as? String
        self.user_phone = defaults.object(forKey:DefaultsKey.user_phone) as? String
        self.user_house_size = defaults.object(forKey:DefaultsKey.user_house_size) as? String
        
   
        
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
    
    
    
    
}
