//
//  MainpageViewController.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/22/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit

class MainpageViewController: UIViewController {
    @IBOutlet weak var sidemenue: NSLayoutConstraint!
    
    
    var loaction = ""
    var showmenue = false

    
        

    
//
    @IBAction func hour(_ sender: UIGestureRecognizer) {
//        loc.getAdress { result in
//            if let city = result["State"] as? String {
//                if city != "Riyadh" {
                    self.performSegue(withIdentifier: "Riyadh", sender: self)
//                } else{
//                
//                
//        
//            let controller = UIAlertController.alertControllerWithTitle(title: "error  when ", message: "only Riyadh")
//            self.present(controller, animated: true, completion: nil)
//        }
//        
//    }
//    }
//
    }

    @IBAction func menuebtntapped(_ sender: UIButton) {
        
        if (showmenue){
            sidemenue.constant = -260
        } else {
            
            sidemenue.constant = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.layoutIfNeeded()
            })
        }
        showmenue = !showmenue
        
        
    }
  
}
