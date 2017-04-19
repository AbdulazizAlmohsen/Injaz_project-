//
//  EasySearchViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 12/26/16.
//  Copyright © 2016 amirs.eu. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import CircularSpinner

class EasySearchViewController: UIViewController {
    
    //UI
    @IBOutlet weak var religionbtn: UIButton!
    @IBOutlet weak var experiancebtn: UIButton!
    @IBOutlet weak var jonbtn: UIButton!
    @IBOutlet weak var agebtn: UIButton!
    @IBOutlet weak var appearancebtn: UIButton!
    @IBOutlet weak var languagebtn: UIButton!
    
    
    let religion = DropDown()
    let experiance = DropDown()
    let job = DropDown()
    let age = DropDown()
    let appearance = DropDown()
    let language = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show dropDown
        setupReligionDropDown()
        setupJobDropDown()
        setupAgeDropDown()
        setupLanguageDropDown()
        setupExperianceDropDown()
        setupAppearanceDropDown()
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
    @IBAction func jobtapped(_ sender: Any) {
        job.show()
    }
    func setupJobDropDown() {
        job.anchorView = jonbtn
        job.bottomOffset = CGPoint(x: 0, y: jonbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        job.dataSource = [
            "Maid",
            "Driver",
        ]
        // Action triggered on selection
        job.selectionAction = { [unowned self] (index, item) in
            self.jonbtn.setTitle(item, for: .normal)
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
            "very good",
            "good",
            "new",
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
    @IBAction func appearancetapped(_ sender: Any) {
        appearance.show()
    }
    func setupAppearanceDropDown() {
        appearance.anchorView = appearancebtn
        appearance.bottomOffset = CGPoint(x: 0, y: appearancebtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        appearance.dataSource = [
            "very good",
            "good ",
            "ok",
        ]
        // Action triggered on selection
        appearance.selectionAction = { [unowned self] (index, item) in
            self.appearancebtn.setTitle(item, for: .normal)
        }
    }
    @IBAction func next(_ sender: UIButton) {
        
        
        if job.selectedItem != nil , age.selectedItem != nil , religion.selectedItem != nil , appearance.selectedItem != nil , language.selectedItem != nil , experiance.selectedItem != nil {
            
            MaidDataContainerSingleton.sharedDataContainer.age = age.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.job = job.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.religon = religion.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.appearance = appearance.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.experiance = experiance.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.language = language.selectedItem
            let string = "http://localhost:8000/api/maid"
            
            let urlStr = URL(string: string)
            guard let token = UserDataSingleton.sharedDataContainer.token else { return }
            let headers = ["Authorization":"Bearer \(token)"]
            
            
            // check rto see if there is a match
            
            var statusCode: Int = 0
            request(urlStr!, method: .get, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
                .responseJSON { response in
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let json = JSON(value)
                        for (key, subJson) in json {
                            if self.language.selectedItem == subJson["language"].string
                                && self.age.selectedItem == subJson["age"].string
                                && self.religion.selectedItem == subJson["religon"].string
                                && self.job.selectedItem == subJson["job"].string
                                && self.experiance.selectedItem == subJson["experiance"].string
                                && self.appearance.selectedItem == subJson["appearance"].string {
                                
                                MaidDataContainerSingleton.sharedDataContainer.name = subJson["pic"].string
                                
                                CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
                                
                                delayWithSeconds(5) {
                                    CircularSpinner.hide()
                                    
                                    self.performSegue(withIdentifier: "confirmation", sender: self)
                                }
                                
                            } else {
                                let refreshAlert = UIAlertController(title: "مافيه مطابقه", message: "ماحصلنا لك خدامه مطابفه لبحثك", preferredStyle: UIAlertControllerStyle.alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "ارسال الطلب الحالي الى المكتب ", style: .default, handler: { (action: UIAlertAction!) in
                                    
                                    // do HHTP function
                                    self.sendRequest ()
                                }))
                                
                                refreshAlert.addAction(UIAlertAction(title: "ابحث مره ثانيه", style: .cancel, handler: { (action: UIAlertAction!) in
                                    
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
    
    func sendRequest (){
        let urlstr = "http://localhost:8000/api/requested"
        
        let url = URL(string: urlstr)
        
        let parameters = [
            "national_id": "\(UserDataSingleton.sharedDataContainer.user_national_id!)",
            "age": "\(MaidDataContainerSingleton.sharedDataContainer.age!)",
            "religon" : "\(MaidDataContainerSingleton.sharedDataContainer.religon!)",
            "language" : "\(MaidDataContainerSingleton.sharedDataContainer.language!)",
            "appearance" : "\(MaidDataContainerSingleton.sharedDataContainer.appearance!)",
            "job" : "\(MaidDataContainerSingleton.sharedDataContainer.job!)",
            "experiance" : "\(MaidDataContainerSingleton.sharedDataContainer.appearance!)",
            "status" : "مطلوب",
            
            
            "from_time": "\(UserDataSingleton.sharedDataContainer.from_time)",
            "to_time": "\(UserDataSingleton.sharedDataContainer.to_time)",
            "from_date":"\(UserDataSingleton.sharedDataContainer.from_date)",
            "to_date": "\(UserDataSingleton.sharedDataContainer.to_date)"
        ]
        
        guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
        let headers = ["Authorization":"Bearer \(token)"]
        
        
        var statusCode: Int = 0
        request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
            .responseJSON { response in
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    
                    if usertoken["request"] == "success"{
                        
                        let alert = UIAlertController(title: "تآكبد", message: "تم تاكيد طلبك", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: {
                                self.performSegue(withIdentifier: "needed", sender: self)
                            })
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
                
        }
    }

        
    }
    
    
    
