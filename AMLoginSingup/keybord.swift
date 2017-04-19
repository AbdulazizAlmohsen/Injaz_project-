//
//  keybord.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 1/30/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
