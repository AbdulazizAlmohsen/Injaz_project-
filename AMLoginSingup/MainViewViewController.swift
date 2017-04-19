//
//  MainViewViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 4/16/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func housrGesture(_ sender: UITapGestureRecognizer) {
    
              loc.getAdress { result in
                   if let city = result["State"] as? String {
                      if city != "Riyad" {
        self.performSegue(withIdentifier: "ToHousr", sender: self)
                       } else{
       
           let controller = UIAlertController.alertControllerWithTitle(title: "error  when ", message: "only Riyadh")
                  self.present(controller, animated: true, completion: nil)
               }
               
           }
     }
        
    }
    


}
