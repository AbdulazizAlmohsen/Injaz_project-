//
//  ViewController.swift
//  AMLoginSingup
//
//  Created by amir on 10/11/16.
//  Copyright © 2016 amirs.eu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JKNotificationPanel


enum AMLoginSignupViewMode {
    case login
    case signup
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    let panel = JKNotificationPanel()
    
    let animationDuration = 0.25
    var mode:AMLoginSignupViewMode = .signup
    
    
    //MARK: - background image constraints
    @IBOutlet weak var backImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var backImageBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: - login views and constrains
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginContentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginWidthConstraint: NSLayoutConstraint!
    
    
    //MARK: - signup views and constrains
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var signupContentView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var signupButtonTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - logo and constrains
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoButtomInSingupConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoCenterConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var socialsView: UIView!
    
    
    //MARK: - input views
    @IBOutlet weak var loginNationalDInputView: AMInputView!
    //    @IBOutlet weak var loginPasswordInputView: AMInputView!
    @IBOutlet weak var signupNationalDInputView: AMInputView!
    @IBOutlet weak var signupNameInputView: AMInputView!
    @IBOutlet weak var signupEmailConfirmInputView: AMInputView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        // test
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "need connnection")
            self.present(controller, animated: true, completion: nil)
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            
            
            let controller = UIAlertController.alertControllerWithTitle(title: "error occured when uploading info", message: "متصل واي فاي")
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard 
        
        self.hideKeyboardWhenTappedAround()


        
    
        // check Internet 
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

        
        
        // set view to login mode
        toggleViewMode(animated: false)
        
        //add keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }

    //MARK: - button actions
    @IBAction func loginButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .signup {
            toggleViewMode(animated: true)
            
        }else{
            
            //TODO: login by this data
            
            let urlstr = "http://localhost:8000/api/auth/postLogin"
            
            let url = URL(string: urlstr)
            
            let parameters = [
                "national_id": loginNationalDInputView.textFieldView.text!,
                "password": "111111",
                "name" : "\(signupNameInputView.textFieldView.text!)",
                ] as [String : Any]
            guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
            let headers = ["Authorization":"Bearer \(token)"]
            
            var statusCode: Int = 0
            request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
                .responseJSON { response in
                    print(response.result.value)
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let usertoken = JSON(value)
                        if let token = usertoken["token"].string {
                            UserDataSingleton.sharedDataContainer.token = token
                            UserDataSingleton.sharedDataContainer.user_national_id = self.loginNationalDInputView.textFieldView.text!
                            
                            self.performSegue(withIdentifier: "signedin", sender: self)
                            UserDataSingleton.sharedDataContainer.is_guest = "user"
                            print(UserDataSingleton.sharedDataContainer.is_guest)
                        } else {
                            
                            let controller = UIAlertController.alertControllerWithTitle(title: "wrong shit", message: "need good info nigga")
                            self.present(controller, animated: true, completion: nil)
                        

                        }
                 }
            }
        }
    }
    
    
    @IBAction func signupButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .login {
            toggleViewMode(animated: true)
        }else{
            
            //TODO: signup by this data
            NSLog("Email:\(signupNationalDInputView.textFieldView.text) Password:\(signupNameInputView.textFieldView.text), PasswordConfirm:\(signupEmailConfirmInputView.textFieldView.text)")
            
            
            let urlstr = "http://localhost:8000/api/auth/signup"
            let url = URL(string: urlstr)
            let param = [
                
                
                "password":"111111",
                "password_confirmation":"111111",
                "phone":"\(signupEmailConfirmInputView.textFieldView.text!)",
                "name":"\(signupNameInputView.textFieldView.text!)",
                "national_id": "\(signupNationalDInputView.textFieldView.text!)",
                "email" : ""
            ]
            
            
            print(signupEmailConfirmInputView.textFieldView.text)
            request( url!, method: .post, parameters: param ,  encoding: JSONEncoding.default )
                .responseJSON { response in
                    
                    print(response.result.value)
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        //Handle the results as JSON
                        let usertoken = JSON(value)
                        if let token = usertoken["token"].string {
                    UserDataSingleton.sharedDataContainer.token = token
                    UserDataSingleton.sharedDataContainer.user_national_id = self.loginNationalDInputView.textFieldView.text
                    UserDataSingleton.sharedDataContainer.username = self.signupNameInputView.textFieldView.text
                            UserDataSingleton.sharedDataContainer.user_phone = self.signupEmailConfirmInputView.textFieldView.text

                    
                    self.panel.showNotify(withStatus: .success, inView : self.view!, title: " تسجيل الدخول", message: "مرحبا \(UserDataSingleton.sharedDataContainer.username!)")
                        self.performSegue(withIdentifier: "signedin", sender: self)
                            UserDataSingleton.sharedDataContainer.is_guest = "user"

                   
                    
            }
        }

}
}
}


