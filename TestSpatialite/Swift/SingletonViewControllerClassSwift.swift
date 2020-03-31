//
//  SingletonViewControllerClassSwift.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/10/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit
import CoreLocation

class SingletonViewControllerClassSwift: UIViewController {
    
    var timer:Timer?
    var mm_rel_amt : String?
    var add_Validation : String = "0"

    static let shared = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SingletonViewControllerClassSwift") as! SingletonViewControllerClassSwift
    
    @objc func getLocationsInIntervals() {
        
        //SingletonClassSwift.sharedInstance.currentTrack.trackGeom.append(SingletonClassSwift.sharedInstance.locationManager.location!)
        
    }
}

// location
extension SingletonViewControllerClassSwift: CLLocationManagerDelegate {
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            print("Current location: \(currentLocation)")
            print("alt \(currentLocation.altitude)")
            print("acc \(currentLocation.horizontalAccuracy)")
            //SingletonClassSwift.sharedInstance.locationManager.stopUpdatingLocation()
            
            
        }
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
