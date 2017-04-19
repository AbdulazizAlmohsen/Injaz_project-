//
//  Alert.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 12/17/16.
//  Copyright © 2016 amirs.eu. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func alertControllerWithTitle(title: String, message: String) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return controller
    }
}
