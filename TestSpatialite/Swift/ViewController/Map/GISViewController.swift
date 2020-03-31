//
//  ViewController.swift
//  GISDataCollection
//
//  Created by Gaurav on 20/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import SearchTextField
import MSPeekCollectionViewDelegateImplementation

class GISViewController: UIViewController, WKNavigationDelegate,UITextFieldDelegate {
    
    fileprivate var webViewMain : WKWebView!
    
    fileprivate var buttonUser: UIButton!
    fileprivate var buttonMic: UIButton!
    fileprivate var searchTxtField: SearchTextField!
    
    fileprivate var vcAddLayer:UIViewController!
    
    fileprivate var database:FMDatabase!
    let userContentController = WKUserContentController()
    fileprivate var selectedCoordinate:String!
    let lblTitles = ["", "LATITUDE", "LONGITUDE","ALTITUDE","ACCURACY"]
    
    // JS Functions
    fileprivate let JS_FUNCTION_GETLAYER_DATA = "getLayerData"
    fileprivate let JS_FUNCTION_SET_MAP_EXTENT = "setMapExtent"
    fileprivate let JS_FUNCTION_GET_MAP_EXTENT = "getMapExtent"
    
    //Initialize and keeping reference of HHTabBarView.
    fileprivate let hhTabBarView = HHTabBarView.shared
    
    // for khadi unit
    fileprivate var peekImplementation: MSPeekCollectionViewDelegateImplementation!
    fileprivate var collectionView: UICollectionView!
    fileprivate var attributesArray = [[String: String]]()
    
    // for khadi product
    fileprivate var khadiProductView:KhadiProductView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // self.showUpdatedLayersOnMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor.white
        
        self.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
        self.sideMenuController?.isRightViewSwipeGestureEnabled = false;
        
        self.initDesign()
        self.setUpKhadiUnitScrollBar()
        self.setUpKhadiProductView()
        self.setupHHTabBarView()
        
        SingletonClassSwift.sharedInstance.getLocation()
        
    }
    
    private func initDesign() {
        
        let height : Int = 45
        
        let searchView = UIView(frame: CGRect(x: 20, y: STATUS_BAR_HEIGHT+SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding + 25, width: SCREEN_WIDTH - 40, height: height))
        self.view.addSubview(searchView)
        
        // setting button
        self.buttonUser = UIButton(frame: CGRect(x: 0, y: 0 , width: height, height: height))
        self.buttonUser.setImage(UIImage(named: "userIconGray"), for: .normal)
        self.buttonUser.layer.cornerRadius = buttonUser.bounds.size.width / 2
        self.buttonUser.backgroundColor = UIColor.white
        self.buttonUser.addTarget(self, action: #selector(btnUserPressed(sender:)), for: .touchUpInside)
        searchView.addSubview(self.buttonUser)
        
        let txtView = UIView(frame: CGRect(x: 55, y: 0, width: Int(searchView.frame.size.width - 55), height: height))
        txtView.layer.cornerRadius = 20
        txtView.backgroundColor = UIColor.white
        searchView.addSubview(txtView)
        
        searchTxtField = SearchTextField(frame: CGRect(x: 15, y: 0, width: Int(txtView.frame.size.width-75), height: height))
        searchTxtField.delegate = self as UITextFieldDelegate
        searchTxtField.returnKeyType = .search
        searchTxtField.backgroundColor = UIColor.clear
        searchTxtField.placeholder = "Search Khadi Unit here"
        searchTxtField.theme.cellHeight = 40
        searchTxtField.font = UIFont(name: APP_FONT_NAME, size: TEXTFIELD_FONT_SIZE)
        searchTxtField.theme.font = UIFont(name: APP_FONT_NAME, size: TEXTFIELD_FONT_SIZE)!
       // searchTxtField.center = CGPoint(x: SCREEN_WIDTH/2, y: Int(buttonUser.center.y))
        txtView.addSubview(self.searchTxtField)
        
        let seperatarLine = UILabel(frame: CGRect(x: txtView.frame.size.width-52, y: 7, width: 1, height: 31))
        seperatarLine.backgroundColor = UIColor.lightGray
        txtView.addSubview(seperatarLine)
        seperatarLine.isHidden = true
        
        self.buttonMic = UIButton(frame: CGRect(x: Int(txtView.frame.size.width - 50), y: 0 , width: height, height: height))
        self.buttonMic.setImage(UIImage(named: "micIcon"), for: .normal)
        self.buttonMic.backgroundColor = UIColor.clear
        self.buttonMic.addTarget(self, action: #selector(btnMicPressed(sender:)), for: .touchUpInside)
        txtView.addSubview(self.buttonMic)
        self.buttonMic.isHidden = true
        
        
        // load webview
        let localPathURL = Bundle.main.url(forResource: "index", withExtension: "html")
        let request = NSURLRequest(url: localPathURL! as URL)
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        userContentController.add(self as WKScriptMessageHandler, name: JS_FUNCTION_GETLAYER_DATA)
        userContentController.add(self as WKScriptMessageHandler, name: JS_FUNCTION_SET_MAP_EXTENT)
        configuration.userContentController = userContentController
        
        self.webViewMain = WKWebView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT+SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (STATUS_BAR_HEIGHT+SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding + 49)) , configuration:configuration)
        self.webViewMain.navigationDelegate = self
        self.webViewMain.backgroundColor = UIColor.gray
        self.webViewMain.contentMode = .scaleToFill
        self.webViewMain.scrollView.showsVerticalScrollIndicator = false;
        self.view.addSubview(self.webViewMain)
        
        self.view.sendSubviewToBack(self.webViewMain)
        
        self.webViewMain.load(request as URLRequest)
        
    }
    
    private func setUpKhadiUnitScrollBar() {
        
        self.attributesArray = [["imageLink":"khadiIndiaLogo","title":"Swami Vivekanand Khadi Gramudyog","subTitle":"Khadi Store 450m","openStatus":"Open","closingTime":"Closes 8PM"],["imageLink":"khadiIndiaLogo","title":"Swami Vivekanand Khadi Gramudyog","subTitle":"Khadi Store 450m","openStatus":"Open","closingTime":"Closes 8PM"],["imageLink":"khadiIndiaLogo","title":"Swami Vivekanand Khadi Gramudyog","subTitle":"Khadi Store 450m","openStatus":"Open","closingTime":"Closes 8PM"],["imageLink":"khadiIndiaLogo","title":"Swami Vivekanand Khadi Gramudyog","subTitle":"Khadi Store 450m","openStatus":"Open","closingTime":"Closes 8PM"],["imageLink":"khadiIndiaLogo","title":"Swami Vivekanand Khadi Gramudyog","subTitle":"Khadi Store 450m","openStatus":"Open","closingTime":"Closes 8PM"]]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 49 - 200, width: SCREEN_WIDTH, height: 200), collectionViewLayout: layout)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize (width: view.frame.width, height: 200)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
        

