//
//  SignupController.swift
//  Swifty
//
//  Created by Abdulaziz  Almohsen on 11/16/16.
//  Copyright © 2016 Flowers Designs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var confirm_password : UITextField!
    @IBOutlet weak var name :UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        name.alpha = 1;
        password.alpha = 1;
        confirm_password.alpha = 1;
        signup.alpha   = 1;
        
        
        name.tintColor = UIColor.white
        name.delegate = self
        name.returnKeyType = .done
        name.keyboardAppearance = .dark
        name.backgroundColor = UIColor.clear
        
        password.tintColor = UIColor.white
        password.delegate = self
        password.returnKeyType = .done
        password.keyboardAppearance = .dark
        password.backgroundColor = UIColor.clear
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func loginButton(_ enabled: Bool) -> () {
        func enable(){
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.signup.backgroundColor = UIColor.colorWithHex("#33CC00", alpha: 1)
            }, completion: nil)
            signup.isEnabled = true
        }
        func disable(){
            signup.isEnabled = false
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.signup.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
            }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -25, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -25, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    //loging
    
    
    
    @IBAction func signup(_ sender: UIButton) {
        
        
        let urlstr = "http://localhost:8000/api/auth/signup"
        let url = URL(string: urlstr)
        
        
        
        let param = ["email": email.text, "password":password.text,"password_confirmation":confirm_password.text,"name":name.text]
        
        
        request( url!, method: .post, parameters: param ,  encoding: JSONEncoding.default )
            .responseJSON { response in
                
                print(response.result.value)
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    if let token = usertoken["token"].string {
                        UserDataSingleton.sharedDataContainer.token = token
                        
                        
                        let alert = UIAlertController(title: "", message: "تم تاكيد التسجيل", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        
                        

                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: { 
                                self.performSegue(withIdentifier: "signed", sender: self)
                            })

                        }
                        


                        
                    } else {
                        
                        print("error")
                    }
            }
        }
    }
    @IBAction func call(_ sender: UITapGestureRecognizer) {
        if let url = NSURL(string: "tel://+966560002621") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
        }
    }
}
