//
//  VerificationDetailViewController.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 13/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerificationDetailViewController: UIViewController,UIScrollViewDelegate {
    
        // Screen Controls
        fileprivate var headerview:UIView!
        fileprivate var buttonBack: UIButton!
        fileprivate var buttonSave: UIButton!
        fileprivate var lblHeader:UILabel!
        fileprivate var global_Y_Position:Int! = 0
        fileprivate var Internal_Y_Space:Int! = 0


        var pTag : Int! = -1
        var app_Id:String!
        var storeViewData:JSON!
        var isFromVerification:Bool!

        fileprivate let spacing = 20
        fileprivate let controlsHeight = 70
        let common_margin : Int = 20
        var previewVC:PreviewViewController!

        fileprivate var VerificationStatus:MarginSelectView!
        fileprivate var VerificationDate:CustomComboBoxView!
        fileprivate var verificationAgencyName:CustomInputFieldView!
        fileprivate var remark:CustomInputTextView!


        fileprivate var appFormScrollView:UIScrollView!
        fileprivate var verificationStatusStr = "Working"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initHeader()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    private func initHeader() {
        
        global_Y_Position = ( STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
        
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
                self.buttonBack.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        self.buttonSave = UIButton(frame: CGRect(x: SCREEN_WIDTH - HEADER_BUTTON_WIDTH, y: 0, width: HEADER_BUTTON_WIDTH, height: TOP_HEADER_HEIGHT))
        self.buttonSave.setTitle("Save", for: .normal)
        self.buttonSave.setTitleColor(blueTextColor, for: .normal)
        self.buttonSave.backgroundColor = UIColor.clear
        self.buttonSave.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonSave.addTarget(self, action: #selector(btnDonePressed), for: .touchUpInside)
        headerview.addSubview(self.buttonSave)
        
        self.lblHeader = UILabel(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH - 100, height: TOP_HEADER_HEIGHT))
        self.lblHeader.textColor = blueTextColor
        self.lblHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        
        if self.isFromVerification == true {
            self.lblHeader.text = "Verification Detail"
        } else {
            self.lblHeader.text = "Mark As Not Traceable"
        }
        self.lblHeader.textAlignment = .center
        headerview.addSubview(self.lblHeader)
        
        global_Y_Position += TOP_HEADER_HEIGHT + common_margin
        self.initScrollView()
    }
    
    @objc func btnDonePressed() {

        let agancyName = verificationAgencyName.view(withId: "\(VerificationTAG24)") as! CustomTextField
        let reason = remark.view(withId: "\(VerificationTAG25)") as! CustomTextView
        
        var appId:String!
        var verificationStatus:String!
        
        if self.isFromVerification == true {
            // verification
            verificationStatus = self.verificationStatusStr
            appId = self.storeViewData["app_id"].stringValue
        } else {
            // mark as not traceble
            appId = self.app_Id
            verificationStatus = "Non-Traceable"
        }
        
        if agancyName.text?.isEmpty == true {
               self.displayAlertMessage(pMessage: "Please enter Agency Name")
               return
        } else if reason.text?.isEmpty == true {
            
            if self.isFromVerification == true {
                self.displayAlertMessage(pMessage: "Please enter remark")
            } else {
                self.displayAlertMessage(pMessage: "Please enter reason")
            }
               return
        }
        
//        SingletonClassSwift.showLoading(title: "Loading..")
//        var arrAppIds = [String]()
//        arrAppIds.append(self.app_Id)
//        SingletonClassSwift.sharedInstance.setData(strData: arrAppIds, strKey: STORE_NOT_TRACEBLE_ARRAY)
//        SingletonClassSwift.sharedInstance.is_preview_done = true
//        self.navigationController?.popViewController(animated: true)

            
            
        GISWebServicesManager.getMarkAsNonTracebleWS(appId: appId, verificationStatus: verificationStatus , agencyName: agancyName.text!, remarks: reason.text!,onCompletion: { response in

            SingletonClassSwift.hideLoading()

            let message = response!["data"].stringValue

              let alert = UIAlertController(title: "Message", message: message, preferredStyle:
                      .alert)

                  alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler:{ (UIAlertAction)in

                    if self.isFromVerification == true {

                        SingletonClassSwift.sharedInstance.setData(strData: true, strKey: IS_VERIFICATION_SCREEN_DONE)
                        self.previewVC = PreviewViewController()
                        self.previewVC.appid = self.storeViewData["app_id"].stringValue
                        self.previewVC.storeViewData = self.storeViewData
                            self.navigationController?.pushViewController(self.previewVC, animated: true)
                    } else {
                        var arrAppIds = [String]()
                        arrAppIds.append(self.app_Id)
                        SingletonClassSwift.sharedInstance.setData(strData: arrAppIds, strKey: STORE_NOT_TRACEBLE_ARRAY)
                        SingletonClassSwift.sharedInstance.is_preview_done = true
                        self.navigationController?.popViewController(animated: true)
                    }


                  }))

                  self.present(alert, animated: true, completion:nil)

        },onError:{ error in
            if error != nil {
                self.displayAlertMessage(pMessage: "Something went wrong. ")
            }
        })
    }
    @objc func btnBackPressed() {
        
        SingletonClassSwift.sharedInstance.setData(strData: true, strKey: INSPECTION_EDIT_MODE)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initScrollView() {
        
        self.appFormScrollView = UIScrollView (frame: CGRect (x: 0, y: global_Y_Position, width: SCREEN_WIDTH, height:  SCREEN_HEIGHT - global_Y_Position))
        self.appFormScrollView.showsVerticalScrollIndicator = false
        self.appFormScrollView.isScrollEnabled = true
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height)
        self.appFormScrollView.delegate = self
        
        self.initViewDetails()
    }
    
    func initViewDetails() {
        
        Internal_Y_Space = 10
        

        if self.isFromVerification == true {
            
            VerificationStatus = MarginSelectView(frame:  CGRect(x: X_PADDING, y: Internal_Y_Space, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
                  VerificationStatus.initDesign(pName: "Verification Status", pTag: VerificationTAG22, pOptions: ["Working","Not Working"])
                  VerificationStatus.verificationDelegateApp = self
                  appFormScrollView.addSubview(VerificationStatus)
                  
                  Internal_Y_Space += controlsHeight + common_margin
        }


        VerificationDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: Internal_Y_Space, width: Int(self.appFormScrollView.frame.size.width)  - (X_PADDING * 2), height: controlsHeight))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
       let currDate = dateFormatter.string(from: Date())
        VerificationDate.initDesign(pName: "Verification Date", pTag: VerificationTAG23, pOptions: [],pPlaceHolder: currDate)
        VerificationDate.setDatePicker()
        VerificationDate.isUserInteractionEnabled = false
        appFormScrollView.addSubview(VerificationDate)
        
        Internal_Y_Space += controlsHeight + common_margin

        verificationAgencyName = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: Internal_Y_Space, width: Int(self.appFormScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        verificationAgencyName.verificationDelegateApp = self
        verificationAgencyName.tag = VerificationTAG36
        verificationAgencyName.initDesign(pName: "Verification Agency Name*", pTag: VerificationTAG24,pPlaceHolder: "")
        appFormScrollView.addSubview(verificationAgencyName)
        
        Internal_Y_Space += controlsHeight + common_margin

        remark = CustomInputTextView(frame: CGRect(x: X_PADDING, y: Internal_Y_Space, width: Int(self.appFormScrollView.frame.size.width) - (X_PADDING * 2), height: 125))
        remark.verificationDelegateApp = self
        remark.tag = VerificationTAG37
        
        if self.isFromVerification == true {
                   remark.initDesign(pName: "Remarks*", pTag:VerificationTAG25,pPlaceHolder: "")
               } else {
                   remark.initDesign(pName: "Reason*", pTag:VerificationTAG25,pPlaceHolder: "")
               }
        
        
        appFormScrollView.addSubview(remark)
        
        Internal_Y_Space += controlsHeight + common_margin

        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: CGFloat(Internal_Y_Space))
        self.view.addSubview(self.appFormScrollView)
    }
    
    func SavePressed() {
       
       
    }
    
    // MARK:- Others
    func verficationSelectedButton(radioButton : DLRadioButton) {
        self.verificationStatusStr = radioButton.selected()!.titleLabel!.text!
    }
   
   

}
