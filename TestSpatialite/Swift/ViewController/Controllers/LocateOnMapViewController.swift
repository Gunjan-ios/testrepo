//
//  LocateOnMapViewController.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 19/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class LocateOnMapViewController: UIViewController,WKNavigationDelegate {
    
    // Screen Controls
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonSave: UIButton!
    fileprivate var lblHeader:UILabel!
    fileprivate var global_Y_Position:Int! = 0
    fileprivate var global_ADD_Y_Position:Int! = 0
    fileprivate var internal_view_Space : Int = 90
    
    var storeLat:Double!
    var storeLong:Double!
    
    
    fileprivate var webViewMain : WKWebView!
    let userContentController = WKUserContentController()

    // JS Functions
    fileprivate let JS_FUNCTION_SETLOCATION_DATA = "setLocationInfo"
    
    fileprivate var changedLat:Double!
    fileprivate var changedLong:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initHeader()
        // Do any additional setup after loading the view.
    }
    private func initHeader() {
        
        global_Y_Position = (STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
        
        headerview = UIView(frame: CGRect(x: 0, y:global_Y_Position, width: Int(UIScreen.main.bounds.width), height: TOP_HEADER_HEIGHT));
        headerview.backgroundColor = HEADER_BACKGROUND_COLOUR
        self.view.addSubview(headerview)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect:CGRect(x: 0, y: TOP_HEADER_HEIGHT, width: SCREEN_WIDTH, height: 1), cornerRadius: 0).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.shadowRadius = 2
        headerview.layer.insertSublayer(shadowLayer, below: nil) // also works
        
        self.buttonBack = UIButton(frame: CGRect(x: 0, y: 0, width: HEADER_BUTTON_WIDTH, height: TOP_HEADER_HEIGHT))
        self.buttonBack.setTitle("Cancel", for: .normal)
        self.buttonBack.setTitleColor(blueTextColor, for: .normal)
        let buttonBackSpace:CGFloat = 5.0
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonBack.addTarget(self, action: #selector(buttonBackPressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        self.buttonSave = UIButton(frame: CGRect(x: SCREEN_WIDTH - HEADER_BUTTON_WIDTH, y: 0, width: HEADER_BUTTON_WIDTH, height: TOP_HEADER_HEIGHT))
        self.buttonSave.setTitle("Done", for: .normal)
        self.buttonSave.setTitleColor(blueTextColor, for: .normal)
        self.buttonSave.backgroundColor = UIColor.clear
        self.buttonSave.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonSave.addTarget(self, action: #selector(buttonDonePressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonSave)
        
        self.lblHeader = UILabel(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH - 100, height: TOP_HEADER_HEIGHT))
        self.lblHeader.textColor = blueTextColor
        self.lblHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        self.lblHeader.text = "Locate on map"
        self.lblHeader.textAlignment = .center
        headerview.addSubview(self.lblHeader)
        self.initDesign()
        
        global_Y_Position += TOP_HEADER_HEIGHT
        
    }
    
    // actions
    @objc func buttonBackPressed(sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonDonePressed(sender:UIButton) {
        
        self.webViewMain.evaluateJavaScript("getLocationInfo()", completionHandler: nil)

    }
    
      
    private func initDesign() {
    
        // load webview
        let localPathURL = Bundle.main.url(forResource: "index", withExtension: "html")
        let request = NSURLRequest(url: localPathURL! as URL)
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        userContentController.add(self as! WKScriptMessageHandler, name: JS_FUNCTION_SETLOCATION_DATA)
//        userContentController.add(self as WKScriptMessageHandler, name: JS_FUNCTION_SET_MAP_EXTENT)
        configuration.userContentController = userContentController
        
        print(global_Y_Position)
        
        self.webViewMain = WKWebView(frame: CGRect(x: 0, y: global_Y_Position, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - global_Y_Position + SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding ) , configuration:configuration)
        self.webViewMain.navigationDelegate = self
        self.webViewMain.backgroundColor = UIColor.gray
        self.webViewMain.contentMode = .scaleToFill
        self.webViewMain.scrollView.showsVerticalScrollIndicator = false;
        self.view.addSubview(self.webViewMain)
        
        self.view.sendSubviewToBack(self.webViewMain)
        self.view.backgroundColor = .white
        self.webViewMain.load(request as URLRequest)
        
    }
    
    // MARK: Webview delegate
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        
        let alertController = UIAlertController(title: "GIS", message: error.localizedDescription, preferredStyle: .alert)
        
        let actionok = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(actionok)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        
        self.view.isUserInteractionEnabled = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        var dic = [String:Any]()
        
        var loc = [String:Any]()
        loc["latitude"] = SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.latitude
        loc["longitude"] = SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.longitude
        
        dic["currentLocation"] = loc
        
        var storeLoc = [String:Any]()
        storeLoc["latitude"] = self.storeLat
        storeLoc["longitude"] = self.storeLong
        
        dic["storeLocation"] = storeLoc
        
         if var jsonString = JSONStringEncoder().encodeJsonString(dic) {
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            self.printOn(pMessage: "showLocationInfo('\(jsonString)')")
                   
            self.webViewMain.evaluateJavaScript("showLocationInfo('\(jsonString)')", completionHandler: nil)
        }

    }
    
    private func askChangeOptions() {
          let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)

                    alert.addAction(UIAlertAction(title: "Change Location Only", style: .default , handler:{ (UIAlertAction)in
                         SingletonClassSwift.sharedInstance.is_location_changed = true
                         SingletonClassSwift.sharedInstance.changed_location_latitude = self.changedLat
                         SingletonClassSwift.sharedInstance.changed_location_longitude = self.changedLong
                     
                         self.navigationController?.popViewController(animated: true)
                    }))

                    alert.addAction(UIAlertAction(title: "Change Address Only", style: .default , handler:{ (UIAlertAction)in
                     
                        GISWebServicesManager.getAddressFromLocation(latitude: self.changedLat, longitude: self.changedLong, onCompletion: { response in
                         

                         self.printOn(pMessage: response!["success"])
                         
                         if response!["success"] == true {
                             
                             SingletonClassSwift.sharedInstance.is_address_changed = true
                             SingletonClassSwift.sharedInstance.address = response!["message"].stringValue
                            SingletonClassSwift.sharedInstance.changed_location_latitude = self.changedLat
                            SingletonClassSwift.sharedInstance.changed_location_longitude = self.changedLong
                             self.navigationController?.popViewController(animated: true)
                             
                         } else {
                             self.displayAlertMessage(pMessage: response!["message"].string!)
                             self.printOn(pMessage: response!["message"])
                         }

                     },onError:{ error in
                         
                         if error != nil {
                             self.displayAlertMessage(pMessage: "Something went wrong. ")
                         }
                         
                     })
                     
                    }))

                    alert.addAction(UIAlertAction(title: "Change Both", style: .default , handler:{ (UIAlertAction)in
                     
                     GISWebServicesManager.getAddressFromLocation(latitude: self.changedLat, longitude: self.changedLong, onCompletion: { response in
                          

                          self.printOn(pMessage: response!["success"])
                          
                          if response!["success"] == true {
                              SingletonClassSwift.sharedInstance.is_location_changed = true
                              SingletonClassSwift.sharedInstance.is_address_changed = true
                              SingletonClassSwift.sharedInstance.address = response!["message"].stringValue
                              SingletonClassSwift.sharedInstance.changed_location_latitude = self.changedLat
                              SingletonClassSwift.sharedInstance.changed_location_longitude = self.changedLong
                              
                             self.navigationController?.popViewController(animated: true)
                          } else {
                              self.displayAlertMessage(pMessage: response!["message"].string!)
                              self.printOn(pMessage: response!["message"])
                          }

                      },onError:{ error in
                          
                          if error != nil {
                              self.displayAlertMessage(pMessage: "Something went wrong. ")
                          }
                          
                      })
                      
                     }))
            

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                        
                    }))

                    self.present(alert, animated: true, completion: {
                        
                    })
      }

}

//MARK:- WKScriptMessageHandler
extension LocateOnMapViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.name as! String)
        print(message.body as! Any)
        
        if message.name == JS_FUNCTION_SETLOCATION_DATA {
            
          //   if var jsonObj = JSONStringEncoder().deco {
                
            let dic = message.body as! [String:Any]
            self.changedLat = dic["latitude"] as? Double
            self.changedLong = dic["longitude"] as? Double
            self.askChangeOptions()
        }
        
       
      
    }
}
