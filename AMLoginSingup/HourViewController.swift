//
//  HourViewController.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/23/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit
import CircularSpinner
import Alamofire
import SwiftyJSON
import MapKit
import DropDown
import JSSAlertView
import SCLAlertView
import JKNotificationPanel






let loc = GetLocation()



class HourViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var nigb: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var from: UIDatePicker!
    @IBOutlet weak var to: UIDatePicker!
    @IBOutlet weak var placeLocationbtn : UIButton!
    @IBOutlet weak var HouseSizebtn : UIButton!

    
    
    let placeLocation = DropDown()
    let nigbdrop = DropDown()
    let panel = JKNotificationPanel()
    let houseSize = DropDown()


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //keyboard
     

        phone.delegate = self
        phone.keyboardType = .numberPad

        
        // DropDown
        
        nigbshow()
        placeDropdownFunc ()
        houseS()
        
        // data show
        phone.text = UserDataSingleton.sharedDataContainer.user_phone
        houseSize.selectedItem == UserDataSingleton.sharedDataContainer.user_house_size
        
        // hide keybord 
        self.hideKeyboardWhenTappedAround()

    }
    
    func nigbshow() {
        nigbdrop.show()
         nigbdrop.bottomOffset = CGPoint(x: 0, y: nigb.bounds.height)
        nigbdrop.selectionAction = { [unowned self] (index, item) in
            self.nigb.setTitle(item, for: .normal)
        }
        
    }
   
    
    @IBAction func placeDropdown(_ sender: Any) {
    
        placeLocation.show()
    }
    
    func placeDropdownFunc() {
        placeLocation.anchorView = placeLocation
        placeLocation.bottomOffset = CGPoint(x: 0, y: placeLocationbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        placeLocation.dataSource = [
            "جنوب الرياض",
            "شمال الرياض",
            "غرب الرياض",
            "وسط الرياض",
"شرق الرياض",
        ]
        // Action triggered on selection
        placeLocation.selectionAction = { [unowned self] (index, item) in
            self.placeLocationbtn.setTitle(item, for: .normal)
        }
       
    }
    
   

    
    @IBAction func nigbdropdown(_ sender: UIButton) {
        nigbdrop.show()
      
        if self.placeLocation.selectedItem == "شمال الرياض" {
            nigbdrop.dataSource = [
                
                " الملقا"
                ,  " الصحافة"
                ,  " النخيل"
                ,  " الياسمين"
                ,   " النفل"
                ,  " الازدهار"
                ,    " قرناطه"
                , "حي المغرزات"
                ,   " الواحه"
                ,  " المرسلات"
                ,  " الورود"
                ,  " المروج"
                ,   "الغدير"
                ,  " الربيع"
                ,  " الرائد"
                ,  " العقيق"
                ,   " النخيل الغربي"
                ,  " النخيل الشرقي"
            ]
        } else {
            if placeLocation.selectedItem == "جنوب الرياض" {
                
                nigbdrop.dataSource = [
                    
                    " الشفاء"
                    ,  " بــدر"
                    ,  " المروة"
                    ,  " الفواز"
                    ,  " الحزم"
                    ,  "العزيزية"
                    , "الدار البيضاء"
                    ,  " المنصورة"
                    ,   " نمار"
                    ,  " الدريهمية"
                    ,    " شبرا"
                    ,  " اليمامة"
                    , " المصانع"
                    ,  " بن تركي"
                    ,  " السويدي"
                    ,  " الشميسي"
                    ,  " الحاير"
                    ,  " الشعلان"
                    
                ]
            }else {
                if placeLocation.selectedItem == "غرب الرياض" {
                    
                    nigbdrop.dataSource = [
                        
                        " الدرعية"
                        , " البديعة"
                        ,  " ظهر"
                        ,  " البديعة"
                        , " عرقة"
                        ,  "حي لبن"
                        ,  "السويدي"
                        ,  " شبرا"
                        , "العريجاء"
                        , " جامعة الملك سعود"
                    ]
                }else {
                    if placeLocation.selectedItem == "شرق الرياض" {
                        
                        nigbdrop.dataSource = [
                            
                            
                            "الفلاح"
                            , "الروضة"
                            , "النسيم"
                            , "النظيم"
                            , "السلي"
                            ,  "القدس"
                            , "الحمراء"
                            ,  "غرناطة"
                            ,  "النهضة"
                            ,  "الخليج"
                            , "المغرزات"
                            ,  "الجزيرة"
                            ,  " الرواد"
                            ,  " الربوه"
                            ,  "إشبيليا"
                            ,  "اليرموك"
                            ,   " قرطبه"
                            ,  " الريان"
                            , "أشبيليه"
                            , "الشهداء"
                        ]
                    }else {
                        if placeLocation.selectedItem == "وسط الرياض" {
                            
                            nigbdrop.dataSource = [
                                
                                
                                " المربع"
                                , " المرقب"
                                ," البطحاء"
                                ,  "الديره"
                                ,  " الصالحية"
                                ,  "الملز"
                                , " الفاخرية"
                                
                            ]
                        }
                    }
                }
            }
        }
    }
    
    
    
    func myCallback() {
        
        self.performSegue(withIdentifier: "loginto", sender: self)
        
        
    }
    
    @IBAction func houseSi(_ sender: Any) {
        
        houseSize.show()
    }
    
    func houseS () {
        houseSize.anchorView = houseSize
        houseSize.bottomOffset = CGPoint(x: 0, y: HouseSizebtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        houseSize.dataSource = [
            "شقة",
            "فله",
                  ]
        // Action triggered on selection
        houseSize.selectionAction = { [unowned self] (index, item) in
            self.HouseSizebtn.setTitle(item, for: .normal)
        }
        
    }
    
    
    
    
    
    @IBAction func reservationtapped(_ sender: Any) {
        
        
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "need connnection")
            self.present(controller, animated: true, completion: nil)
        default:
            print("Connected via WWAN")
        
        
        if UserDataSingleton.sharedDataContainer.is_guest == "guest" {
            
            
            var alertview = JSSAlertView().show(
                self,
                title: "انت زائر حاليا",
                text: "يمكنك تقديم طلبك بعد التسجل او تسجيل دخولك ادا كنت مسجل من قبل",
                buttonText: "تسجيل الدخول / تسجيل",
                cancelButtonText: "لاحقا" // This tells JSSAlertView to create a two-button alert
            )
            alertview.addCancelAction(myCancelCallback)
            alertview.addAction {
                
                
                
                let appearance = SCLAlertView.SCLAppearance(
                    kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
                    kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
                    kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                    showCloseButton: false
                    
                )
                
                
                // Initialize SCLAlertView using custom Appearance
                let alert = SCLAlertView(appearance: appearance)
                
                // Creat the subview
                let subview = UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 170))
                
                
                let x = (subview.frame.width - 180) / 2
                
                // Add textfield 1 national ID
                let textfield1 = UITextField(frame: CGRect(x:0,y:10,width : 180, height : 35))
                textfield1.layer.borderColor = UIColor.black.cgColor
                textfield1.layer.borderWidth = 1.5
                textfield1.layer.cornerRadius = 5
                textfield1.placeholder = "بطاقه الاحوال"
                textfield1.textAlignment = NSTextAlignment.center
                subview.addSubview(textfield1)
                
                // Add the subview to the alert's UI property
                // if user presses national ID
                alert.customSubview = subview
                alert.addButton("دخول") {
                    
                    
                    self.login(nationalId: textfield1.text!)
                    print("im here ")
                }
                alert.customSubview = subview
                alert.addButton("تسجيل") {
                    
                    
                    // when press the register button
                    self.clickOnRegister ()
                    
                    
                }
                
                
                // Add Button with Duration Status and custom Colors
                alert.addButton("لاحقا", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showDurationStatus: true) {
                    print("Duration Button tapped")
                }
                
                alert.showInfo("Login", subTitle: "hello world")
                
                
                
                
                
                
            }
        } else {
        
        
        
        
        
        print(UserDataSingleton.sharedDataContainer.is_guest)
       
        if UserDataSingleton.sharedDataContainer.is_guest == "guest" {
            
            
            var alertview = JSSAlertView().show(
                self,
                title: "انت زائر حاليا",
                text: "يمكنك تقديم طلبك بعد التسجل او تسجيل دخولك ادا كنت مسجل من قبل",
                buttonText: "تسجيل الدخول / تسجيل",
                cancelButtonText: "لاجقا" // This tells JSSAlertView to create a two-button alert
            )
            alertview.addAction {
                
                
                UserDataSingleton.sharedDataContainer.user_house_size = self.houseSize.selectedItem
                UserDataSingleton.sharedDataContainer.user_street = self.street.text
                UserDataSingleton.sharedDataContainer.user_phone = self.phone.text
                UserDataSingleton.sharedDataContainer.user_city = "Ryadh"
                UserDataSingleton.sharedDataContainer.user_nigborhood = self.nigbdrop.selectedItem
                self.performSegue(withIdentifier: "loginto", sender: self)
            }
        } else {
            

        
        
   

        
        if self.phone.text != "" , placeLocation.selectedItem != nil ,  self.street.text != "" , self.nigbdrop.selectedItem != nil , self.houseSize.selectedItem != "" , phone.text?.characters.count == 10 {
            
            // save time for checking avaliablity
            
            
            self.from.datePickerMode = UIDatePickerMode.dateAndTime
            self.to.datePickerMode = UIDatePickerMode.dateAndTime
            
            var dateFormatter = DateFormatter()
            
            UserDataSingleton.sharedDataContainer.user_house_size = self.houseSize.selectedItem
            UserDataSingleton.sharedDataContainer.user_street = self.street.text
            UserDataSingleton.sharedDataContainer.user_phone = self.phone.text
            UserDataSingleton.sharedDataContainer.user_city = "Ryadh"
            UserDataSingleton.sharedDataContainer.user_nigborhood = self.nigbdrop.selectedItem
            
            dateFormatter.dateFormat = "HH:00:00"
            var selectedFrom = dateFormatter.string(from: self.from.date)
            
            UserDataSingleton.sharedDataContainer.from_time = selectedFrom
            
            dateFormatter.dateFormat =  "yyyy-MM-dd"
            let selectedDateTo = dateFormatter.string(from: self.to.date)
            UserDataSingleton.sharedDataContainer.to_date = selectedDateTo
            
            dateFormatter.dateFormat = "HH:00:00"
            let selectedTo = dateFormatter.string(from: self.to.date)
            UserDataSingleton.sharedDataContainer.to_time = selectedTo
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var selectedDateFrom = dateFormatter.string(from: self.from.date)
            UserDataSingleton.sharedDataContainer.from_date = selectedDateFrom
            
            // http inputs
            
            
            let urlstr = "http://localhost:8000/api/getTime"
            
            let url = URL(string: urlstr)
            
            let parameters = [
                
                "from":"\(UserDataSingleton.sharedDataContainer.from_date!) \(UserDataSingleton.sharedDataContainer.from_time!)",
                "to": "\(UserDataSingleton.sharedDataContainer.to_date!) \(UserDataSingleton.sharedDataContainer.to_time!)"
            ]
            
            print(parameters)
            
            guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
            let headers = ["Authorization":"Bearer \(token)"]
            
            // store the user info for records and other requests
            var statusCode: Int = 0
            request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
                .responseJSON { response in
                    
                    print(response.result.value)
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let json = JSON(value)
                        
                        // check if no time available
                        if json["array"] == "empty" {
                            let controller = UIAlertController.alertControllerWithTitle(title: "nothing was found based on your search", message: "try again")
                            self.present(controller, animated: true, completion: nil)
                            
                        } else {
                            
                            for (key, subJson) in json["array"] {
                                print(subJson["id"])
                                let id = subJson["id"].int
                                let pic = subJson["pic"].string
                                MaidDataContainerSingleton.sharedDataContainer.id = id
                                print(MaidDataContainerSingleton.sharedDataContainer.id)
                                MaidDataContainerSingleton.sharedDataContainer.pic = pic
                                self.performSegue(withIdentifier: "topic", sender: self)
                                
                            }
                            
                        }
                        
                        
                    } else {
                        
                        let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "try again")
                        self.present(controller, animated: true, completion: nil)
                        
                    }
            }
        } else{
            
            let controller = UIAlertController.alertControllerWithTitle(title: "All info is required ", message: "plz fill out")
            self.present(controller, animated: true, completion: nil)
            
            
        }
    }
    }
        }
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        let newCharacters = NSCharacterSet(charactersIn: string)
        return NSCharacterSet.decimalDigits.isSuperset(of: newCharacters as CharacterSet)
    }

        
        

    func registerTapped (name : String , phone : String , nationalId : String) {
        let urlstr = "http://localhost:8000/api/auth/signup"
        let url = URL(string: urlstr)
        let param = [
            
            
            "password":"111111",
            "password_confirmation":"111111",
            "phone":"\(phone)",
            "name":"\(name)",
            "national_id": "\(nationalId)",
            "email" : ""
        ]
        
        
        request( url!, method: .post, parameters: param ,  encoding: JSONEncoding.default )
            .responseJSON { response in
                
                print(response.result.value)
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    if let token = usertoken["token"].string {
                        UserDataSingleton.sharedDataContainer.token = token
                        UserDataSingleton.sharedDataContainer.user_national_id = nationalId
                        UserDataSingleton.sharedDataContainer.username = name
                        UserDataSingleton.sharedDataContainer.user_phone = phone
                        
                        
                        let alert = UIAlertController(title: "", message: "تم تاكيد التسجيل", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: {
                                UserDataSingleton.sharedDataContainer.is_guest = "user"
                                
                            })
                            
                        }
                        
                        
                    }
                }
                
        }
    }
    
    

}
    func myCancelCallback() {
        // this'll run if cancel is pressed after the alert is dismissed
        // there is nothing here yet 
    }
    func registerTapped (name : String , phone : String , nationalId : String) {
        let urlstr = "http://localhost:8000/api/auth/signup"
        let url = URL(string: urlstr)
        let param = [
            
            
            "password":"111111",
            "password_confirmation":"111111",
            "phone":"\(phone)",
            "name":"\(name)",
            "national_id": "\(nationalId)",
            "email" : ""
        ]
        
        
        request( url!, method: .post, parameters: param ,  encoding: JSONEncoding.default )
            .responseJSON { response in
                
                print(response.result.value)
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    if let token = usertoken["token"].string {
                        UserDataSingleton.sharedDataContainer.token = token
                        UserDataSingleton.sharedDataContainer.user_national_id = nationalId
                        UserDataSingleton.sharedDataContainer.username = name
                        UserDataSingleton.sharedDataContainer.user_phone = phone
                        
                        
                        self.panel.showNotify(withStatus: .success, inView : self.view!, title: " تسجيل الدخول", message: "مرحبا \(UserDataSingleton.sharedDataContainer.username!)")
                                UserDataSingleton.sharedDataContainer.is_guest = "user"
                                                  
                        
                    }
                }
                
        }
    }
    
    func clickOnRegister () {
        let appearance2 = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
            
        )
        let alert = SCLAlertView(appearance: appearance2)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 300))
        
        
        let x = (subview.frame.width - 180) / 2
        
        // Add textfield 1 national ID
        let textfield2 = UITextField(frame: CGRect(x:0,y:10,width : 180, height : 35))
        textfield2.layer.borderColor = UIColor.black.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.placeholder = "بطاقه الاحوال"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        //Add textfield 2
        let textfield3 = UITextField(frame: CGRect(x:0,y : textfield2.frame.maxY + 10, width : 180,height : 35))
        textfield3.isSecureTextEntry = false
        textfield3.layer.borderColor = UIColor.black.cgColor
        textfield3.layer.borderWidth = 1.5
        textfield3.layer.cornerRadius = 5
        textfield3.layer.borderColor = UIColor.blue.cgColor
        textfield3.placeholder = "الاسم"
        textfield3.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield3)
        alert.customSubview = subview
        
        //Add textfield ٣
        let textfield4 = UITextField(frame: CGRect(x:0,y : textfield3.frame.maxY + 10, width : 180,height : 35))
        textfield4.isSecureTextEntry = false
        textfield4.layer.borderColor = UIColor.black.cgColor
        textfield4.layer.borderWidth = 1.5
        textfield4.layer.cornerRadius = 5
        textfield4.layer.borderColor = UIColor.blue.cgColor
        textfield4.placeholder = "رقم الجوال"
        textfield4.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield4)
        alert.customSubview = subview
        
        
        
        print("Logged in")
        
        alert.addButton("تسجيل", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showDurationStatus: true) {
            
            // here is the register code
            print("تم التسجيل")
            
            self.registerTapped(name: textfield3.text!, phone: textfield4.text!, nationalId: textfield2.text!)
            
            
        }
        alert.addButton("بعدين", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showDurationStatus: true) {
            print("Duration Button tapped")
        }
        
        alert.showInfo("Login", subTitle: "hello world")
        

    
}
    func login (nationalId : String) {
        
        let urlstr = "http://localhost:8000/api/auth/postLogin"
        let url = URL(string: urlstr)
        let parameters = [
            "national_id": nationalId,
            "password": "111111",
            ] as [String : Any]
        guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
        let headers = ["Authorization":"Bearer \(token)"]
        print(nationalId)
        var statusCode: Int = 0
        request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
            .responseJSON { response in
                
                print(response.value)
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    if let token = usertoken["token"].string {
                        UserDataSingleton.sharedDataContainer.token = token
                        
                        UserDataSingleton.sharedDataContainer.is_guest = "user"
                        print(UserDataSingleton.sharedDataContainer.is_guest)
                        self.panel.showNotify(withStatus: .success, inView : self.view!, title: " تسجيل الدخول", message: "مرحبا \(UserDataSingleton.sharedDataContainer.username!)")
                        
                    } else {
                        
                        let controller = UIAlertController.alertControllerWithTitle(title: "wrong shit", message: "need good info nigga")
                        self.present(controller, animated: true, completion: nil)
                        
                        
                    }
                }
        }
    }
    



}
