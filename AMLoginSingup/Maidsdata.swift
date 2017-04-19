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
struct DefaultsKeys
{
    
    // maid info
    // name if the pic 
    static let id  = "id"
    static let pic  = "id"
    static let name  = "name"
    static let age  = "age"
    static let job  = "job"
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

class MaidDataContainerSingleton
{
    static let sharedDataContainer = MaidDataContainerSingleton()
    
    //------------------------------------------------------------
    //Add properties here that you want to share accross your app
    
    // maid info
    var id: Int?
    var pic: String?
    var name: String?
    var job: String?
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
        id = defaults.object(forKey: DefaultsKeys.id) as! Int?
        pic = defaults.object(forKey: DefaultsKeys.pic) as! String?

        name = defaults.object(forKey: DefaultsKeys.name) as! String?
        age = defaults.object(forKey: DefaultsKeys.age) as! String?
        job = defaults.object(forKey: DefaultsKeys.job) as! String?
        religon = defaults.object(forKey: DefaultsKeys.religon) as! String?
        appearance = defaults.object(forKey: DefaultsKeys.appearance) as! String?
        language = defaults.object(forKey: DefaultsKeys.language) as! String?
        status = defaults.object(forKey: DefaultsKeys.status) as! String?
        experiance = defaults.object(forKey: DefaultsKeys.experiance) as! String?

        
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
            defaults.set( self.id, forKey: DefaultsKeys.id)
            defaults.set( self.pic, forKey: DefaultsKeys.pic)
            defaults.set( self.name, forKey: DefaultsKeys.name)
            defaults.set( self.age, forKey: DefaultsKeys.age)
            defaults.set( self.job, forKey: DefaultsKeys.job)
            defaults.set( self.religon, forKey: DefaultsKeys.religon)
            defaults.set( self.appearance, forKey: DefaultsKeys.appearance)
            defaults.set( self.language, forKey: DefaultsKeys.language)
            defaults.set(self.status, forKey: DefaultsKeys.status)
            defaults.set(self.status, forKey: DefaultsKeys.experiance)

            
            
            // user info

            
            
            
            
            //-----------------------------------------------------------------------------
            
            //Tell NSUserDefaults to save to disk now.
            defaults.synchronize()
        }
    }
}
