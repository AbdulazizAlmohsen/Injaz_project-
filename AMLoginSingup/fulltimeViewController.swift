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
import JSSAlertView

class fulltimeViewController: UIViewController {
    
    //UI
    @IBOutlet weak var religionbtn: UIButton!
    @IBOutlet weak var experiancebtn: UIButton!
    @IBOutlet weak var languagebtn: UIButton!
    @IBOutlet weak var ageFrombtn: NiceButton!
    @IBOutlet weak var ageTobtin: NiceButton!
    @IBOutlet weak var hasWorkExbtn: NiceButton!
    @IBOutlet weak var workplace: UITextField!
    @IBOutlet weak var questionWorkPlace: UILabel!

    
    let religion = DropDown()
    let experiance = DropDown()
    let job = DropDown()
    let agefrom = DropDown()
    let language = DropDown()
    let agefromdrop = DropDown()
    let agetodrop = DropDown()
    let hasWorkEx = DropDown ()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide textfield 
        
        self.workplace.isHidden = true
        self.questionWorkPlace.isHidden = true
        
        
        // hide keybord 
        
        self.hideKeyboardWhenTappedAround()
 
        
        //show dropDown
        setupReligionDropDown()
        setupAgeToDropDown()
        setupLanguageDropDown()
        setupExperianceDropDown()
        setupAgefromDropDown()
        setupHasWorkExDropDown ()

    }
    
    @IBAction func HasWorkExDrop(_ sender: Any) {
        hasWorkEx.show()
    }
    func setupHasWorkExDropDown() {
        hasWorkEx.anchorView = hasWorkExbtn
        hasWorkEx.bottomOffset = CGPoint(x: 0, y: hasWorkExbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        hasWorkEx.dataSource = [
            "نعم",
            "لا ",
            "لا يهم",
        ]
        // Action triggered on selection
        hasWorkEx.selectionAction = { [unowned self] (index, item) in
            self.hasWorkExbtn.setTitle(item, for: .normal)
            if self.hasWorkEx.selectedItem == "نعم" {
                self.workplace.isHidden = false
                self.questionWorkPlace.isHidden = false
            } else {
                self.workplace.isHidden = true
                self.questionWorkPlace.isHidden = true
            }
        }
    }

    
    @IBAction func religiontapped(_ sender: Any) {
        religion.show()
    }
    func setupReligionDropDown() {
        religion.anchorView = religionbtn
        religion.bottomOffset = CGPoint(x: 0, y: religionbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        religion.dataSource = [
            "مسلمه",
            "مسيحي ",
            "لا يهم",
        ]
        // Action triggered on selection
        religion.selectionAction = { [unowned self] (index, item) in
            self.religionbtn.setTitle(item, for: .normal)
        }
    }

    
    
    //age from
    
    @IBAction func agefromtapped(_ sender: UIButton) {
        agefromdrop.show()
    }
    func setupAgefromDropDown() {
        agefromdrop.anchorView = ageFrombtn
        agefromdrop.bottomOffset = CGPoint(x: 0, y: ageFrombtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        agefromdrop.dataSource = [
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",



        ]
        // Action triggered on selection
        
        agefromdrop.selectionAction = { [unowned self] (index, item) in
            self.ageFrombtn.setTitle(item, for: .normal)

            let baseNumber = Int(item)

            self.agetodrop.dataSource = [String]()
            for i in 0 ..< 6 { //you can alter this line for however many values you want
                self.agetodrop.dataSource.append(String(baseNumber! + 5 + i))

            }
        }
    }
    
    
    
    @IBAction func agetotapped(_ sender: UIButton) {
        agetodrop.show()
    }
    func setupAgeToDropDown() {
        agetodrop.anchorView = ageTobtin
        agetodrop.bottomOffset = CGPoint(x: 0, y: ageTobtin.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
               // Action triggered on selection
        agetodrop.selectionAction = { [unowned self] (index, item) in
            self.ageTobtin.setTitle(item, for: .normal)
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
        
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "need connnection")
            self.present(controller, animated: true, completion: nil)
        default:
            print("Connected via WWAN")

        
        guard let experiancee = experiance.selectedItem  else { return  }
        guard let ageFromm = agefromdrop.selectedItem  else { return  }
        guard let religionn = religion.selectedItem  else { return  }
        guard let languagee = language.selectedItem  else { return  }
        guard let ageToo = agetodrop.selectedItem  else { return  }

        
        
        print(experiancee)
        print(ageFromm)

        print(religionn)

        print(languagee)
        print(ageToo)



        let total =  Int(agetodrop.selectedItem!)! - Int(agefromdrop.selectedItem!)!
        
        guard  total >= 5 , total != nil else {
            Alert(title: "age", msg: "العمر لازم يكون اكثر من خمس سنوات")
            return 

        }
        
        if experiancee != nil , ageFromm != nil , religionn != nil ,  languagee != nil , ageToo != nil  {
            
            let urlstr = "http://localhost:8000/api/maid"
            let url = URL(string: urlstr)
            MaidDataContainerSingleton.sharedDataContainer.age = self.agefrom.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.job = self.job.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.religon = self.religion.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.experiance = self.experiance.selectedItem
            MaidDataContainerSingleton.sharedDataContainer.language = self.language.selectedItem
           var place = "لا"
            if hasWorkEx.selectedItem == "نعم" {
               let place = workplace.text
                
            } else {
                
                place = "no"
            }
            let parameters = [
                "experiance": "\(experiancee )",
                "religon" : "\(religionn)",
                "language" : "\(languagee)",
                "age" : "\(ageFromm )\("-")\(ageToo)",
                "status" : "تم الطلب",
                "hasworked": "\(place)"
            // dont forget to make them requsted type

               
            ]
            
            guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
            let headers = ["Authorization":"Bearer \(token)"]
            var statusCode: Int = 0
            request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.default ,  headers: headers )
                .responseJSON { response in
                    print(response.result.value)
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let returnData = JSON(value)
                        
                        
                        
                        var alertview = JSSAlertView().show(self,
                                                            title: "تقديم طلب استقدام",
                                                            text: "تم ارسال طلبك الي الادارة بنجاح"
                        )
                        alertview.addAction(self.myCallback) // Method to run after dismissal
                        alertview.setTitleFont("ClearSans-Bold") // Title font
                        alertview.setTextFont("ClearSans") // Alert body text font
                        alertview.setButtonFont("ClearSans-Light") // Button text font
                        alertview.setTextTheme(.dark) // can be .Light or .Dark
                    

                        
                        
                       
//                        MaidDataContainerSingleton.sharedDataContainer.age = self.agefrom.selectedItem
//                        MaidDataContainerSingleton.sharedDataContainer.job = self.job.selectedItem
//                        MaidDataContainerSingleton.sharedDataContainer.religon = self.religion.selectedItem
//                        MaidDataContainerSingleton.sharedDataContainer.experiance = self.experiance.selectedItem
//                        MaidDataContainerSingleton.sharedDataContainer.language = self.language.selectedItem
                        
                        
                    }
            }
        } else{
        Alert(title: "complete", msg: "missed")
        

    }
    }
    }
    
    func Alert (title : String , msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func myCallback() {
        
        performSegue(withIdentifier: "confirmed", sender: self)
    }
    }

