//
//  LoginUserSelectionViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 01/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit

class LoginUserSelectionViewController: UIViewController {

    fileprivate var pmegmBtn:CustomImageButton!
    fileprivate var krdpBtn:CustomImageButton!
    fileprivate var assetsBtn:CustomImageButton!
    var loginObj:GISSignInViewController!
    fileprivate var buttonBack: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        // Do any additional setup after loading the view.
        self.initDesign()

        if let delegate = UIApplication.shared.delegate as? KVICAppDelegate {
            //            SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding =  Int(delegate.topSpace)
            SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding =  Int(delegate.bottomSpace)
            
            print( SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
            print(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding)
        }
       // Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(pushMap), userInfo: nil, repeats: false)

    }
    
    @objc private func pushMap() {
        let vc = KhadiStoreListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBackPressed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
    private func initDesign() {
        
        let scrlview = UIScrollView (frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        var yPosition = 0
        
        self.buttonBack = UIButton(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        self.buttonBack.setTitle("Back", for: .normal)
        self.buttonBack.setTitleColor(blueTextColor, for: .normal)
        self.buttonBack.contentHorizontalAlignment = .left
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.addTarget(self, action: #selector(btnBackPressed(sender:)), for: .touchUpInside)
        scrlview.addSubview(self.buttonBack)
        
         yPosition += 40 + 20
        
        let imgLogo = UIImageView(frame: CGRect(x: 0, y: yPosition, width: 229, height: 94))
        imgLogo.backgroundColor = UIColor.gray
        imgLogo.image = UIImage(named: "khadiIndiaLogo")
        imgLogo.center = CGPoint(x: self.view.center.x, y: imgLogo.frame.origin.y + (imgLogo.frame.size.height/2))
        scrlview.addSubview(imgLogo)
        
        yPosition += 94 + 20
        
        let lblLoginAs = UILabel(frame: CGRect(x: 50, y: yPosition, width: 100, height: 50))
        lblLoginAs.textColor = blueTextColor
        lblLoginAs.center = CGPoint(x: SCREEN_WIDTH/2, y: Int(lblLoginAs.frame.origin.y + 25))
        lblLoginAs.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        lblLoginAs.text = "LOGIN AS"
        lblLoginAs.textAlignment = .center
        scrlview.addSubview(lblLoginAs)
        
        yPosition += 70
        
        self.pmegmBtn = CustomImageButton(frame: CGRect(x: SCREEN_WIDTH - 100, y: yPosition, width: 100, height: 100))
        self.pmegmBtn.initDesign(pTitle: "PMEGP", pImage: UIImage(named: "userIcon")!)
        self.pmegmBtn.backgroundColor = UIColor.clear
        self.pmegmBtn.center = CGPoint(x: SCREEN_WIDTH/2, y: Int(self.pmegmBtn.frame.origin.y + 36))
        self.pmegmBtn.addTarget(self, action: #selector(btnPMEGMPressed(sender:)), for: .touchUpInside)
        scrlview.addSubview(self.pmegmBtn)
        
        yPosition += 120
        
        self.krdpBtn = CustomImageButton(frame: CGRect(x: SCREEN_WIDTH - 100, y: yPosition, width: 100, height: 100))
        self.krdpBtn.initDesign(pTitle: "KHADI", pImage: UIImage(named: "userIcon")!)
        self.krdpBtn.backgroundColor = UIColor.clear
        self.krdpBtn.center = CGPoint(x: SCREEN_WIDTH/2, y: Int(self.krdpBtn.frame.origin.y + 36))
        self.krdpBtn.addTarget(self, action: #selector(btnKRDPPressed(sender:)), for: .touchUpInside)
        scrlview.addSubview(self.krdpBtn)
        
        yPosition += 120
        
        self.assetsBtn = CustomImageButton(frame: CGRect(x: SCREEN_WIDTH - 100, y: yPosition, width: 100, height: 100))
        self.assetsBtn.initDesign(pTitle: "ASSETS", pImage: UIImage(named: "userIcon")!)
        self.assetsBtn.backgroundColor = UIColor.clear
        self.assetsBtn.center = CGPoint(x: SCREEN_WIDTH/2, y: Int(self.assetsBtn.frame.origin.y + 36))
        self.assetsBtn.addTarget(self, action: #selector(btnKRDPPressed(sender:)), for: .touchUpInside)
        scrlview.addSubview(self.assetsBtn)
        
        yPosition += 120

//        scrlview.contentSize = CGSize (width: SCREEN_WIDTH, height: CGFloat(yPosition))
        scrlview.contentSize = CGSize (width: SCREEN_WIDTH, height: yPosition)
        self.view.addSubview(scrlview)
        
    }
    
    // MARK:- actions
    @objc private func btnPMEGMPressed(sender:UIButton) {
        self.loginObj = GISSignInViewController()
        self.navigationController?.pushViewController(self.loginObj, animated: true)
    }
    
    @objc private func btnKRDPPressed(sender:UIButton) {
        self.loginObj = GISSignInViewController()
        self.navigationController?.pushViewController(self.loginObj, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
