//
//  testViewController.swift
//  app_project
//
//  Created by Abdulaziz  Almohsen on 11/28/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import JWTDecode
import XLPagerTabStrip
import ObjectMapper
import JHSpinner


class testViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , IndicatorInfoProvider  {
    
    
    func indicatorInfo( for pagerTabStripController : PagerTabStripViewController) -> IndicatorInfo{
        return IndicatorInfo(title : "حالات الخادمة المطلوب")
    
    }
    

    
    var fulldata : [Maid] = []
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.red, overlay:.custom(CGSize(width: 300, height: 200), 20), overlayColor:UIColor.black.withAlphaComponent(0.6), fullCycleTime:4.0, text:"Loading")
        
        view.addSubview(spinner)
        tableview.delegate = self
        tableview.dataSource = self
        
       getData ()
        self.automaticallyAdjustsScrollViewInsets = false

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return fulldata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "MaidCell", for: indexPath) as! MaidC
        
        let entry = fulldata[indexPath.row]
        
       
        cell.date.text = entry.date
        cell.job.text = entry.job
        cell.status.text = entry.status
        cell.update.text = entry.update
        return cell

        
    }
    func getData (){
        
        let urlstr = "http://localhost:8000/api/newuser/checkMaid"
        
        let url = URL(string: urlstr)
        
        
        guard let token = UserDataSingleton.sharedDataContainer.token else { return  }
        let headers = ["Authorization":"Bearer \(token)"]
        
        
        var statusCode: Int = 0
        request(url! ,  method: .get,  encoding: JSONEncoding.prettyPrinted ,  headers: headers )
            .responseJSON { response in
                
                
                
                if let value: AnyObject = response.result.value as AnyObject? {
                    //Handle the results as JSON
                    let json = JSON(value)
                    for (key, subJson) in json {
                        let maids = subJson["both"]
                        
                        for (key, subJson) in maids {
                            let status = subJson["status"].stringValue
                            let date = subJson["created_at"].stringValue
                            let name = subJson["name"].stringValue
                            
                                // Convert JSON to Object
                            

                            
                            // Access pivot dictionary
                            let pivot = subJson["pivot"]
                            
                            
                      
                                
                       
                                

                                let data = Maid(job: name, status: status, date: date , update: date)
                                
                                self.fulldata.append(data)
                                
                            }
                            
                        self.tableview.performSelector(onMainThread: Selector("reloadData"), with: nil, waitUntilDone: true)
                        



                            
                            }
                                  
                            }
                }
             }
}
   