//MARK: - toggle view
func toggleViewMode(animated:Bool){
    
    // toggle mode
    mode = mode == .login ? .signup:.login
    
    
    // set constraints changes
    backImageLeftConstraint.constant = mode == .login ? 0:-self.view.frame.size.width
    
    
    loginWidthConstraint.isActive = mode == .signup ? true:false
    logoCenterConstraint.constant = (mode == .login ? -1:1) * (loginWidthConstraint.multiplier * self.view.frame.size.width)/2
    loginButtonVerticalCenterConstraint.priority = mode == .login ? 300:900
    signupButtonVerticalCenterConstraint.priority = mode == .signup ? 300:900
    
    
    //animate
    self.view.endEditing(true)
    
    UIView.animate(withDuration:animated ? animationDuration:0) {
        
        //animate constraints
        self.view.layoutIfNeeded()
        
        //hide or show views
        self.loginContentView.alpha = self.mode == .login ? 1:0
        self.signupContentView.alpha = self.mode == .signup ? 1:0
        
        
        // rotate and scale login button
        let scaleLogin:CGFloat = self.mode == .login ? 1:0.4
        let rotateAngleLogin:CGFloat = self.mode == .login ? 0:CGFloat(-M_PI_2)
        
        var transformLogin = CGAffineTransform(scaleX: scaleLogin, y: scaleLogin)
        transformLogin = transformLogin.rotated(by: rotateAngleLogin)
        self.loginButton.transform = transformLogin
        
        
        // rotate and scale signup button
        let scaleSignup:CGFloat = self.mode == .signup ? 1:0.4
        let rotateAngleSignup:CGFloat = self.mode == .signup ? 0:CGFloat(-M_PI_2)
        
        var transformSignup = CGAffineTransform(scaleX: scaleSignup, y: scaleSignup)
        transformSignup = transformSignup.rotated(by: rotateAngleSignup)
        self.signupButton.transform = transformSignup
    }
    
}


//MARK: - keyboard
func keyboarFrameChange(notification:NSNotification){
    
    let userInfo = notification.userInfo as! [String:AnyObject]
    
    // get top of keyboard in view
    let topOfKetboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue .origin.y
    
    
    // get animation curve for animate view like keyboard animation
    var animationDuration:TimeInterval = 0.25
    var animationCurve:UIViewAnimationCurve = .easeOut
    if let animDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
        animationDuration = animDuration.doubleValue
    }
    
    if let animCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
        animationCurve =  UIViewAnimationCurve.init(rawValue: animCurve.intValue)!
    }
    
    
    // check keyboard is showing
    let keyboardShow = topOfKetboard != self.view.frame.size.height
    
    
    //hide logo in little devices
    let hideLogo = self.view.frame.size.height < 667
    
    // set constraints
    backImageBottomConstraint.constant = self.view.frame.size.height - topOfKetboard
    
    logoTopConstraint.constant = keyboardShow ? (hideLogo ? 0:20):50
    logoHeightConstraint.constant = keyboardShow ? (hideLogo ? 0:40):60
    logoBottomConstraint.constant = keyboardShow ? 20:32
    logoButtomInSingupConstraint.constant = keyboardShow ? 20:32
    
    //        forgotPassTopConstraint.constant = keyboardShow ? 30:45
    
    loginButtonTopConstraint.constant = keyboardShow ? 25:30
    signupButtonTopConstraint.constant = keyboardShow ? 23:35
    
    loginButton.alpha = keyboardShow ? 1:0.7
    signupButton.alpha = keyboardShow ? 1:0.7
    
    
    
    // animate constraints changes
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(animationDuration)
    UIView.setAnimationCurve(animationCurve)
    
    self.view.layoutIfNeeded()
    
    UIView.commitAnimations()
    
}

//MARK: - hide status bar in swift3

override var prefersStatusBarHidden: Bool {
    return true
}


@IBAction func call(_ sender: UITapGestureRecognizer) {
    
    if let url = NSURL(string: "tel://+9661124949494") {
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
}
    
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
    }
    
    
    @IBAction func guest(_ sender: Any) {
        UserDataSingleton.sharedDataContainer.is_guest = "guest"
        
        performSegue(withIdentifier: "signedin", sender: self)
    
    }
    
}
