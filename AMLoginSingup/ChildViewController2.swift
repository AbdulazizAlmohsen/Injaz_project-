//
//  ChildViewController2.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 3/12/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//


import UIKit
import SwiftyJSON
import Alamofire
import JWTDecode
import XLPagerTabStrip




class ChildViewController2: UIViewController , IndicatorInfoProvider , UITableViewDelegate , UITableViewDataSource {

    func indicatorInfo( for pagerTabStripController : PagerTabStripViewController)-> IndicatorInfo{
        return IndicatorInfo(title : "حالات السائق المطلوب")
        
    }


    
    
    var full : [Driverj] = []
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        
        tableview.delegate = self
        tableview.dataSource = self
        
        getData ()
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return full.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath) as! DriverC
        
        let entry = full[indexPath.row]
        
        cell.date.text = entry.created_at
        cell.job.text = entry.name
        cell.status.text = entry.status
        cell.update.text = entry.name
        return cell
        
        
    }
    func getData (){
        
        let urlstr = "http://localhost:8000/api/newuser/checkDriver"
        
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
                        
                        let maids = subJson["driver"]
                        
                        for (key, subJson) in maids {
                            let status = subJson["status"].stringValue
                            let date = subJson["created_at"].stringValue
                            let name = subJson["name"].stringValue
                            
//                             Access pivot dictionary
                            
                             
                              
                                
                                
                                let data = Driverj(name: name, status: status, created_at: date)
                                
                                
                                self.full.append(data)
                              
                                print(date)
                                
                                
                            }
                            self.tableview.performSelector(onMainThread: Selector("reloadData"), with: nil, waitUntilDone: true)
                        
                            
                           
                            
                            
                        }
                        
                   
                        
                    }
               
              
                }
        }
    }
    



