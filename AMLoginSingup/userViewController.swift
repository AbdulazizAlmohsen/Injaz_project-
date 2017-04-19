//
//  ViewController.swift
//  Swifty
//
//  Created by Jamal Kharrat on 7/13/14.
//  Copyright (c) 2014 Jamal Designs. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import SwiftyJSON



//i love u abdulaziz don't ask me again plz'




class ViewController: UIViewController {
    
    //MARK: Outlets for UI Elements.
    @IBOutlet weak var usernameField:   UITextField!
    @IBOutlet weak var imageView:       UIImageView!
    @IBOutlet weak var loginButton:     UIButton!
    
    
    //MARK: Global Variables for Changing Image Functionality.
    fileprivate var idx: Int = 0
    fileprivate let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg")]
    
    // save date 

    
    //MARK: View Controller LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDataSingleton.sharedDataContainer.token != nil {
            print("hello woorld ")
            print(UserDataSingleton.sharedDataContainer.token)
            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "about", sender: self)
            }
            
        } else {
            print("needs to login ")
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
                
        usernameField.alpha = 0;
        loginButton.alpha   = 0;
        
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.loginButton.alpha   = 0.9
        }, completion: nil)
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: #selector(ViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        
        
        
        // Visual Effect View for background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark)) as UIVisualEffectView
        visualEffectView.frame = self.view.frame
        visualEffectView.alpha = 0.5
        imageView.image = UIImage(named: "img1.jpg")
        imageView.addSubview(visualEffectView)
        
        
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(ViewController.changeImage), userInfo: nil, repeats: true)
        self.loginButton(false)
        
       
    }
    
    
    
    
    func loginButton(_ enabled: Bool) -> () {
        func enable(){
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#33CC00", alpha: 1)
            }, completion: nil)
            loginButton.isEnabled = true
        }
        func disable(){
            loginButton.isEnabled = false
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
            }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx += 1
        }
        let toImage = backGroundArray[idx];
        UIView.transition(with: self.imageView, duration: 3, options: .transitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldDidChange() {
        if (usernameField.text!.isEmpty)
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
    
    // login auth
    
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        
        
        
        let urlstr = "http://localhost:8000/api/auth/postLogin"
        
        let url = URL(string: urlstr)
        
        let parameters = [
            "national_id": usernameField.text,
            "password": "111111"
        ] as [String : Any]
        let headers = ["dsd":"sds"]

        
        var statusCode: Int = 0
        request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
            .responseJSON { response in
               
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    
                    if let token = usertoken["token"].string {
                       UserDataSingleton.sharedDataContainer.token = token
                        print(UserDataSingleton.sharedDataContainer.token)
                        self.performSegue(withIdentifier: "test", sender: self)

                    
                        
                    } else {
                        
                        
                        print("error")
                    }
                    
                }
        }
    }
    

    @IBAction func signupPressed(_ sender: AnyObject) {
        
    }
    
    
    @IBAction func backgroundPressed(_ sender: AnyObject) {
        usernameField.resignFirstResponder()
        
    }
    
    
    func alert (title: String,msg : String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

//Extension for Color to take Hex Values
extension UIColor{
    
    class func colorWithHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            // skip '#' character
            scanner.scanLocation = 1
        }
        scanner.scanHexInt32(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}










