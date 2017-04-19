//
//  UserInfoBookingViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 12/12/16.
//  Copyright © 2016 amirs.eu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JWTDecode
import DropDown
import JSSAlertView
import SCLAlertView
import JKNotificationPanel



class UserInfoBookingViewController: UIViewController , UITextFieldDelegate  {
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var niehgborhoodbtn: UIButton!
    @IBOutlet weak var phone: UITextField!


    @IBOutlet weak var southbtn : UIButton!
    
    let panel = JKNotificationPanel()

    let niehgborhood = DropDown()
    
    let south = DropDown ()
    func myCancelCallback() {
        // this'll run if cancel is pressed after the alert is dismissed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // test 
        


        
        // bring up the region
        
        niehgborhood.selectedItem == UserDataSingleton.sharedDataContainer.region
        
        // hide keybord
        
        self.hideKeyboardWhenTappedAround()
        
        // to get only nnum
        phone.delegate = self
        phone.keyboardType = .numberPad
        
       setupReligionDropDown()
        
        street.text = UserDataSingleton.sharedDataContainer.user_street
        phone.text = UserDataSingleton.sharedDataContainer.user_phone
        
        
        // Do any additional setup after loading the view.
    }
    
    // keyboard only numbers 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    
    @IBAction func COnfirmTapped(_ sender: Any) {
        
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "need connnection")
            self.present(controller, animated: true, completion: nil)
        default:
            print("Connected via WWAN")

        guard let niehgborhoodd = niehgborhood.selectedItem  else { return  }
        guard let streett = street.text  else { return  }
        guard let phonee = phone.text  else { return  }
        guard let southh = south.selectedItem  else { return  }

        print(niehgborhoodd)
        print(streett)
        print(phonee)
        print(southh)
        
        if UserDataSingleton.sharedDataContainer.is_guest == "guest" {
        
        
            var alertview = JSSAlertView().show(
                self,
                title: "انت زائر حاليا",
                text: "يمكنك تقديم طلبك بعد التسجل او تسجيل دخولك ادا كنت مسجل من قبل",
                buttonText: "تسجيل الدخول / تسجيل",
                cancelButtonText: "بعدين" // This tells JSSAlertView to create a two-button alert
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
            alert.addButton("بعدين", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showDurationStatus: true) {
                print("Duration Button tapped")
            }
            
            alert.showInfo("Login", subTitle: "hello world")
          
            
            
            
            
            
        }
        } else {




        if  niehgborhoodd != nil , streett != nil , phonee != nil , southh != nil  {
            
            let urlstr = "http://localhost:8000/api/newuser"
            
            let url = URL(string: urlstr)
            
            let parameters = [
                "phone" : "\(self.phone.text!)",
                "city" : "Riyadh",
                "niehgborhood" : "\(self.niehgborhood.selectedItem!)",
                "street" : "\(self.street.text!)"
            ]
            
            guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
            let headers = ["Authorization":"Bearer \(token)"]
            
            
            var statusCode: Int = 0
            request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
                .responseJSON { response in
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let usertoken = JSON(value)
                        
                        UserDataSingleton.sharedDataContainer.user_nigborhood = self.niehgborhood.selectedItem
                        
                        UserDataSingleton.sharedDataContainer.user_street = self.street.text
                        UserDataSingleton.sharedDataContainer.user_phone = self.phone.text
                        UserDataSingleton.sharedDataContainer.user_city = "Riyadh"
                        
                        self.performSegue(withIdentifier: "ToMaidInfo", sender: self)


                        
                    } else {
                        let controller = UIAlertController.alertControllerWithTitle(title:"someyhing happened with tcll request ", message: "rty again")
                        self.present(controller, animated: true, completion: nil)
                     
                    }
            }
            
        }
        
    }
    }
    }
    func Alert (title : String , msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func niehgborhooddropdown(_ sender: UIButton) {
        niehgborhood.show()
        
    }
    func setupReligionDropDown() {
        niehgborhood.anchorView = niehgborhoodbtn
        niehgborhood.bottomOffset = CGPoint(x: 0, y: niehgborhoodbtn.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        niehgborhood.dataSource = [
            "شمال الرياض" ,
           "جنوب الرياض",
"غرب الرياض",

"وسط الرياض",

"شرق الرياض" ,
        ]
        // Action triggered on selection
        niehgborhood.selectionAction = { [unowned self] (index, item) in
            self.niehgborhoodbtn.setTitle(item, for: .normal)

        }
    }
  
    @IBAction func southdropdown(_ sender: UIButton) {
        south.show()
        south.anchorView = southbtn
        south.bottomOffset = CGPoint(x: 0, y: south.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        
        // Action triggered on selection
        south.selectionAction = { [unowned self] (index, item) in
            self.southbtn.setTitle(item, for: .normal)
        }

        if niehgborhood.selectedItem == "شمال الرياض" {
            south.dataSource = [
                
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
            if niehgborhood.selectedItem == "جنوب الرياض" {
                
                south.dataSource = [
                    
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
                if niehgborhood.selectedItem == "غرب الرياض" {
                    
                    south.dataSource = [
                        
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
                    if niehgborhood.selectedItem == "شرق الرياض" {
                        
                        south.dataSource = [
                          
                                
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
                        if niehgborhood.selectedItem == "وسط الرياض" {
                            
                            south.dataSource = [
                                
                                
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
    
            func southDropDown() {
        south.show()
            
            
        }

        
                   }
            
        }
    func myCallback() {
        
        self.performSegue(withIdentifier: "loginto", sender: self)

        
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
                        UserDataSingleton.sharedDataContainer.username = "عبدالله"
                        
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
                        // change to desired number of seconds (in this case 5 seconds)
                       
                                UserDataSingleton.sharedDataContainer.is_guest = "user"
                                
                       
                        
                    }
                }
                
        }
    }

    }

    


