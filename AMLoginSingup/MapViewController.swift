//
//  MapViewController.swift
//  AMLoginSingup
//
//  Created by Abdulaziz  Almohsen on 4/18/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var  mapview : MKMapView! 
    
    let annotation = MKPointAnnotation()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.7559805, longitude: 46.7425654)
        mapview.addAnnotation(annotation)
        
        
        
        
        let span = MKCoordinateSpanMake(0.020, 0.020)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.7559805, longitude: 46.7425654), span: span)
        mapview.setRegion(region, animated: true)
        
        

    }

  

}
