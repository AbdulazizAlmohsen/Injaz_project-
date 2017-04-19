//
//  DriverViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 2/22/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import JSSAlertView


class DriverViewController: UIViewController {
    
    
    @IBOutlet weak var DropDownREkigionbtin: NiceButton!
    
    @IBOutlet weak var DropDownSmokerbtn: NiceButton!
    @IBOutlet weak var DropDownLanguagebtn: NiceButton!
    
    @IBOutlet weak var DropDownTobtn: NiceButton!
    @IBOutlet weak var DropDownFronbtn: NiceButton!
    

    // DropDOwn stuff
    
    let DropDownREligion = DropDown()
    let DropDownSmoker = DropDown()
    let DropDownLanguage = DropDown()
    let DropDownTo = DropDown()
    let DropDownFrom = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // function drop down
        setupReligion()
        setupSmoking()
        setupLanguage()
        setupAgefrom()
        setupAgeToDropDown()
        
    }
    
    @IBAction func REligionShow(_ sender: NiceButton) {
        
        DropDownREligion.show()
    }
    func setupReligion() {
        DropDownREligion.anchorView = DropDownREkigionbtin
        DropDownREligion.bottomOffset = CGPoint(x: 0, y: DropDownREkigionbtin.bounds.height)
        // You c   an also use localizationKeysDataSource instead. Check the docs.
        DropDownREligion.dataSource = [
            "Muslim",
            "None-Muslim",
            "Any",
        ]
        // Action triggered on selection
        DropDownREligion.selectionAction = { [unowned self] (index, item) in
            self.DropDownREkigionbtin.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func SmokingShow(_ sender: Any) {
        DropDownSmoker.show()
    }
    func setupSmoking() {
        DropDownSmoker.anchorView = DropDownSmokerbtn
        DropDownSmoker.bottomOffset = CGPoint(x: 0, y: DropDownSmokerbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        DropDownSmoker.dataSource = [
            "مدخن",
            "غير مدخن",
            "لايهم",
        ]
        // Action triggered on selection
        DropDownSmoker.selectionAction = { [unowned self] (index, item) in
            self.DropDownSmokerbtn.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func LanguageShow (_sender: NiceButton){
        DropDownLanguage.show()
    }
    
    func setupLanguage (){
        
        DropDownLanguage.anchorView = DropDownLanguagebtn
        DropDownLanguage.bottomOffset = CGPoint(x: 0, y: DropDownSmokerbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        DropDownLanguage.dataSource = [
            "العربية",
            "الانقليزية",
            "لايهم",
        ]
        // Action triggered on selection
        DropDownLanguage.selectionAction = { [unowned self] (index, item) in
            self.DropDownLanguagebtn.setTitle(item, for: .normal)
        }
        
    }
    //age from
    
    @IBAction func AgeFromShow(_ sender: UIButton) {
        DropDownFrom.show()
    }
    func setupAgefrom() {
        DropDownFrom.anchorView = DropDownFronbtn
        DropDownFrom.bottomOffset = CGPoint(x: 0, y: DropDownFronbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        DropDownFrom.dataSource = [
            "20",
            "21",
            "22",
            "23",
            
            "24",
            "25",
            "26",
            "27",
            
        ]
        // Action triggered on selection
        DropDownFrom.selectionAction = { [unowned self] (index, item) in
            self.DropDownFronbtn.setTitle(item, for: .normal)
            let baseNumber = Int(item)
            for i in 0 ..< 6 { //you can alter this line for however many values you want
                self.DropDownTo.dataSource.append(String(baseNumber! + 5 + i))
            }
            
        }
    }
    
    
    
    @IBAction func ageToShow(_ sender: UIButton) {
        DropDownTo.show()
    }
    func setupAgeToDropDown() {
        DropDownTo.anchorView = DropDownTobtn
        DropDownTo.bottomOffset = CGPoint(x: 0, y: DropDownTobtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        // Action triggered on selection
        DropDownTo.selectionAction = { [unowned self] (index, item) in
            self.DropDownTobtn.setTitle(item, for: .normal)
        }
    }
    
    
    @IBAction func nextbtn(_ sender: NiceButton) {
                   

        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "need connnection")
            self.present(controller, animated: true, completion: nil)
        default:
            print("Connected via WWAN")

        
        guard let religionn = self.DropDownREligion.selectedItem else { return }
        guard let languagee = self.DropDownLanguage.selectedItem else { return }
        guard let smokerr = self.DropDownSmoker.selectedItem else { return }
        guard let ageTo = self.DropDownTo.selectedItem else { return }
        
        
        
        
        let string = "http://localhost:8000/api/apidriver"
        
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
                        
                        
                        print(religionn)
                        print(languagee)
                        print(smokerr)
                        print(self.DropDownFrom.selectedItem!)
                        print(self.DropDownTo.selectedItem!)

                        print(subJson["age"].stringValue)

                        

                        

                        
                        if self.DropDownFrom.selectedItem!...self.DropDownTo.selectedItem! ~= subJson["age"].stringValue  &&
                            religionn == subJson["religion"].stringValue &&
                            languagee == subJson["language"].stringValue &&
                            smokerr == subJson["Smoker"].stringValue &&
                            subJson["status"].stringValue == "جديد"
                            {
                            
                            
                            DriverDataContainerSingleton.sharedDataContainer.age = subJson["age"].stringValue
                            DriverDataContainerSingleton.sharedDataContainer.language = languagee
                            DriverDataContainerSingleton.sharedDataContainer.smoker = smokerr
                            DriverDataContainerSingleton.sharedDataContainer.pic = subJson["pic"].stringValue
                            DriverDataContainerSingleton.sharedDataContainer.id = subJson["id"].int
                            
                            
                            let alert = UIAlertController(title: "حصلنا", message: "  تم الحصول على سواق مطابق", preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            // change to desired number of seconds (in this case 5 seconds)
                            let when = DispatchTime.now() + 2
                            DispatchQueue.main.asyncAfter(deadline: when){
                                // your code with delay
                                alert.dismiss(animated: true, completion: {
                                    self.performSegue(withIdentifier: "DriverResult", sender: self)
                                })
                                
                            }
 
                            
                        }
                        }
                        
                        
                    }
                }
            }
    
  
    }

}