//        peekImplementation = MSPeekCollectionViewDelegateImplementation(cellSpacing: 0,cellPeekWidth: 0)
//        peekImplementation =  MSPeekCollectionViewDelegateImplementation (cellSpacing: 10, cellPeekWidth: 10, scrollThreshold: 100, minimumItemsToScroll: 1, maximumItemsToScroll: 5, numberOfItemsToShow: 5, scrollDirection: .horizontal)
        
//        peekImplementation.delegate = self
//        collectionView.configureForPeekingDelegate()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(KhadiUnitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: KhadiUnitCollectionViewCell.self))
        self.view.addSubview(self.collectionView)
        
        self.collectionView.isHidden = true
    }
    
    private func setUpKhadiProductView() {
        
        self.khadiProductView = KhadiProductView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 49 - 201, width: SCREEN_WIDTH, height: 200))
        let options = ["Agarbatti","Honey","Handmade Paper","Leather","Processed Grain","Pottery"]
        self.khadiProductView.initDesign(pOptions: options)
        self.view.addSubview(self.khadiProductView)
        
        self.khadiProductView.isHidden = true
    }
    
    private func setupHHTabBarView() {
        
        //Default & Selected Background Color
        let defaultTabColor = UIColor.white.withAlphaComponent(0.8)
        let selectedTabColor = blueTextColor
        let tabFont = UIFont.init(name: "Helvetica-Light", size: 12.0)
        let spacing: CGFloat = 3.0
        
        //Create Custom Tabs
        //Note: As tabs are subclassed of UIButton so you can modify it as much as possible.
        
        let titles = ["Home", "Khadi Unit", "Khadi Product"]
        let icons = [UIImage(named: "homeIconGray")!, UIImage(named: "khadiUnitGray")!, UIImage(named: "khadiProductGray")!]
        let selectedIcons = [UIImage(named: "homeIconBlue")!, UIImage(named: "khadiUnitBlue")!, UIImage(named: "khadiProductBlue")!]
        var tabs = [HHTabButton]()
        
        for index in 0...2 {
            let tab = HHTabButton(withTitle: titles[index], tabImage: icons[index], index: index)
            tab.titleLabel?.font = tabFont
            tab.setTitleColor(UIColor.gray, for: .normal) //titleLabel?.textColor = UIColor.gray
            tab.setTitleColor(blueTextColor, for: .selected)
            tab.setHHTabBackgroundColor(color: defaultTabColor, forState: .normal)
            tab.setImage(selectedIcons[index], for: .selected)
            
            
            //tab.setHHTabBackgroundColor(color: selectedTabColor, forState: .selected)
            tab.imageToTitleSpacing = spacing
            tab.imageVerticalAlignment = .top
            tab.imageHorizontalAlignment = .center
            tabs.append(tab)
        }
        
        //Set HHTabBarView position.
        hhTabBarView.tabBarViewPosition = .bottom
        
        //Set this value according to your UI requirements.
        hhTabBarView.tabBarViewTopPositionValue = 64
        
        //Set Default Index for HHTabBarView.
        hhTabBarView.tabBarTabs = tabs
        
        // To modify badge label.
        // Note: You should only modify badgeLabel after assigning tabs array.
        // Example:
        //t1.badgeLabel?.backgroundColor = .white
        //t1.badgeLabel?.textColor = selectedTabColor
        //t1.badgeLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        //Handle Tab Change Event
        hhTabBarView.defaultIndex = 0
        
        //Show Animation on Switching Tabs
        hhTabBarView.tabChangeAnimationType = .none
        
        //Handle Tab Changes
        hhTabBarView.onTabTapped = { (tabIndex, isSameTab, controller) in
            if isSameTab {
                if let navcon = controller as? UINavigationController {
                    navcon.popToRootViewController(animated: true)
                } else if let vc = controller as? UIViewController {
                    vc.navigationController?.popToRootViewController(animated: true)
                }
            }
            
            if tabIndex == 1 {
                self.collectionView.isHidden = false
            } else {
                self.collectionView.isHidden = true
            }
            
            if tabIndex == 2 {
                self.khadiProductView.isHidden = false
            } else {
                self.khadiProductView.isHidden = true
            }
            
            print("Selected Tab Index:\(tabIndex)")
        }
        
        self.view.addSubview(self.hhTabBarView)
    }
    
    private func showTracksAndLayersOnMap() {
        
        /*
        // for tracks
        let tracks = MyTrack.getVisibilityOnTracksListFromDatabase()
        
        for track in tracks {
            self.executeShowHideMyTracksFunction(pTrack: track, pType: JS_PARAMETER_TYPE_TRACK, pShow: true)
        }
        
        // for layers
        let layers = Layer.getVisibilityOnLayersListFromDatabase()
        
        for layer in layers {
            
            let allFeaturesData = Layer.getLoadFeaturesData(pLayerId: layer.id!)
            print(allFeaturesData)
            
            // if data then call on map
            if allFeaturesData.count > 0 {
                self.executeShowHideLayersFunction(pType: JS_PARAMETER_TYPE_LAYER, pShow: true, pLayerId: layer.id!)
                Layer.updateLayerVisibilityInDatabase(pLayerId: layer.id!, pVisibility: 1)
            }
            
        }
        */
        
    }
    
    @objc func btnUserPressed(sender: UIButton) {
        //sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        
        let vc = LoginUserSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @objc func btnLayerEditingPressed(sender: UIButton) {
//        self.openLayersListView()
//    }
    
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
      //  self.showCurrentLocation()
        
        // show visibility on tracks / layers
      //  self.showTracksAndLayersOnMap()
    }
    
    //MARK: actions
    @objc func btnGPSPressed(sender: UIButton) {
        
        self.showCurrentLocation()
    }
    
    @objc func btnMicPressed(sender: UIButton) {
        
        
    }
    
    //MARK: textfield delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.printOn(pMessage: string)
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        if resultString.count > 3 {
            // start search
         /*   GISWebServicesManager.getStoreData(search: resultString, onCompletion: { response in
                
                if response!["success"] == true {
                    let data = response!["data"]
                    self.printOn(pMessage: data)
                    
                    var storeNames:[String] = []
                    
                    for dic in data.array! {
                        
                        self.printOn(pMessage: dic["name"])
                        storeNames.append(dic["name"].object as! String)
                    }
                    
                    self.searchTxtField.filterStrings(storeNames)
                    
                }
                
            },onError:{ error in
                
                if error == nil {
                    print("No Response")
                }
                
            })*/
            
        }
            
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.printOn(pMessage: "search('\(self.searchTxtField.text!)')")
        self.webViewMain.evaluateJavaScript("search('\(self.searchTxtField.text!)')", completionHandler: nil)
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func showCurrentLocation() {
        
    /*    let lat = "\(SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.latitude ?? 0)"
        let long = "\(SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.longitude ?? 0)"
        let accuracy = "\(SingletonClassSwift.sharedInstance.locationManager.location?.horizontalAccuracy ?? 0)"
        
        let lblLattitude = self.bottomView.view(withId: "2") as! UILabel
        let formattedLat = String(format: "%.5f", SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.latitude ?? 0)
        lblLattitude.text = "\(formattedLat) \n\(lblTitles[1])"
        
        let lblLongitude = self.bottomView.view(withId: "3") as! UILabel
        let formattedLongitude = String(format: "%.5f", SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.longitude ?? 0)
        lblLongitude.text = "\(formattedLongitude) \n\(lblTitles[2])"
        
        let lblAltitude = self.bottomView.view(withId: "4") as! UILabel
        lblAltitude.text = "\(String(format: "%.3f", SingletonClassSwift.sharedInstance.locationManager.location?.altitude ?? 0)) m\n\(lblTitles[3])"
        
        let lblAccuracy = self.bottomView.view(withId: "5") as! UILabel
        lblAccuracy.text = "\(String(format: "%.0f", SingletonClassSwift.sharedInstance.locationManager.location?.horizontalAccuracy ?? 0)) m\n\(lblTitles[4])"
        
        let accuracyFromSetting = SingletonClassSwift.sharedInstance.getDataForKey(strKey: ACCURACY_KEY) as? String
        
        if accuracyFromSetting != nil {
            
            let accuracyFromSettingFlt = Float(accuracyFromSetting!)
            let currentAccuracyFlt = Float(accuracy)
            
            // checking accuracy is greater than accur set in settings
            if accuracyFromSettingFlt! > currentAccuracyFlt! {
                self.webViewMain.evaluateJavaScript("\(SEND_LIVE_LOCATION_FUNCTION)(\(lat),\(long))", completionHandler: nil)
            } else {
                self.showToast(message: "Your GPS Accuracy is \(accuracyFromSettingFlt!)")
            }
            
            
        } else {
            
            self.webViewMain.evaluateJavaScript("\(SEND_LIVE_LOCATION_FUNCTION)(\(lat),\(long))", completionHandler: nil)
            
        }
        
        */
        
    }
  /*
    // js functions
    func executeShowHideMyTracksFunction(pTrack:MyTrack,pType:String,pShow:Bool) {
        
        // show / hide my tracks functions
        if pShow == true {
            self.webViewMain.evaluateJavaScript("\(SHOW_LAYER_FUNCTION)('\(pTrack.id!)','\(pType)')", completionHandler: nil)
        } else if pShow == false {
            self.webViewMain.evaluateJavaScript("\(HIDE_LAYER_FUNCTION)('\(pTrack.id!)','\(pType)')", completionHandler: nil)
        }
        
        
    }*/
    
    func executeShowHideLayersFunction(pType:String,pShow:Bool,pLayerId:String) {
        
        // show / hide layers functions
        if pShow == true {
            self.webViewMain.evaluateJavaScript("\(SHOW_LAYER_FUNCTION)('\(pLayerId)','\(pType)')", completionHandler: nil)
        } else if pShow == false {
            self.webViewMain.evaluateJavaScript("\(HIDE_LAYER_FUNCTION)('\(pLayerId)','\(pType)')", completionHandler: nil)
        }
        
        
    }
    
   /* func executeShowHideExternalLayersFunction(pShow:Bool,pName:String, pTitle:String, pUrl:String) {
        
        // show / hide layers functions
        if pShow == true {
            self.webViewMain.evaluateJavaScript("\(SHOW_EXTERNAL_LAYER_FUNCTION)('\(pName)','\(pTitle)','\(pUrl)')", completionHandler: nil)
        } else if pShow == false {
            self.webViewMain.evaluateJavaScript("\(HIDE_EXTERNAL_LAYER_FUNCTION)('\(pTitle)')", completionHandler: nil)
        }
        
        
    }
    */
 
   /* func executeAddLayerFunction(pType:String,pLayerId:String) {
        
        var dic = [String:Any]()
        dic["lid"] = pLayerId
        dic["type"] = pType
        
        let jsonStringArray = SingletonClassSwift.sharedInstance.getJsonStringForJSFunction(pDic:dic)
        
        // for layers
        if jsonStringArray.count > 1 {
            let jsonLayerString = jsonStringArray[0]
            let jsonStyleString = jsonStringArray[1]
            
//            if SingletonClassSwift.sharedInstance.map_context != "" {
//                print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')")
//            self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')", completionHandler: nil)
//            } else {
                print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')")
                self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')", completionHandler: nil)
            //}
            
            
            
        } else if jsonStringArray.count > 0 {
            
            let jsonLayerString = jsonStringArray[0]
            
//            if SingletonClassSwift.sharedInstance.map_context != "" {
//                print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)')")
//                self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(SingletonClassSwift.sharedInstance.map_context!)')", completionHandler: nil)
//            } else {
                print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)')")
                self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)')", completionHandler: nil)
//            }
            
           
        }
        
    }*/
 
    
//    private func showUpdatedLayersOnMap() {
//
//        var currentLayersArray = SingletonClassSwift.sharedInstance.getDataForKey(strKey: LAYERS__STYLE_UPDATED_KEY) as? [String]
//
//        if currentLayersArray != nil && currentLayersArray?.count ?? 0 > 0 {
//
//            for id in currentLayersArray! {
//                self.executeAddLayerFunction(pType: JS_PARAMETER_TYPE_LAYER, pLayerId: id)
//            }
//
//            currentLayersArray?.removeAll()
//            SingletonClassSwift.sharedInstance.setData(strData: currentLayersArray!, strKey: LAYERS__STYLE_UPDATED_KEY)
//
//        }
//
//        if SingletonClassSwift.sharedInstance.map_context != "" {
//            self.webViewMain.evaluateJavaScript("setMapExtent('\(SingletonClassSwift.sharedInstance.map_context!)')", completionHandler: nil)
//        }
//
//        SingletonClassSwift.sharedInstance.map_context = ""
//
//
//    }
    
}

