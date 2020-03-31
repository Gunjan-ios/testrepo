//
//  SingletonClass.swift
//  Trip Planner
//
//  Created by Gaurav on 24/07/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import CoreLocation
import JQProgressHUD


fileprivate let AD_LIVETV_PAGE_PLACEMENT_ID = "2049321685346945_2418674081745035"

enum SharedNews:Int {
    case WhatsApp
    case Facebook
    case Twitter
}

class SingletonClassSwift {
    
    static let sharedInstance = SingletonClassSwift()
    let locationManager = CLLocationManager()
    
    var iPhone_X_Top_Padding:Int = 0
    var iPhone_X_Bottom_Padding:Int = 0
    var newsShared:Int = -1
    var fbInterstialLiveTvEverySecondCount = 1
    var liveTVVCPushed = false
    
    var editableFieldUpdated:Bool! = false
    var notEditedField:Bool! = false
    
    // tracks
    var locationTrackStarted:Bool! = false
 
    
    let fileManager:FileManager = FileManager.default
    
    var map_context:String! = ""
    var IS_USER_SURVEYOR:Bool! = false
    
    var is_address_changed = false
    var is_location_changed = false
    var address = ""
    var changed_location_latitude:Double = 0.0
    var changed_location_longitude:Double = 0.0
    var is_preview_done:Bool = false
    
    private init() {
        
    }
    
    static func getDate(complete date:String)-> String {
        if (date == ""){
            return date
        }
        let splitdate : [Substring] = date.split(separator: ".")
        let subString = splitdate.first!
        let newDate = String(subString)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"
        if let date1 = dateFormatterGet.date(from:newDate ){
            return dateFormatterPrint.string(from:date1)
        }
        else {
            print("There was an error decoding the string")
        }
        return date
    }
    
    func heightForView(text:String?, width:CGFloat , Label : DynamicLabel) -> Int{
        let hValue = CGFloat.greatestFiniteMagnitude
        Label.frame.size.height = hValue
        Label.numberOfLines = 0
        Label.lineBreakMode = NSLineBreakMode.byWordWrapping
        Label.text = text
        Label.sizeToFit()
        //if Int(Label.frame.height) < LABEL_HEIGHT || Int(Label.frame.height)  <= 41 {
        
        if Int(Label.frame.height) < LABEL_HEIGHT {
            return LABEL_HEIGHT
        }
        else{
            return Int(Label.frame.height)
        }
    }
    
    func heightForViewAddress(text:String?, width:CGFloat , Label : DynamicLabel) -> Int{
           let hValue = CGFloat.greatestFiniteMagnitude
           Label.frame.size.height = hValue
           Label.numberOfLines = 0
           Label.lineBreakMode = NSLineBreakMode.byWordWrapping
           Label.text = text
           Label.sizeToFit()
           if Int(Label.frame.height) < LABEL_HEIGHT || Int(Label.frame.height)  <= 41 {
           
           //if Int(Label.frame.height) < LABEL_HEIGHT {
               return LABEL_HEIGHT
           }
           else{
               return Int(Label.frame.height)
           }
       }
    
    
    
    func setData(strData:Any,strKey:String) {
        
        UserDefaults.standard.set(strData, forKey: strKey)
        UserDefaults.standard.synchronize()
    }
    
    func getDataForKey(strKey:String) -> Any {
        
        return UserDefaults.standard.value(forKey: strKey) as Any
        
    }
    static func showLoading(title : String)  {
        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    }
   static func hideLoading()  {
        JQProgressHUDTool.jq_hideHUD()
    }
     func setImageData(strData: [imageData], strKey: String){
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: strData)
        userDefaults.set(encodedData, forKey: strKey)
        userDefaults.synchronize()
    }
    
     func getImageDataForKey(strKey: String) -> [imageData]? {
        //var decode = [imageData (name: "", type: "", imageTag: 0)]
        let decoded  = UserDefaults.standard.object(forKey: strKey) as? Data
        if decoded != nil {
            let decode  = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as!  [imageData]
            return decode
        }
        return nil
    }
    
    func invisibleView(RefView id: UIView)  {
        for v in id.subviews {
            if v.isKind(of: UIImageView.self) {
                v.removeFromSuperview()
            }
        }
    }
        
    
    func getDBPath() -> URL {
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir: String = paths[0] as! String
        return URL(fileURLWithPath: documentsDir).appendingPathComponent("GISdb.sqlite")
    }
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? KVICAppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }
    
    func getLocation() {
        // 1
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            //self.present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
        }
        
        // 4
        self.locationManager.delegate = SingletonViewControllerClassSwift.shared as CLLocationManagerDelegate
        // self.locationManager.startUpdatingLocation()
    }
    
    // get color from string
    func getColorFromString(pString:String) -> UIColor {
        
        var strokeColorInString = pString
        strokeColorInString = strokeColorInString.replacingOccurrences(of: "rgba(", with: "")
        strokeColorInString = strokeColorInString.replacingOccurrences(of: ")", with: "")
        
        let strokesArray = strokeColorInString.components(separatedBy: ",")
        
        return UIColor(red:  CGFloat(Double(strokesArray[0])!/255.0), green: CGFloat(Double(strokesArray[1])!/255.0), blue: CGFloat(Double(strokesArray[2])!/255.0), alpha:  CGFloat(Double(strokesArray[3])!))
    }
    
 
   
}



