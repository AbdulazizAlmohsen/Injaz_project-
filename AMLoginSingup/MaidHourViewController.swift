//
//  fulltimeViewController.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/23/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import CircularSpinner
import JSSAlertView


class MaidHourViewController: UIViewController {
    
    //UI
    @IBOutlet weak var religionbtn: UIButton!
    @IBOutlet weak var experiancebtn: UIButton!
    @IBOutlet weak var jonbtn: UIButton!
    @IBOutlet weak var agebtn: UIButton!
    @IBOutlet weak var languagebtn: UIButton!
    
    
    let religion = DropDown()
    let experiance = DropDown()
    let age = DropDown()
    let language = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide keybord 
        self.hideKeyboardWhenTappedAround()

        
        //show dropDown
        setupReligionDropDown()
        setupAgeDropDown()
        setupLanguageDropDown()
        setupExperianceDropDown()
    }
    @IBAction func religiontapped(_ sender: Any) {
        religion.show()
    }
    func setupReligionDropDown() {
        religion.anchorView = religionbtn
        religion.bottomOffset = CGPoint(x: 0, y: religionbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        religion.dataSource = [
            "Muslim",
            "None-Muslim",
            "Any",
        ]
        // Action triggered on selection
        religion.selectionAction = { [unowned self] (index, item) in
            self.religionbtn.setTitle(item, for: .normal)
        }
    }
   
    @IBAction func experiancetapped(_ sender: Any) {
        experiance.show()
    }
    func setupExperianceDropDown() {
        experiance.anchorView = experiancebtn
        experiance.bottomOffset = CGPoint(x: 0, y: experiancebtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        experiance.dataSource = [
            "تجيد العمل مع الاطفال",
            "تجيد الطبخ",
            "تجيد التنظيف",
            "تجيد التنظيف",
            "تجيد الكي",
        ]
        // Action triggered on selection
        experiance.selectionAction = { [unowned self] (index, item) in
            self.experiancebtn.setTitle(item, for: .normal)
        }
    }
    @IBAction func agetapped(_ sender: Any) {
        
        age.show()
    }
    func setupAgeDropDown() {
        age.anchorView = agebtn
        age.bottomOffset = CGPoint(x: 0, y: agebtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        age.dataSource = [
            "20-25",
            "26-30",
            "Any",
        ]
        // Action triggered on selection
        age.selectionAction = { [unowned self] (index, item) in
            self.agebtn.setTitle(item, for: .normal)
        }
    }
    @IBAction func languagetapped(_ sender: Any) {
        language.show()
    }
    func setupLanguageDropDown() {
        language.anchorView = languagebtn
        language.bottomOffset = CGPoint(x: 0, y: languagebtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        language.dataSource = [
            "Arabic",
            "English ",
            "both",
        ]
        // Action triggered on selection
        language.selectionAction = { [unowned self] (index, item) in
            self.languagebtn.setTitle(item, for: .normal)
        }
    }
  
    @IBAction func next(_ sender: UIButton) {
        if UserDataSingleton.sharedDataContainer.is_guest == "guest" {
            
            
            var alertview = JSSAlertView().show(
                self,
                title: "انت زائر حاليا",
                text: "يمكنك تقديم طلبك بعد التسجل او تسجيل دخولك ادا كنت مسجل من قبل",
                buttonText: "تسجيل الدخول / تسجيل",
                cancelButtonText: "لاحقا" // This tells JSSAlertView to create a two-button alert
            )
            alertview.addAction {
                self.performSegue(withIdentifier: "loginto", sender: self)
            }
        } else {

        
        
        if  age.selectedItem != nil , religion.selectedItem != nil , language.selectedItem != nil , experiance.selectedItem != nil {
            
            MaidDataContainerSingleton.sharedDataContainer.age = age.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.religon = religion.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.experiance = experiance.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.language = language.selectedItem
            
            let string = "http://localhost:8000/api/maid"
            
            let urlStr = URL(string: string)
            guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
            let headers = ["Authorization":"Bearer \(token)"]
            
            
            // check rto see if there is a match
            
            var statusCode: Int = 0
            request(urlStr!, method: .get, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
                .responseJSON { response in
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let json = JSON(value)
                        for (key, subJson) in json {
                            
                            
                            // status already added in api
                            if self.language.selectedItem == subJson["language"].string
                                , self.age.selectedItem == subJson["age"].string
                                ,self.religion.selectedItem == subJson["religon"].string
                                , self.experiance.selectedItem == subJson["experiance"].string{
                            
                                MaidDataContainerSingleton.sharedDataContainer.name = subJson["pic"].string
                                
                                CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
                                
                                delayWithSeconds(5) {
                                    CircularSpinner.hide()
                                    
                                    self.performSegue(withIdentifier: "confirmation", sender: self)
                                }
                                
                            } else {
                                let refreshAlert = UIAlertController(title: "finding a match", message: "ماحصلت لك خدامه مطابفه تماما لشروطك", preferredStyle: UIAlertControllerStyle.alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "ابحث في بحث اسهل", style: .default, handler: { (action: UIAlertAction!) in
                                    
                                    self.performSegue(withIdentifier: "easySearch", sender: self)
                                    // do segue to other easy view
                                }))
                                
                                refreshAlert.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { (action: UIAlertAction!) in
                                    
                                    // back to normal view
                                }))
                                
                                self.present(refreshAlert, animated: true, completion: nil)
                            }
                        }
                    }
            }
        }else {
            
            let controller = UIAlertController.alertControllerWithTitle(title: "missing shit", message: "some shits are missing, nigga")
            present(controller, animated: true, completion: nil)
        }

    }
}
    func myCallback() {
        
        self.performSegue(withIdentifier: "loginto", sender: self)
        
        
    }
    
    
    }





