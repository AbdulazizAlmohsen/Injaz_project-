//
//  DataContainerSingleton.swift
//  SwiftDataContainerSingleton
//
//  Created by Duncan Champney on 4/19/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit


/**
 This struct defines the keys used to save the data container singleton's properties to NSUserDefaults.
 This is the "Swift way" to define string constants.
 */
struct Keys
{
    
    // maid info
    // name if the pic
    static let id  = "id"
    static let pic  = "id"
    static let name  = "name"
    static let age  = "age"
    static let smoker  = "smoker"
    static let religon  = "religion"
    static let appearance  = "appearance"
    static let language  = "language"
    static let status = "status"
    static let experiance = "experiance"
    
    // user info
    
    
}

/**
 :Class:   DataContainerSingleton
 This class is used to save app state data and share it between classes.
 It observes the system UIApplicationDidEnterBackgroundNotification and saves its properties to NSUserDefaults before
 entering the background.
 
 Use the syntax `DataContainerSingleton.sharedDataContainer` to reference the shared data container singleton
 */

class DriverDataContainerSingleton
{
    static let sharedDataContainer = DriverDataContainerSingleton()
    
    //------------------------------------------------------------
    //Add properties here that you want to share accross your app
    
    // maid info
    var id: Int?
    var pic: String?
    var name: String?
    var smoker: String?
    var age: String?
    var religon: String?
    var appearance: String?
    var language: String?
    var status : String?
    var experiance : String?
    
    
    
    //------------------------------------------------------------
    
    var goToBackgroundObserver: AnyObject?
    
    init()
    {
        let defaults = UserDefaults.standard
        //-----------------------------------------------------------------------------
        //This code reads the singleton's properties from NSUserDefaults.
        //edit this code to load your custom properties
        
        // maids info
        id = defaults.object(forKey: Keys.id) as! Int?
        pic = defaults.object(forKey: Keys.pic) as! String?
        
        name = defaults.object(forKey: Keys.name) as! String?
        age = defaults.object(forKey: Keys.age) as! String?
        smoker = defaults.object(forKey: Keys.smoker) as! String?
        religon = defaults.object(forKey: Keys.religon) as! String?
        appearance = defaults.object(forKey: Keys.appearance) as! String?
        language = defaults.object(forKey: Keys.language) as! String?
        status = defaults.object(forKey: Keys.status) as! String?
        experiance = defaults.object(forKey: Keys.experiance) as! String?
        

        
        
        //user info
        
        
        
        
        
        //-----------------------------------------------------------------------------
        
        //Add an obsever for the UIApplicationDidEnterBackgroundNotification.
        //When the app goes to the background, the code block saves our properties to NSUserDefaults.
        goToBackgroundObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil,
            queue: nil)
        {
            (note: Notification!) -> Void in
            let defaults = UserDefaults.standard
            //-----------------------------------------------------------------------------
            //This code saves the singleton's properties to NSUserDefaults.
            //edit this code to save your custom properties
            
            // miad info
            defaults.set( self.id, forKey: Keys.id)
            defaults.set( self.pic, forKey: Keys.pic)
            defaults.set( self.name, forKey: Keys.name)
            defaults.set( self.age, forKey: Keys.age)
            defaults.set( self.smoker, forKey: Keys.smoker)
            defaults.set( self.religon, forKey: Keys.religon)
            defaults.set( self.appearance, forKey: Keys.appearance)
            defaults.set( self.language, forKey: Keys.language)
            defaults.set(self.status, forKey: Keys.status)
            defaults.set(self.status, forKey: Keys.experiance)
            
            
            
            // user info
            
            
            
            
            
            //-----------------------------------------------------------------------------
            
            //Tell NSUserDefaults to save to disk now.
            defaults.synchronize()
        }
    }
}