//MARK:- WKScriptMessageHandler
extension GISViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.name as! String)
        print(message.body as! Any)
    /*
        // get layer data
        if message.name == JS_FUNCTION_GETLAYER_DATA {
            // get layer data
            
            let dic = message.body as! [String:Any]
            print(dic["lid"]!)
            print(dic["type"]!)
            
            let jsonStringArray = SingletonClassSwift.sharedInstance.getJsonStringForJSFunction(pDic:dic)
            
            if (dic["type"]! as! String) == JS_PARAMETER_TYPE_TRACK {
                // track
                if jsonStringArray.count > 0 {
                    let jsonLayerString = jsonStringArray[0]
                    self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_TRACK)')", completionHandler: nil)
                }
                
                
            } else if (dic["type"]! as! String) == JS_PARAMETER_TYPE_LAYER {
                
                // for layers
                if jsonStringArray.count > 1 {
                    let jsonLayerString = jsonStringArray[0]
                    let jsonStyleString = jsonStringArray[1]
                    
                    print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')")
                    self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)','\(jsonStyleString)')", completionHandler: nil)
                    
                } else if jsonStringArray.count > 0 {
                    
                    let jsonLayerString = jsonStringArray[0]
                    
                    print("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)')")
                    self.webViewMain.evaluateJavaScript("\(ADD_LAYER_FUNCTION)('\(jsonLayerString)','\(JS_PARAMETER_TYPE_LAYER)')", completionHandler: nil)
                }
                
            }
 
        }*/
        
    }
}

extension GISViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attributesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KhadiUnitCollectionViewCell", for: indexPath) as! KhadiUnitCollectionViewCell
        cell.delegate = self
        let dic = attributesArray[indexPath.row]
        
        cell.configure(dic: dic)
        
        return cell
    }
}

extension GISViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 40 , height: Int(collectionView.bounds.height))
    }
}

extension GISViewController: MSPeekImplementationDelegate {
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didChangeActiveIndexTo activeIndex: Int) {
        print("Changed active index to \(activeIndex)")
      //  self.lblPageNumber.text = "\(activeIndex + 1) of \(self.attributesArray.count)"
      //  self.showRecordNo = activeIndex
        
      //  let dic = attributesArray[activeIndex]
       // self.currentAttrubuteDic = dic
       // self.delegate.displayCurrentAttributeScreen(pAttributeDic: self.currentAttrubuteDic)
    }
    
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
        
    }
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
