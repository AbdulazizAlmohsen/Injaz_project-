//
//  DriverResultViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 3/5/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DriverResultViewController: UIViewController {
    @IBOutlet var imageView : UIImageView!
    
    var image = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  getting images here
        
        guard let pic =  DriverDataContainerSingleton.sharedDataContainer.pic else { return  }
        
        if let checkedUrl = URL(string: pic) {
            imageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        let urlstr = "http://localhost:8000/api/apidriver"
        
        let url = URL(string: urlstr)
        
        let parameters = [
            //            "name": "\(UserDataSingleton.sharedDataContainer.username!)",
            "phone" : "\( UserDataSingleton.sharedDataContainer.user_phone!)",
            "city" : "\( UserDataSingleton.sharedDataContainer.user_city!)",
            "niehgborhood" : "\( UserDataSingleton.sharedDataContainer.user_nigborhood!)",
            "street" : "\( UserDataSingleton.sharedDataContainer.user_street!)",
            "size_of_house" : "\( UserDataSingleton.sharedDataContainer.user_house_size!)",
            "national_id": "\(UserDataSingleton.sharedDataContainer.user_national_id!)",
            "status" : "تم الطلب",
            "id" : "\(DriverDataContainerSingleton.sharedDataContainer.id!)",
            "from_date":"\(UserDataSingleton.sharedDataContainer.from_date!) \(UserDataSingleton.sharedDataContainer.from_time!)",
            "to_date": "\(UserDataSingleton.sharedDataContainer.to_date!) \(UserDataSingleton.sharedDataContainer.to_time!)"
        ]
        
        guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
        let headers = ["Authorization":"Bearer \(token)"]
        var statusCode: Int = 0
        request(url! ,  method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted ,  headers: headers )
            .responseJSON { response in
                print(response.result.value)
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let usertoken = JSON(value)
                    
                    if usertoken["request"] == "success"{
                        
                        let alert = UIAlertController(title: "", message: "تم تاكيد التسجيل", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: {
                                self.performSegue(withIdentifier: "confirm", sender: self)
                            })
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "", message: "لم يتم تاكيد التسجيل", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: nil)
                        }
                        
                        
                    }
                }
                
        }
    }

        
        
    }
    

   

