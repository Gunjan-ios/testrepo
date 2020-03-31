//
//  VTVSplashScreenViewController.swift
//  VTVNewsApp
//
//  Created by Gaurav on 03/04/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class GISSplashScreenViewControllerSwift: UIViewController {
    
    var myNavigationController:NavigationController?
    var mainUrlData:Data?
    var vcGISMain:GISViewController?
    
    //MARK:- Life Cycle
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        if let delegate = UIApplication.shared.delegate as? KVICAppDelegate {
            //            SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding =  Int(delegate.topSpace)
            SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding =  Int(delegate.bottomSpace)
            
            print( SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
            print(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding)
        }


        let imgFullScreen = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        imgFullScreen.center = self.view.center
//        imgFullScreen.contentMode = .scaleAspectFi
        imgFullScreen.image = UIImage(named: "splashImage")
        self.view.addSubview(imgFullScreen)
        
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(goToMapScreen), userInfo: nil, repeats: false)
        
    }
    
    @objc func goToNextScreen() {
        let appFormViewController = KVICApplicationFormIndividualViewController()
        self.navigationController?.pushViewController(appFormViewController, animated: true)
    }
    
    @objc func goToMapScreen() {
        
       // let isSignedIn = SingletonClassSwift.sharedInstance.getDataForKey(strKey: REMEMBER_ME_KEY) as? Bool
        //        let isSignedIn = true // temp
        
       
            vcGISMain = GISViewController()
            myNavigationController = NavigationController(rootViewController: vcGISMain!)
            myNavigationController?.navigationBar.isHidden = true
            myNavigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            let mainViewController = MainViewController()
            mainViewController.isLeftViewStatusBarHidden = false
            mainViewController.rootViewController = myNavigationController
            mainViewController.myVTVNavigarionController = myNavigationController
            mainViewController.setup(type: UInt(1))
            // mainViewController.setup(type: UInt(9))
            mainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = mainViewController

        
    }
    
    @objc func appFormPressed(sender:UIButton) {
        self.goToNextScreen()
    }
    
    @objc func mapPressed(sender:UIButton) {
        self.goToMapScreen()
    }
    
    private let allowedDiskSize = 100 * 1024 * 1024
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "gifCache")
    }()
    
    enum Result<Value,Value2> {
        case success(Value)
        case failure(Value2)
    }
    
    typealias DownloadCompletionHandler = (Result<Data,Error>) -> ()
    
    private func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }
    
    private func downloadContent(fromUrlString: String, completionHandler: @escaping DownloadCompletionHandler) {
        
        guard let downloadUrl = URL(string: fromUrlString) else { return }
        let urlRequest = URLRequest(url: downloadUrl)
        // First try to fetching cached data if exist
        if let cachedData = self.cache.cachedResponse(for: urlRequest) {
            print("Cached data in bytes:", cachedData.data)
            completionHandler(.success(cachedData.data))
            
        } else {
            // No cached data, download content than cache the data
            createAndRetrieveURLSession().dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    
                    let cachedData = CachedURLResponse(response: response!, data: data!)
                    self.cache.storeCachedResponse(cachedData, for: urlRequest)
                    
                    completionHandler(.success(data!))
                }
                }.resume()
        }
    }
}
