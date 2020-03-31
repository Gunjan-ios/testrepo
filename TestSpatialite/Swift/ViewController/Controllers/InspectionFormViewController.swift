//
//  infectionFormViewController.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 29/01/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit

import FlexibleSteppedProgressBar
import MobileCoreServices
import AVFoundation
import AssetsLibrary
import Photos
import SwiftyJSON

class InspectionFormViewController: UIViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate,UIPickerViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate{
    
        // Screen Controls
        fileprivate var headerview:UIView!
        fileprivate var buttonBack: UIButton!
        fileprivate var buttonSave: UIButton!
        fileprivate var lblHeader:UILabel!
        fileprivate var global_Y_Position:Int! = 0
        fileprivate var global_ADD_Y_Position:Int! = 0
        fileprivate var internal_view_Space : Int = 90
        fileprivate var globalScroll_Y_Position:Int! = 0
        fileprivate let spacing = 20
        fileprivate let controlsHeight = 70
        fileprivate let controlsHeightWithPhoto = 180
        let common_margin : Int = 20
    
        var VerificationDetailVC:VerificationDetailViewController!
        var viewAlert = AlertView()
        var picker:UIImagePickerController!
        fileprivate var importMenuForImages:UIDocumentPickerViewController!
        var isFromTable:Bool! = false
        fileprivate var imagesDic = [Dictionary<String, String>]()
        fileprivate var tabAdd_View:UIView!
        fileprivate var tabVIEW_View:UIView!
    
    
    
        //SUBHEADER (VIEW,ADD,UPLOAD)
        fileprivate var subHeaderview:UIView!
        fileprivate var formView:UIView!
        fileprivate var buttonView: UIButton!
        fileprivate var buttonAdd: UIButton!
        fileprivate var buttonUpload: UIButton!

        //SCROLLVIEW
        fileprivate var appFormScrollView:UIScrollView!
        fileprivate var appAddScrollView:UIScrollView!
        fileprivate var appUploadScrollView:UIScrollView!

        //BeneficialyView
        fileprivate var BeneficialyView:UIView!
        fileprivate var beneficiary_ID: DynamicLabel!
        fileprivate var beneficiary_Name: DynamicLabel!
        fileprivate var gender: DynamicLabel!
        fileprivate var social_Category: DynamicLabel!
        fileprivate var special_Category: DynamicLabel!
        fileprivate var email_ID: DynamicLabel!
        fileprivate var mobile_Number: DynamicLabel!

        //UnitDetail
        fileprivate var unitDetailView:UIView!
        fileprivate var office_Name: DynamicLabel!
        fileprivate var agency: DynamicLabel!
        fileprivate var unit_Location: DynamicLabel!
        fileprivate var industry_Type: DynamicLabel!
        fileprivate var industry_Activity: DynamicLabel!
        fileprivate var product_Description: DynamicLabel!
        fileprivate var address: DynamicLabel!
        fileprivate var edp_Completed: DynamicLabel!
        fileprivate var taluka: DynamicLabel!
        fileprivate var district: DynamicLabel!
        fileprivate var state: DynamicLabel!
        fileprivate var pincode: DynamicLabel!
        fileprivate var stateView:CustomInputFieldView!
        fileprivate var districtView:CustomInputFieldView!
        fileprivate var pincodeView:CustomOTPTypeView!
        fileprivate  var talukaView:CustomInputFieldView!
        fileprivate  var addressView:CustomInputTextView!
    
        // FOR COPYBUTTON
        var currentAddr : CustomTextView!
    
        var  fulltimeVl : CustomTextField!
        var  parttimeVl : CustomTextField!
        var  seasonalVl : CustomTextField!
        var  femaleEmpVl : CustomTextField!
        var  maleEmpVl : CustomTextField!
        var  totalEmpVl : CustomTextField!



        //ProjectCost Detail
        fileprivate var projectCostView:UIView!
        fileprivate var capital_Expenditure: DynamicLabel!
        fileprivate var working_Capital: DynamicLabel!
        fileprivate var own_Contribution: DynamicLabel!
        fileprivate var total: DynamicLabel!

        //Bank Detail
        fileprivate var bankDeatilView:UIView!
        fileprivate var bank: DynamicLabel!
        fileprivate var branch: DynamicLabel!
        fileprivate var bank_Address: DynamicLabel!
        fileprivate var ifscCode: DynamicLabel!
        fileprivate var myProgressBar: FlexibleSteppedProgressBar!
        fileprivate var myProgressBarAdd: FlexibleSteppedProgressBar!

    
        //ADD UNIT
        fileprivate var addUnitDetailView:UIView!
        fileprivate var copyAddress:UIButton!
        fileprivate var UdyogAadharNumber:CustomOTPTypeView!
        fileprivate var UnitName:CustomInputTextView!
        fileprivate var UnitEstablishmentDate:CustomComboBoxView!
        fileprivate var ProductionCommencementDate:CustomComboBoxView!

        //ADD SALES
        fileprivate var addSalesDetailView:UIView!
        fileprivate var  SalesValueperYear :CustomInputFieldView!
        fileprivate var ProductionValue :CustomInputFieldView!
        fileprivate var  SalesValue:CustomInputFieldView!

        //ADD UNITINFO
        fileprivate var addEmploymentDetailView:UIView!
        fileprivate var  N_FemaleEmployees :CustomInputFieldView!
        fileprivate var N_MaleEmployees :CustomInputFieldView!
        fileprivate var  TotalNumberEmployees:CustomInputFieldView!
        fileprivate var  fullTimeView:CustomInputFieldView!
        fileprivate var  partTimeView:CustomInputFieldView!
        fileprivate var  seasonalView:CustomInputFieldView!

        //ADD MMVIEW
        fileprivate var addMarginMoneyView:UIView!
        fileprivate var marginAmount: DynamicLabel!
        fileprivate var marginReleaseDate: DynamicLabel!
        fileprivate var ReasonCallBack:CustomInputTextView!
        fileprivate var CallBackAmount:CustomInputFieldView!
        fileprivate var marginSelected:MarginSelectView!
        var selectedStatus: String!
        fileprivate var btnNextMarginView : CustomButton!
        fileprivate var yScroll_subscroll : Int!
    
        //VIEWS  Y POINT
        var slideToY_unitDetail : CGFloat!
        var slideToY_projectcost : CGFloat!
        var slideToY_bankDetail : CGFloat!
        var slideToY_sales : CGFloat!
        var slideToY_employment : CGFloat!
        var slideToY_margin : CGFloat!
    
        //PROGRESSVIEW PROPERTY
        fileprivate var progressColor = UIColor(red: 53.0 / 255.0, green: 226.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0)
        fileprivate var textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        fileprivate var maxIndex = -1

       // DICTIONARY FOR WS
        var dic_unitInfo = NSMutableDictionary()
        var dic_unitMMInfo = NSMutableDictionary()
        var dic_unitProd = NSMutableDictionary()
        var dic_verifierInfo = NSMutableDictionary()
        var storeViewData:JSON!
        var KVICimagesArray : [imageData]? = [imageData]()
        var ALLimagesArray : [imageData]? = [imageData]()

//        fileprivate let VIEW_VIEW_TAG = 4001
//        fileprivate let ADD_VIEW_TAG = 4002
        fileprivate let UPLOAD_VIEW_TAG = 4003
        fileprivate var btnNextUploadView : CustomButton!
    
    var previewVC:PreviewViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SingletonClassSwift.sharedInstance.is_address_changed == true {
            currentAddr = (addressView.view(withId: "\(TAG1)") as! CustomTextView)
            currentAddr.text = SingletonClassSwift.sharedInstance.address
            SingletonClassSwift.sharedInstance.is_address_changed = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.view.backgroundColor = UIColor.white
        
        self.initHeader()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.resetStoredImages()
        
        SingletonClassSwift.sharedInstance.setData(strData: false, strKey: IS_VERIFICATION_SCREEN_DONE)
    }
    
    private func resetStoredImages() {
        
        SingletonClassSwift.sharedInstance.setImageData(strData: [imageData](), strKey: STORED_UNIT_PHOTOS_KEY)
        SingletonClassSwift.sharedInstance.setImageData(strData: [imageData](), strKey: STORED_PRODUCT_PHOTOS_KEY)
        SingletonClassSwift.sharedInstance.setImageData(strData: [imageData](), strKey: STORED_MANIFACTURING_UNIT_PHOTOS_KEY)
        SingletonClassSwift.sharedInstance.setImageData(strData: [imageData](), strKey: STORED_ACHIEVEMENT_PHOTO_KEY)
        SingletonClassSwift.sharedInstance.setImageData(strData: [imageData](), strKey: STORED_MANIFACTURING_UNIT_VIDEO_KEY)
        
        
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
        self.buttonBack.addTarget(self, action: #selector(buttonBackPressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
//        self.buttonSave = UIButton(frame: CGRect(x: SCREEN_WIDTH - HEADER_BUTTON_WIDTH, y: 0, width: HEADER_BUTTON_WIDTH, height: TOP_HEADER_HEIGHT))
//        self.buttonSave.setTitle("Save", for: .normal)
//        self.buttonSave.setTitleColor(blueTextColor, for: .normal)
//        self.buttonSave.backgroundColor = UIColor.clear
//        self.buttonSave.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
//        self.buttonSave.addTarget(self, action: #selector(btnSavePressed), for: .touchUpInside)
//        headerview.addSubview(self.buttonSave)
        
        self.lblHeader = UILabel(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH - 100, height: TOP_HEADER_HEIGHT))
        self.lblHeader.textColor = blueTextColor
        self.lblHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        self.lblHeader.text = "Inspection Form"
        self.lblHeader.textAlignment = .center
        headerview.addSubview(self.lblHeader)
        
        self.initPersonalDetails()
    }
    
    @objc func btnSavePressed() {

        self.openAlertView()
    }
    
     func onPreviewPressed() {
        viewAlert.removeFromSuperview()
        
        let isVerifyDone = SingletonClassSwift.sharedInstance.getDataForKey(strKey: IS_VERIFICATION_SCREEN_DONE) as! Bool
        
        if isVerifyDone == true {
            self.previewVC = PreviewViewController()
            self.previewVC.appid = self.storeViewData["app_id"].stringValue
            self.previewVC.storeViewData = self.storeViewData
            self.navigationController?.pushViewController(self.previewVC, animated: true)
        } else {
           self.VerificationDetailVC = VerificationDetailViewController()
           self.VerificationDetailVC.storeViewData = self.storeViewData
           self.VerificationDetailVC.isFromVerification = true
    
           self.navigationController?.pushViewController(self.VerificationDetailVC, animated: true)
        }
    
        
       
    }
    
    private func openAlertView() {
        
        if viewAlert != nil {
            viewAlert.removeFromSuperview()
        }
        
        viewAlert = AlertView (frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH , height: SCREEN_HEIGHT))
        viewAlert.initDesign(title: "Form Saved Successfully.", btnTitle: "Okay")
        viewAlert.alertDelegate = self
        viewAlert.backgroundColor = ALERT_BACKGROUND_COLOUR
        viewAlert.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        self.view.addSubview(viewAlert)
    }

    private func initPersonalDetails() {
        
        global_Y_Position += TOP_HEADER_HEIGHT + 3

        subHeaderview = UIView(frame: CGRect(x: 0, y: global_Y_Position, width: Int(UIScreen.main.bounds.width), height: TOP_SUBHEADER_HEIGHT));
        subHeaderview.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        self.view.addSubview(subHeaderview)

        let view1 = UIView(frame: CGRect(x: X_PADDING, y: 1, width: controlsHeight, height: controlsHeight))
        subHeaderview.addSubview(view1)

        self.buttonView = UIButton(frame: CGRect(x: 0, y: 5, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
        self.buttonView.center = CGPoint(x:Int(view1.center.x), y: Int(buttonView.center.y))
        printOn(pMessage: self.buttonView.frame)
        self.buttonView.titleLabel?.font = UIFont .boldSystemFont(ofSize:LABEL_FONT_SIZE )
        self.buttonView.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonView.backgroundColor = UIColor.clear
        self.buttonView.isSelected = true
        self.buttonView.setBackgroundImage(UIImage (named: "first"), for: .normal)
        self.buttonView.setBackgroundImage(UIImage (named: "firstSelect"), for: .selected)
        self.buttonView.tag = 1
        //        self.buttonView.isEnabled = true
        self.buttonView.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        view1.addSubview(self.buttonView)

        let lbl_view = tabLabel (frame: CGRect (x: 0, y:SUBHEADER_BUTTON_HEIGHT + 7, width: Int(view1.frame.width), height: 20))
        printOn(pMessage: lbl_view.frame)
        lbl_view.center = CGPoint (x: view1.center.x, y: lbl_view.center.y)
        lbl_view.text = "View"
        view1.addSubview(lbl_view)

        self.buttonAdd = UIButton(frame: CGRect(x: 0 , y: 6, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
        self.buttonAdd.center = CGPoint(x:Int(subHeaderview.center.x), y: Int(self.buttonAdd.center.y))
        printOn(pMessage: self.buttonAdd.frame)

        self.buttonAdd.isSelected = false
        //        self.buttonAdd.isEnabled = true
        self.buttonAdd.titleLabel?.font = UIFont .boldSystemFont(ofSize:LABEL_FONT_SIZE )
        self.buttonAdd.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonAdd.backgroundColor = UIColor.clear
        self.buttonAdd.setBackgroundImage(UIImage (named: "second"), for: .normal)
        self.buttonAdd.setBackgroundImage(UIImage (named: "secondSelect"), for: .selected)
        self.buttonAdd.tag = 2
        self.buttonAdd.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        subHeaderview.addSubview(self.buttonAdd)

        let lbl_add = tabLabel (frame: CGRect (x: 0, y: SUBHEADER_BUTTON_HEIGHT + 7, width:SUBHEADER_BUTTON_WIDTH, height: 20))
        printOn(pMessage: lbl_add.frame)
        lbl_add.center = CGPoint(x:Int(subHeaderview.center.x), y: Int(lbl_add.center.y))
        lbl_add.text = "Add"
        subHeaderview.addSubview(lbl_add)


        printOn(pMessage: "")
        let upload_View = UIView(frame: CGRect(x: Int(subHeaderview.frame.width) - controlsHeight - (X_PADDING*2), y: 1, width: controlsHeight, height: controlsHeight))
        subHeaderview.addSubview(upload_View)

        self.buttonUpload = UIButton(frame: CGRect(x: X_PADDING, y: 5, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
        //        self.buttonUpload.center = CGPoint (x: Int(upload_View.center.x), y: Int(self.buttonUpload.center.y))
        printOn(pMessage: self.buttonUpload.frame)
        self.buttonUpload.isSelected = false
        self.buttonUpload.isEnabled = false
        //        self.buttonUpload.backgroundColor = .red
        self.buttonUpload.titleLabel?.font = UIFont (name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        self.buttonUpload.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonUpload.backgroundColor = UIColor.clear
        self.buttonUpload.setBackgroundImage(UIImage (named: "third"), for: .normal)
        self.buttonUpload.setBackgroundImage(UIImage (named: "thirdSelect"), for: .selected)
        self.buttonUpload.tag = 3
        self.buttonUpload.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        upload_View.addSubview(self.buttonUpload)

        let lbl_upload = tabLabel (frame: CGRect (x: 0, y:SUBHEADER_BUTTON_HEIGHT + 7, width: Int(upload_View.frame.width), height: 20))
        lbl_upload.text = "Upload"
        //        lbl_upload.center = CGPoint (x: upload_View.center.x, y: lbl_upload.center.y)
        upload_View.addSubview(lbl_upload)


        global_Y_Position += TOP_SUBHEADER_HEIGHT + common_margin
        global_ADD_Y_Position =  global_Y_Position

        self.initScrollView()
        //self.tabAdd_View = UIView()
       // self.appUploadScrollView = UIScrollView()
        
    }
    
    //------------------------------------------
    //    MARK:  VIEW SECTION
    //------------------------------------------
    
    private func initScrollView() {
        
        self.tabVIEW_View = UIView (frame:  CGRect (x: 0, y: CGFloat (global_Y_Position), width: self.view.frame.width, height: self.view.frame.height - CGFloat (global_Y_Position)))
        globalScroll_Y_Position = 10
        
        self.myProgressBar = FlexibleSteppedProgressBar()
        myProgressBar.frame = CGRect(x: 40, y: CGFloat(globalScroll_Y_Position) , width: UIScreen.main.bounds.width - 70, height: CGFloat(TOP_PROGRESSBAR_HEIGHT))
        myProgressBar.center = CGPoint (x: self.view.center.x, y: myProgressBar.center.y)
        self.tabVIEW_View.addSubview(myProgressBar)
        
        myProgressBar.numberOfPoints = 4
        myProgressBar.lineHeight = 5
        myProgressBar.radius = 20
        myProgressBar.progressRadius = 21
        myProgressBar.progressLineHeight = 5
        myProgressBar.delegate = self
        myProgressBar.backgroundShapeColor = UIColor.lightGray
        myProgressBar.selectedBackgoundColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBar.selectedOuterCircleStrokeColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBar.currentSelectedCenterColor = UIColor.white
        myProgressBar.stepTextColor = labelTextColor
        myProgressBar.visitedStepTextColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBar.currentSelectedTextColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBar.stepTextFont = UIFont (name: APP_FONT_NAME, size: 10)
        myProgressBar.currentIndex = 0
        myProgressBar.stepAnimationDuration = 0.0
        
        globalScroll_Y_Position += TOP_PROGRESSBAR_HEIGHT + common_margin + 20

        self.appFormScrollView = UIScrollView (frame: CGRect (x: 0, y:  CGFloat (globalScroll_Y_Position), width: self.view.frame.width, height: self.tabVIEW_View.frame.height - CGFloat (globalScroll_Y_Position)))
        
        let scrollViewHeight:CGFloat = self.appFormScrollView.frame.height
        
        BeneficialyView = UIView(frame: CGRect (x:0 , y: 0, width: self.appFormScrollView.frame.width, height: scrollViewHeight))
    
        
        self.appFormScrollView.addSubview(BeneficialyView)
        self.appFormScrollView.showsVerticalScrollIndicator = false
        self.appFormScrollView.isScrollEnabled = true
         self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.delegate = self
        self.tabVIEW_View.addSubview(self.appFormScrollView)
        self.view.addSubview(self.tabVIEW_View)
        self.initBeneficialyDetails()
    }
    
    //MARK:- Beneficialy
    
    private func initBeneficialyDetails() {
        
        var internal_Space : Int = 20

        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Beneficiary Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        BeneficialyView.addSubview(lblTitle)

        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Beneficiary ID"
        BeneficialyView.addSubview(lbl_Beneficiary_ID)

        beneficiary_ID = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        beneficiary_ID.text = self.storeViewData["app_id"].string
        BeneficialyView.addSubview(beneficiary_ID)

        internal_Space += Int(beneficiary_ID.bounds.height) + common_margin

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Beneficiary Name"
        BeneficialyView.addSubview(lbl_Beneficiary_Name)

        beneficiary_Name = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:LABEL_HEIGHT))
        beneficiary_Name.text = self.storeViewData["app_name"].string
        self.printOn(pMessage: beneficiary_Name.text)
        let hight = SingletonClassSwift.sharedInstance.heightForView(text:beneficiary_Name.text , width: CGFloat(LABEL_WIDTH), Label: beneficiary_Name)
        beneficiary_Name.frame = CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight)
        BeneficialyView.addSubview(beneficiary_Name)

        internal_Space += Int(hight) + common_margin

        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Gender"
        BeneficialyView.addSubview(lbl_Gender)

        gender = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        gender.text = self.storeViewData["gender"].string
        BeneficialyView.addSubview(gender)

        internal_Space +=  Int(gender.bounds.height) + common_margin

        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Social Category"
        BeneficialyView.addSubview(lbl_Social_Category)

        social_Category = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        social_Category.text = self.storeViewData["benf_category"].string
        BeneficialyView.addSubview(social_Category)

        internal_Space +=  Int(gender.bounds.height) + common_margin

        let lbl_Special_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Special_Category.text = "Special Category"
        BeneficialyView.addSubview(lbl_Special_Category)

        special_Category = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        special_Category.text = self.storeViewData["benf_special_cat"].string
        BeneficialyView.addSubview(special_Category)

        internal_Space += Int(lbl_Special_Category.bounds.height) + common_margin

        let lbl_Email_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Email_ID.text = "E-mail ID"
        BeneficialyView.addSubview(lbl_Email_ID)

        email_ID = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING - 30, y: internal_Space , width:LABEL_WIDTH + 30, height: LABEL_HEIGHT))
        email_ID.text = self.storeViewData["e_mail"].string
        let hight_email_ID = SingletonClassSwift.sharedInstance.heightForView(text:email_ID.text , width: CGFloat(LABEL_WIDTH), Label: email_ID)
        email_ID.frame = CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING - 30, y: internal_Space , width:LABEL_WIDTH + 30  , height:hight_email_ID)
        BeneficialyView.addSubview(email_ID)

        internal_Space += Int(email_ID.frame.height) + common_margin

        let lbl_mobile_Number = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_mobile_Number.text = "Mobile Number"
        BeneficialyView.addSubview(lbl_mobile_Number)

        mobile_Number = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        mobile_Number.text = self.storeViewData["mob_no"].string
        BeneficialyView.addSubview(mobile_Number)

        internal_Space +=  Int(mobile_Number.bounds.height) + common_margin + 20

        slideToY_unitDetail  = CGFloat(internal_Space)

        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(BeneficialyView.bounds.width))
        BeneficialyView.addSubview(sView)

        internal_Space +=  Int(sView.bounds.height) + common_margin + 20

        global_Y_Position = internal_Space

        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)

        printOn(pMessage: scrollViewHeight)
        unitDetailView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))
        printOn(pMessage: unitDetailView.frame)
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.addSubview(unitDetailView)

        self.initUnitDetails()
    }
    
    //-------------------------------
    //MARK:- Unit
    //-------------------------------
    private func initUnitDetails() {
        
        var internal_Space : Int = 0
        printOn(pMessage: internal_Space)

        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Unit Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        unitDetailView.addSubview(lblTitle)

        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        let lbl_Office_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Office_Name.text = "Office Name"
        unitDetailView.addSubview(lbl_Office_Name)

        office_Name = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        office_Name.text = self.storeViewData["office_name"].string
        let hight_office_Name = SingletonClassSwift.sharedInstance.heightForView(text:office_Name.text , width: CGFloat(LABEL_WIDTH), Label: office_Name)
        office_Name.frame = CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight_office_Name)
        unitDetailView.addSubview(office_Name)

        internal_Space += Int(office_Name.frame.height) + common_margin

        let lbl_Agency = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Agency.text = "Agency"
        unitDetailView.addSubview(lbl_Agency)

        agency = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        agency.text = self.storeViewData["agency_type"].string
        unitDetailView.addSubview(agency)

        internal_Space += Int(agency.bounds.height) + common_margin

        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Unit Location"
        unitDetailView.addSubview(lbl_Beneficiary_ID)

        unit_Location = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        unit_Location.text = self.storeViewData["unit_loc"].string
        unitDetailView.addSubview(unit_Location)

        internal_Space += Int(unit_Location.bounds.height) + common_margin

        let cView =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView)

        internal_Space += Int(cView.bounds.height) + common_margin

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Industry Type"
        unitDetailView.addSubview(lbl_Beneficiary_Name)

        industry_Type = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        industry_Type.text = self.storeViewData["ind_type"].string
        unitDetailView.addSubview(industry_Type)

        internal_Space += Int(industry_Type.bounds.height) + common_margin

        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Industry Activity"
        unitDetailView.addSubview(lbl_Gender)

        industry_Activity = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        industry_Activity.text = self.storeViewData["activity_name"].string
        let hight_industry_Activity = SingletonClassSwift.sharedInstance.heightForView(text:industry_Activity.text , width: CGFloat(LABEL_WIDTH), Label: industry_Activity)
        industry_Activity.frame = CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight_industry_Activity)
        unitDetailView.addSubview(industry_Activity)

        internal_Space +=  Int(industry_Activity.bounds.height) + common_margin

        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Product Description"
        unitDetailView.addSubview(lbl_Social_Category)

        product_Description = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - 10, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT ))
        product_Description.text = self.storeViewData["prod_desc"].string
        let hight_product_Description = SingletonClassSwift.sharedInstance.heightForView(text: product_Description.text , width: CGFloat(LABEL_WIDTH), Label: product_Description)
        product_Description.frame = CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight_product_Description)
        unitDetailView.addSubview(product_Description)

        internal_Space += Int(hight_product_Description) + common_margin

        let cView1 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView1)

        internal_Space += Int(cView1.bounds.height) + common_margin

        let EDP_Completed = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        EDP_Completed.text = "EDP Date"
        unitDetailView.addSubview(EDP_Completed)

        edp_Completed = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT ))
//        edp_Completed.text = self.storeViewData["edp_cert_dt"].stringValue
        edp_Completed.text =  SingletonClassSwift.getDate(complete:  self.storeViewData["edp_cert_dt"].stringValue)
        unitDetailView.addSubview(edp_Completed)

        internal_Space += Int(edp_Completed.bounds.height) + common_margin

        let cView2 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView2)

        internal_Space += Int(cView2.bounds.height) + common_margin

        let lbl_Email_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        printOn(pMessage: lbl_Email_ID.frame)
        lbl_Email_ID.text = "Address"
        unitDetailView.addSubview(lbl_Email_ID)

        address = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        address.text = self.storeViewData["unit_post_address"].string
        let hight_address = SingletonClassSwift.sharedInstance.heightForViewAddress(text: address.text , width: CGFloat(LABEL_WIDTH), Label: address)
        address.frame = CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight_address)
        printOn(pMessage: address.frame)
        unitDetailView.addSubview(address)

        internal_Space += Int(hight_address) + common_margin

        let lbl_mobile_Number = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_mobile_Number.text = "Taluka/ Block"
        unitDetailView.addSubview(lbl_mobile_Number)

        taluka = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        taluka.text = self.storeViewData["unit_taluka"].string
        unitDetailView.addSubview(taluka)

        internal_Space +=  Int(taluka.bounds.height) + common_margin

        let lbl_District = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_District.text = "District"
        unitDetailView.addSubview(lbl_District)

        district = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        district.text = self.storeViewData["unit_dist"].string
        unitDetailView.addSubview(district)

        internal_Space +=  Int(district.bounds.height) + common_margin

        let lbl_State = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_State.text = "State"
        unitDetailView.addSubview(lbl_State)

        state = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        state.text = self.storeViewData["state_name"].string
        unitDetailView.addSubview(state)

        internal_Space +=  Int(state.bounds.height) + common_margin

        let lbl_Pincode = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Pincode.text = "Pincode"
        unitDetailView.addSubview(lbl_Pincode)

        pincode = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))

        pincode.text = self.storeViewData["unit_pincode"].stringValue
        unitDetailView.addSubview(pincode)

        internal_Space +=  Int(pincode.bounds.height) + common_margin
        
        //TODO: HIDE BY MRUGEN
        
        /*        let cView3 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView3)

        internal_Space +=  Int(cView3.bounds.height) + common_margin + 20

        let lbl_Current_Address = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width/3), height: LABEL_HEIGHT * 2))
        lbl_Current_Address.text = "Communication Address"
        lbl_Current_Address.lineBreakMode = .byWordWrapping
        lbl_Current_Address.numberOfLines = 0
        unitDetailView.addSubview(lbl_Current_Address)
        //
        let Current_Address = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT * 2))
        Current_Address.text = dummyUnitData[5]
        Current_Address.lineBreakMode = .byWordWrapping
        Current_Address.numberOfLines = 0
        unitDetailView.addSubview(Current_Address)

        internal_Space +=  Int(Current_Address.bounds.height) + common_margin + 20*/


        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(sView)

        internal_Space +=  Int(sView.bounds.height) + common_margin + 20

        unitDetailView.frame =  CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: CGFloat(global_Y_Position + internal_Space))

        global_Y_Position += internal_Space

        slideToY_projectcost  = CGFloat(global_Y_Position - common_margin - 40)

        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)

        projectCostView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.addSubview(projectCostView)

        self.initProjectCostDetails()
    }
    
    //--------------------------------------
    //MARK:- ProjectCost
    //--------------------------------------
    
    private func initProjectCostDetails() {
        
        var internal_Space : Int = 0

        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Project Cost"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        projectCostView.addSubview(lblTitle)

        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        slideToY_bankDetail = CGFloat(global_Y_Position + internal_Space)

        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Capital Expenditure"
        projectCostView.addSubview(lbl_Beneficiary_ID)

        capital_Expenditure = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        capital_Expenditure.text = self.storeViewData["prj_ce"].stringValue
        projectCostView.addSubview(capital_Expenditure)

        internal_Space += Int(capital_Expenditure.bounds.height) + common_margin

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Working Capital"
        projectCostView.addSubview(lbl_Beneficiary_Name)

        working_Capital = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        working_Capital.text = self.storeViewData["prj_wc"].stringValue
        projectCostView.addSubview(working_Capital)

        internal_Space += Int(working_Capital.bounds.height) + common_margin

        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Own Contribution"
        projectCostView.addSubview(lbl_Gender)

        own_Contribution = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        own_Contribution.text = self.storeViewData["own_contribution"].stringValue
        projectCostView.addSubview(own_Contribution)

        internal_Space +=  Int(own_Contribution.bounds.height) + common_margin

        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Total"
        projectCostView.addSubview(lbl_Social_Category)

        total = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        let a = self.storeViewData["prj_ce"].floatValue
        let b = self.storeViewData["prj_wc"].floatValue
        let c = self.storeViewData["own_contribution"].floatValue

        let sum = (a + b + c)
        total.text = "\(sum)"
        projectCostView.addSubview(total)

        internal_Space +=  Int(total.bounds.height) + common_margin + 20

        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(projectCostView.bounds.width))
        projectCostView.addSubview(sView)

        internal_Space +=  Int(sView.bounds.height) + common_margin + 20

        projectCostView.frame =  CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: CGFloat(global_Y_Position + internal_Space))
        global_Y_Position += internal_Space

        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)

        bankDeatilView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))
        printOn(pMessage: bankDeatilView.frame)
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.addSubview(bankDeatilView)
        
        self.initBankDetails()
        
    }
    
    //-----------------------------
    //MARK:- Bank
    //-----------------------------
    private func initBankDetails() {

        var internal_Space : Int = 0
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Bank Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        bankDeatilView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Bank"
        bankDeatilView.addSubview(lbl_Beneficiary_ID)
        
        bank = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        bank.text =  self.storeViewData["bank_name"].string
        bankDeatilView.addSubview(bank)
        
        
        internal_Space += Int(beneficiary_ID.bounds.height) + common_margin

     /*
        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Branch"
        bankDeatilView.addSubview(lbl_Beneficiary_Name)
        
        branch = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        branch.text = self.storeViewData["bankName"].string
        bankDeatilView.addSubview(branch)
        
        
        internal_Space +=   Int(branch.bounds.height) + common_margin
        
        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Bank Address"
        bankDeatilView.addSubview(lbl_Gender)
        
        bank_Address = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: (LABEL_HEIGHT * 2)))
        bank_Address.text =  dummyBankData[2]
        bank_Address.lineBreakMode = .byWordWrapping
        bank_Address.numberOfLines = 0
        bankDeatilView.addSubview(bank_Address)
        
        
        internal_Space +=  Int(bank_Address.bounds.height) + common_margin
        */
        
        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "IFSC Code"
        bankDeatilView.addSubview(lbl_Social_Category)
        
        ifscCode = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        ifscCode.text =  self.storeViewData["ifsc_code"].string
        bankDeatilView.addSubview(ifscCode)
        
        internal_Space +=  Int(ifscCode.bounds.height) + common_margin + 20

        let btnNext = CustomButton (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.frame.width) - (X_PADDING * 2), height: NEXT_BUTTON_HEIGHT))
        btnNext.setTitle("Next", for: .normal)
        btnNext.tag = 2
        btnNext.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        btnNext.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        bankDeatilView.addSubview(btnNext)

        internal_Space +=  Int(btnNext.bounds.height) + common_margin + 20

        bankDeatilView.frame =  CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: CGFloat(global_Y_Position + internal_Space))

        global_Y_Position += internal_Space 
        
        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)
        
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        
     
    }
    
    @objc func onbtnNextPressed() {
        appFormScrollView.isScrollEnabled = true
        let pageWidth:CGFloat = self.appFormScrollView.frame.height
        let maxWidth:CGFloat = pageWidth
        let contentOffset:CGFloat = self.appFormScrollView.center.x

        if self.myProgressBar.currentIndex < 3 {
            self.myProgressBar.currentIndex = self.myProgressBar.currentIndex + 1
            printOn(pMessage: myProgressBar.currentIndex)
            if self.myProgressBar.currentIndex > maxIndex {
                maxIndex = self.myProgressBar.currentIndex
                myProgressBar.completedTillIndex = maxIndex
            }
        }
        
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            self.initScrollAdd()
            self.tabVIEW_View.isHidden = true
            self.tabAdd_View.isHidden = false

            self.buttonUpload.isSelected = false
            self.buttonView.isSelected = false
            self.buttonAdd.isSelected = true

        }
        self.appFormScrollView.scrollRectToVisible(CGRect (x: 0, y: slideToX, width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height),animated: true)

        
    }
    
    @objc func onbtnProgressbarPressed(newIndex :Int) {
         self.appFormScrollView.isScrollEnabled = true
        var slideToX : CGFloat!
        printOn(pMessage:SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding )
        switch newIndex {
        case 0:
            slideToX = 0.0
        case 1:
            slideToX =  slideToY_unitDetail! - CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding ) + 5
        case 2:
            slideToX =   slideToY_projectcost! -   CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding ) + 5
        case 3:
            slideToX =   self.appFormScrollView.contentSize.height  - 1
        default:
            slideToX = 0.0
        }
        printOn(pMessage:slideToX)

        self.appFormScrollView.scrollRectToVisible(CGRect (x: 0, y: slideToX, width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height),animated: true)
        
    }
    //------------------------------------------
    //    MARK:  ADD SECTION
    //------------------------------------------
    
    private func initScrollAdd() {
        
        self.tabAdd_View = UIView (frame:  CGRect (x: 0, y: CGFloat (global_ADD_Y_Position), width: self.view.frame.width, height: self.view.frame.height - CGFloat (global_ADD_Y_Position)))
        globalScroll_Y_Position = 10
        
        self.myProgressBarAdd = FlexibleSteppedProgressBar()
        myProgressBarAdd.frame = CGRect(x: 40, y: CGFloat(globalScroll_Y_Position) , width: UIScreen.main.bounds.width - 70, height: CGFloat(TOP_PROGRESSBAR_HEIGHT))
        myProgressBarAdd.center = CGPoint (x: self.tabAdd_View.center.x, y: myProgressBarAdd.center.y)
        self.tabAdd_View.addSubview(myProgressBarAdd)
        
        myProgressBarAdd.numberOfPoints = 4
        myProgressBarAdd.lineHeight = 5
        myProgressBarAdd.radius = 20
        myProgressBarAdd.progressRadius = 21
        myProgressBarAdd.progressLineHeight = 5
        myProgressBarAdd.delegate = self
        myProgressBarAdd.backgroundShapeColor = UIColor.lightGray
        myProgressBarAdd.selectedBackgoundColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBarAdd.selectedOuterCircleStrokeColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBarAdd.currentSelectedCenterColor = UIColor.white
        myProgressBarAdd.stepTextColor = labelTextColor
        myProgressBarAdd.visitedStepTextColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBarAdd.currentSelectedTextColor = SUBHEADER_BACKGROUND_COLOUR
        myProgressBarAdd.stepTextFont = UIFont (name: APP_FONT_NAME, size: 10)
        myProgressBarAdd.sizeToFit()
        myProgressBarAdd.stepAnimationDuration = 0.0
        myProgressBarAdd.currentIndex = 0
        
        globalScroll_Y_Position += TOP_PROGRESSBAR_HEIGHT + common_margin + 20
        
        self.appAddScrollView = UIScrollView (frame: CGRect (x: 0, y:  CGFloat (globalScroll_Y_Position), width: self.view.frame.width, height: self.tabAdd_View.frame.height - CGFloat (globalScroll_Y_Position)))
        
        let scrollViewWidth:CGFloat = self.appAddScrollView.frame.width
        let scrollViewHeight:CGFloat = self.appAddScrollView.frame.height
        
        addUnitDetailView = UIView(frame: CGRect (x:0 , y: 0, width: scrollViewWidth, height: scrollViewHeight))
    
        self.appAddScrollView.addSubview(addUnitDetailView)
        appAddScrollView.isScrollEnabled = true
        appAddScrollView.showsVerticalScrollIndicator = false
        appAddScrollView.contentSize = CGSize (width: scrollViewWidth , height: scrollViewHeight)
        printOn(pMessage: appAddScrollView.contentSize)
        self.appAddScrollView.delegate = self
        self.tabAdd_View.addSubview(self.appAddScrollView)
        self.view.addSubview(self.tabAdd_View)
        self.initAddUnitDetails()
    }
    
    
    
    //MARK:- ADDUnitDetails
    private func initAddUnitDetails() {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Unit Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        addUnitDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        UnitName = CustomInputTextView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2), height: 125))
        UnitName.delegateApp = self
        UnitName.initDesign(pName: "Unit Name*", pTag: TAG6,pPlaceHolder: "")
        addUnitDetailView.addSubview(UnitName)
        
        internal_Space +=  Int(UnitName.bounds.height) + common_margin
        
        UdyogAadharNumber = CustomOTPTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width:  Int(self.appAddScrollView.frame.size.width)  - (X_PADDING * 2), height: controlsHeight))
        UdyogAadharNumber.delegateApp = self
        UdyogAadharNumber.initDesign(pName: "Udyog Aadhar Number*",pTag: TAG7,pNoOfBox: 12)
        addUnitDetailView.addSubview(UdyogAadharNumber)
        
        internal_Space +=  Int(UdyogAadharNumber.bounds.height) + common_margin
        
        UnitEstablishmentDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width)  - (X_PADDING * 2), height: controlsHeight))
        UnitEstablishmentDate.initDesign(pName: "Unit Establishment Date*", pTag: TAG8, pOptions: [],pPlaceHolder: "Select Date")
        UnitEstablishmentDate.setDatePicker()
        addUnitDetailView.addSubview(UnitEstablishmentDate)
        
        internal_Space +=  Int(UdyogAadharNumber.bounds.height) + common_margin
        
        
        ProductionCommencementDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width)  - (X_PADDING * 2), height: controlsHeight))
        ProductionCommencementDate.initDesign(pName: "Production Commencement Date*", pTag: TAG9, pOptions: [],pPlaceHolder: "Select Date")
        ProductionCommencementDate.setDatePicker()
        addUnitDetailView.addSubview(ProductionCommencementDate)
        
        internal_Space +=  Int(ProductionCommencementDate.bounds.height) + common_margin
    
        let lbl_UpdatedUnitAddress = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width/2), height: LABEL_HEIGHT ))
        lbl_UpdatedUnitAddress.text = "Update Unit Address"
        addUnitDetailView.addSubview(lbl_UpdatedUnitAddress)
        
        copyAddress = UIButton (frame: CGRect (x: Int(addUnitDetailView.bounds.width) - Int(addUnitDetailView.bounds.width/2) - X_PADDING, y: internal_Space , width:Int(addUnitDetailView.bounds.width/2) , height: (LABEL_HEIGHT )))
        copyAddress.setTitle( "Copy Address", for: .normal)
        copyAddress.setTitleColor(blueTextColor, for: .normal)
        copyAddress.titleLabel!.lineBreakMode = .byWordWrapping
        copyAddress.titleLabel!.numberOfLines = 0
        copyAddress.contentHorizontalAlignment = .right
       copyAddress.addTarget(self, action: #selector(copyAddressPressed), for: .touchUpInside)
        copyAddress.titleLabel?.font = UIFont (name: APP_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)!
        addUnitDetailView.addSubview(copyAddress)
        
        internal_Space +=  Int(copyAddress.bounds.height) + common_margin
        
        addressView = CustomInputTextView(frame: CGRect(x: X_PADDING, y: internal_Space, width:  Int(appAddScrollView.bounds.width) - (X_PADDING * 2), height: 125))
        addressView.delegateApp = self
        addressView.initDesign(pName: "Current Address*", pTag: TAG1,pPlaceHolder: "")
        addUnitDetailView.addSubview(addressView)
        
        internal_Space +=  Int(addressView.bounds.height) + common_margin
        
      /*  stateView = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width:   Int(appAddScrollView.bounds.width) - (X_PADDING * 2), height: controlsHeight))
        stateView.delegateApp = self
        stateView.initDesign(pName: "State*", pTag: TAG2, pPlaceHolder: "")
        addUnitDetailView.addSubview(stateView)
        
        internal_Space +=  Int(stateView.bounds.height) + common_margin
        
        districtView = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width:  Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2), height: controlsHeight))
        districtView.delegateApp = self
        districtView.initDesign(pName: "District*", pTag: TAG3, pPlaceHolder: "")
        addUnitDetailView.addSubview(districtView)
        
        internal_Space +=  Int(districtView.bounds.height) + common_margin
        
        talukaView = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        talukaView.delegateApp = self
        talukaView.initDesign(pName: "Taluka/Block*", pTag: TAG4,pPlaceHolder: "")
        addUnitDetailView.addSubview(talukaView)
        
        internal_Space +=  Int(talukaView.bounds.height) + common_margin
        
        pincodeView = CustomOTPTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width:  Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2), height: controlsHeight))
        pincodeView.delegateApp = self
        pincodeView.initDesign(pName: "Pincode*", pTag: TAG5,pNoOfBox: 6)
        addUnitDetailView.addSubview(pincodeView)
        
        internal_Space +=  Int(pincodeView.bounds.height) + common_margin + 20 */
 
        
        let btnNext = CustomButton (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.frame.width) - (X_PADDING * 2), height: NEXT_BUTTON_HEIGHT))
        btnNext.setTitle("Locate on Map", for: .normal)
        btnNext.addTarget(self, action: #selector(OnLocateMapPressed), for: .touchUpInside)
        btnNext.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        addUnitDetailView.addSubview(btnNext)
        
        internal_Space +=  Int(btnNext.bounds.height) + common_margin + 20
        
        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(addUnitDetailView.bounds.width))
        addUnitDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin
        
       addUnitDetailView.frame =  CGRect (x:0, y: 0 , width: self.appAddScrollView.frame.width, height: CGFloat(global_ADD_Y_Position + internal_Space))
      global_ADD_Y_Position = internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        slideToY_sales = scrollViewHeight
        printOn(pMessage: scrollViewHeight)
        
        addSalesDetailView = UIView(frame: CGRect (x:0, y:  CGFloat(global_ADD_Y_Position) , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height))
     
        printOn(pMessage: addSalesDetailView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addSalesDetailView)

        self.initSalesDetails()
    }
    
    @objc func copyAddressPressed(){
        
        let arrAddressChanged = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORE_ADDRESS_CHANGED_ARRAY) as? [String]
        
        if arrAddressChanged != nil {
            if (arrAddressChanged?.contains(self.storeViewData["app_id"].stringValue))! {
                      self.displayAlertMessage(pMessage: "Please enter new address")
                      return
                  }
        }
        
        currentAddr = (addressView.view(withId: "\(TAG1)") as! CustomTextView)
        currentAddr.text = "\(self.storeViewData["unit_post_address"].stringValue) ,\(self.storeViewData["unit_taluka"].stringValue),\(self.storeViewData["unit_dist"].stringValue),\(self.storeViewData["state_name"].stringValue),\(self.storeViewData["unit_pincode"].stringValue)"
    }
    
    @objc private func OnLocateMapPressed(){
        
        let objectVC  = LocateOnMapViewController()
        if SingletonClassSwift.sharedInstance.is_location_changed == true {
            objectVC.storeLat = SingletonClassSwift.sharedInstance.changed_location_latitude
            objectVC.storeLong = SingletonClassSwift.sharedInstance.changed_location_longitude
        } else {

            objectVC.storeLat = self.storeViewData["latitude"].doubleValue
            objectVC.storeLong = self.storeViewData["longitude"].doubleValue
        }
    
        self.navigationController?.pushViewController(objectVC, animated: true)
        
    }
    //MARK:- Production / Sales Detail
    
    private func initSalesDetails() {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Production / Sales Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        addSalesDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        SalesValueperYear = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        SalesValueperYear.delegateApp = self
        SalesValueperYear.initDesign(pName: "Year", pTag: TAG10,pPlaceHolder: "")
        SalesValueperYear.txtField.keyboardType = .numberPad
        addSalesDetailView.addSubview(SalesValueperYear)
        
        internal_Space += Int(SalesValueperYear.bounds.height) + common_margin + 10
        
        ProductionValue = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        ProductionValue.delegateApp = self
        ProductionValue.initDesign(pName: "Production Value (in Rupees)", pTag: TAG11,pPlaceHolder: "")
        ProductionValue.txtField.keyboardType = .numberPad
        addSalesDetailView.addSubview(ProductionValue)
        
        internal_Space += Int(ProductionValue.bounds.height) + common_margin + 10
        
        SalesValue = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        SalesValue.delegateApp = self
        SalesValue.initDesign(pName: "Sales Value (in Rupees)", pTag: TAG12,pPlaceHolder: "")
        SalesValue.txtField.keyboardType = .numberPad
        addSalesDetailView.addSubview(SalesValue)
        
        internal_Space +=  Int(SalesValue.bounds.height) + common_margin + 20
        
        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(addSalesDetailView.bounds.width))
        addSalesDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin
        
        global_ADD_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        slideToY_employment = scrollViewHeight

        printOn(pMessage: scrollViewHeight)
        addEmploymentDetailView = UIView(frame: CGRect (x:0, y:  CGFloat(global_ADD_Y_Position) , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height + 100))
        printOn(pMessage: addEmploymentDetailView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addEmploymentDetailView)
        
        self.initEmploymentDetail()
        
    }
    
     func getTextfield(_ textField: UITextField) {
        
    var full:Int? = Int(fulltimeVl.text!)
    var part:Int? = Int(parttimeVl.text!)
    var seasonal:Int? = Int(seasonalVl.text!)
    var ans = Int()
        
        if textField == fulltimeVl || textField == parttimeVl || textField == seasonalVl{

            if full == nil {
                full = 0
            }
            if part == nil {
                part = 0
            }
            if seasonal == nil {
                seasonal = 0
            }
                ans =   full! + part! + seasonal!
                totalEmpVl.text = "\(ans)"
            }
        }

    //MARK:- Employment Detail
    
    private func initEmploymentDetail() {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Employment Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        addEmploymentDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        self.fullTimeView = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width/3) - (X_PADDING * 2) , height: controlsHeight))
        self.fullTimeView.delegateApp = self
        self.fullTimeView.initDesign(pName: "Full Time", pTag: TAG13,pPlaceHolder: "")
        self.fullTimeView.txtField.keyboardType = .numberPad
        addEmploymentDetailView.addSubview(self.fullTimeView)
        
        self.partTimeView = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width/3) - (X_PADDING * 2) , height: controlsHeight))
        self.partTimeView.center = CGPoint (x: addEmploymentDetailView.center.x, y: self.partTimeView.center.y)
        self.partTimeView.delegateApp = self
        self.partTimeView.initDesign(pName: "Part Time", pTag: TAG14,pPlaceHolder: "")
        self.partTimeView.txtField.keyboardType = .numberPad
        addEmploymentDetailView.addSubview(self.partTimeView)
        
        self.seasonalView = CustomInputFieldView(frame: CGRect(x: Int(addEmploymentDetailView.frame.size.width) - (X_PADDING * 2) - Int(self.partTimeView.frame.width - 15) , y: internal_Space, width: Int(self.appAddScrollView.frame.size.width/3) - (X_PADDING * 2) , height: controlsHeight))
        self.seasonalView.delegateApp = self
        self.seasonalView.initDesign(pName: "Seasonal", pTag: TAG15,pPlaceHolder: "")
        self.seasonalView.txtField.keyboardType = .numberPad
        addEmploymentDetailView.addSubview(self.seasonalView)
        
        internal_Space += Int(self.seasonalView.bounds.height) + common_margin + 10
        
        N_FemaleEmployees = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        N_FemaleEmployees.delegateApp = self
        N_FemaleEmployees.initDesign(pName: "Number of Female Employees", pTag: TAG16,pPlaceHolder: "")
        N_FemaleEmployees.txtField.keyboardType = .numberPad
        addEmploymentDetailView.addSubview(N_FemaleEmployees)
        
        internal_Space += Int(N_FemaleEmployees.bounds.height) + common_margin + 10
        
        N_MaleEmployees = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        N_MaleEmployees.delegateApp = self
        N_MaleEmployees.initDesign(pName: "Number of Male Employees", pTag: TAG17,pPlaceHolder: "")
        N_MaleEmployees.txtField.keyboardType = .numberPad
        addEmploymentDetailView.addSubview(N_MaleEmployees)
        
        internal_Space += Int(N_MaleEmployees.bounds.height) + common_margin + 10
        
        TotalNumberEmployees = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        TotalNumberEmployees.delegateApp = self
        TotalNumberEmployees.initDesign(pName: "Total Number of Employees", pTag: TAG18,pPlaceHolder: "")
        TotalNumberEmployees.txtField.keyboardType = .numberPad
        TotalNumberEmployees.isUserInteractionEnabled = false
        addEmploymentDetailView.addSubview(TotalNumberEmployees)
        
        internal_Space +=  Int(TotalNumberEmployees.bounds.height) + common_margin + 20
        
        slideToY_margin = CGFloat(internal_Space)
        
        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(addEmploymentDetailView.bounds.width))
        addEmploymentDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin
        
        global_ADD_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        slideToY_margin = scrollViewHeight
        printOn(pMessage: scrollViewHeight)
        addMarginMoneyView = UIView(frame: CGRect (x:0, y:  CGFloat(global_ADD_Y_Position) , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height))
        printOn(pMessage: addMarginMoneyView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addMarginMoneyView)
        self.initMarginMoneyDetail(status: "No")
        
        fulltimeVl = (self.fullTimeView.view(withId: "\(TAG13)") as! CustomTextField)
        parttimeVl = (self.partTimeView.view(withId: "\(TAG14)") as! CustomTextField)
        seasonalVl = (self.seasonalView.view(withId: "\(TAG15)") as! CustomTextField)
        femaleEmpVl = (N_FemaleEmployees.view(withId: "\(TAG16)") as! CustomTextField)
        maleEmpVl = (N_MaleEmployees.view(withId: "\(TAG17)") as! CustomTextField)
        totalEmpVl = (TotalNumberEmployees.view(withId: "\(TAG18)") as! CustomTextField)
    }
    
    //-----------------------------------------------
    //MARK:- Margin Money Detail
    //-----------------------------------------------
    
    private func initMarginMoneyDetail(status : String) {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Margin Money Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        addMarginMoneyView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT * 2  - common_margin))
        lbl_Beneficiary_ID.text = "Margin Money Release Amount (in Rupees)*"
        lbl_Beneficiary_ID.lineBreakMode = .byWordWrapping
        lbl_Beneficiary_ID.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_Beneficiary_ID)
        
        marginAmount = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        marginAmount.text = self.storeViewData["mm_rel_amt"].stringValue
        SingletonViewControllerClassSwift.shared.mm_rel_amt = self.storeViewData["mm_rel_amt"].stringValue
        addMarginMoneyView.addSubview(marginAmount)
        
        internal_Space += Int(lbl_Beneficiary_ID.bounds.height) + common_margin
        
        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT * 2  - common_margin ))
        lbl_Beneficiary_Name.text = "Margin Money Release Date*"
        lbl_Beneficiary_Name.lineBreakMode = .byWordWrapping
        lbl_Beneficiary_Name.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_Beneficiary_Name)
        
        marginReleaseDate = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        marginReleaseDate.text =  SingletonClassSwift.getDate(complete:  self.storeViewData["mm_rel_dt"].string!)
        addMarginMoneyView.addSubview(marginReleaseDate)
        
        internal_Space += Int(lbl_Beneficiary_Name.bounds.height) + common_margin
        
        marginSelected = MarginSelectView(frame:  CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width), height: controlsHeight))
        marginSelected.initDesign(pName: "Margin Money Call Back", pTag: TAG19, pOptions: ["No","Yes"])
        marginSelected.delegateApp = self
        addMarginMoneyView.addSubview(marginSelected)
        
        internal_Space += Int(marginSelected.bounds.height) + common_margin
        yScroll_subscroll = internal_Space

        
        CallBackAmount = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2) , height: controlsHeight))
        CallBackAmount.delegateApp = self
        CallBackAmount.initDesign(pName: "Call Back Amount (in Rupees)*", pTag: TAG20,pPlaceHolder: "")
        CallBackAmount.isHidden = true
        CallBackAmount.txtField.keyboardType = .numberPad
        addMarginMoneyView.addSubview(CallBackAmount)
        
        internal_Space +=  Int(CallBackAmount.bounds.height) + common_margin
        
        ReasonCallBack = CustomInputTextView(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.appAddScrollView.frame.size.width) - (X_PADDING * 2), height: 125))
        ReasonCallBack.delegateApp = self
        ReasonCallBack.initDesign(pName: "Reason for Call Back*", pTag: TAG21,pPlaceHolder: "")
        ReasonCallBack.isHidden = true
        addMarginMoneyView.addSubview(ReasonCallBack)
        
        internal_Space +=  Int(ReasonCallBack.bounds.height) + common_margin + 20

        btnNextMarginView = CustomButton (frame: CGRect (x: X_PADDING, y: yScroll_subscroll , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT))
        btnNextMarginView.center = CGPoint (x: addMarginMoneyView.center.x, y: btnNextMarginView.center.y)
        btnNextMarginView.setTitle("Next", for: .normal)
        btnNextMarginView.addTarget(self, action: #selector(addSubmitPressed(sender:)), for: .touchUpInside)
        addMarginMoneyView.addSubview(btnNextMarginView)
        
        internal_Space +=  Int(btnNextMarginView.bounds.height) + common_margin + 20
        
        global_ADD_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        
        printOn(pMessage: scrollViewHeight)
        printOn(pMessage: addMarginMoneyView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addMarginMoneyView)
        
        
    }
    
        func getMarginStatus(status : String)  {
    
            if status == "Yes"{
                
                addMarginMoneyView.frame = CGRect(x:addMarginMoneyView.frame.origin.x, y:  addMarginMoneyView.frame.origin.y , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height + 200)
                
                self.marginSelected.isMarginMoneyCallback = true
                self.setView(view: CallBackAmount, hidden: false)
                self.setView(view: ReasonCallBack, hidden: false)
                
                btnNextMarginView.frame =  CGRect (x: X_PADDING, y: Int(ReasonCallBack.frame.origin.y) + NEXT_BUTTON_WIDTH + 20  , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT)
                btnNextMarginView.center = CGPoint (x: self.view.center.x, y: btnNextMarginView.center.y)
                self.setView(view: btnNextMarginView, hidden: false)
                
                appAddScrollView.layoutIfNeeded()
                
            }else{
                
                addMarginMoneyView.frame = CGRect(x:addMarginMoneyView.frame.origin.x, y:  addMarginMoneyView.frame.origin.y , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height)
                
                self.marginSelected.isMarginMoneyCallback = false
                self.setView(view: CallBackAmount, hidden: true)
                self.setView(view: ReasonCallBack, hidden: true)
                
                btnNextMarginView.frame = CGRect (x: X_PADDING, y: Int(marginSelected.frame.origin.y) + NEXT_BUTTON_HEIGHT + 30  , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT)
                btnNextMarginView.center = CGPoint (x: self.view.center.x, y: btnNextMarginView.center.y)
                self.setView(view: btnNextMarginView, hidden: false)
                
                appAddScrollView.layoutIfNeeded()
            }
        }
    
    @objc func onADDbtnNextPressed() {
        appAddScrollView.isScrollEnabled = true
        let pageWidth:CGFloat = self.appAddScrollView.frame.width
        let maxWidth:CGFloat = pageWidth
        let contentOffset:CGFloat = self.appAddScrollView.contentOffset.x
        
        if self.myProgressBarAdd.currentIndex < 3 {
            self.myProgressBarAdd.currentIndex = self.myProgressBarAdd.currentIndex + 1
            printOn(pMessage: myProgressBarAdd.currentIndex)
            if self.myProgressBarAdd.currentIndex > maxIndex {
                maxIndex = self.myProgressBarAdd.currentIndex
                myProgressBarAdd.completedTillIndex = maxIndex
            }
        }
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            self.initUploadDesign(ptag: 0)
            self.tabVIEW_View.isHidden = true
            self.tabAdd_View.isHidden = true
            self.appUploadScrollView.isHidden = false
            
            self.buttonUpload.isSelected = true
            self.buttonView.isSelected = false
            self.buttonAdd.isSelected = false
        }
        
        self.appAddScrollView.scrollRectToVisible(CGRect (x: slideToX, y: 0, width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height),animated: true)
        
    }
    @objc func onAddSectionbtnProgressbarPressed(newIndex :Int) {
        appAddScrollView.isScrollEnabled = true
        var slideToX : CGFloat!
        printOn(pMessage:SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding )
        switch newIndex {
        case 0:
            slideToX = 0.0
        case 1:
            slideToX =  slideToY_sales! - CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding )
        case 2:
            slideToX =   slideToY_employment! -   CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding )
        case 3:
            slideToX =  slideToY_margin - CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding )
        default:
            slideToX = 0.0
        }
        
        self.appAddScrollView.scrollRectToVisible(CGRect (x: 0, y: slideToX, width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height),animated: true)
        
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            view.isHidden = hidden
        })
    }
    //------------------------------------------
    //    MARK:  UPLOAD SECTION
    //------------------------------------------
    
    //    private func addAsterik(pLayerField:Layer_Field,pLabel:UILabel) {
    //
    //        if pLayerField.isOptional == "1" {
    //            pLabel.text = "\(pLabel.text!) *"
    //        }
    //
    //    }
    //
    private func initUploadDesign( ptag : Int) {
        
        self.appUploadScrollView = UIScrollView (frame: CGRect (x: 0, y:  CGFloat (global_Y_Position), width: self.view.frame.width, height: self.view.frame.height - CGFloat (global_Y_Position)))
        self.appUploadScrollView.tag = UPLOAD_VIEW_TAG
        
        var internal_Space : Int = 20
        let inside_internal_Space : Int = LABEL_HEIGHT
        var inside_Y_Space : Int = 5
//        let internal_view_Space : Int = 80

        
        //Title
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Upload Images"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        appUploadScrollView.addSubview(lblTitle)
        
        internal_Space += LABEL_HEIGHT  + common_margin
        printOn(pMessage: internal_Space)
        
        //Unit photo View
        let UnitPhotoView = GISImageDataTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: internal_view_Space))
        UnitPhotoView.tag = UploadTAG101
        UnitPhotoView.type = .Image
        UnitPhotoView.delegate = self
        UnitPhotoView.backgroundColor = .clear
        
        let viewAddUnit = UIView(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(UnitPhotoView.frame.size.width), height: controlsHeight))
        viewAddUnit.tag = UploadTAG201
        UnitPhotoView.addSubview(viewAddUnit)
        
        let lblName = UILabel(frame: CGRect(x: 0, y: 0, width: Int(UnitPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblName.text = "Unit Photo"
        lblName.textColor = UIColor.darkGray
        lblName.sizeToFit()
        lblName.font = UIFont(name: TAB_FONT, size: SMALL_BUTTON_FONT_SIZE)
        viewAddUnit.addSubview(lblName)
        
        let lblNameRight = RightsideLabel()
        lblNameRight.text = "Max 3 Photos"
        lblNameRight.sizeToFit()
        lblNameRight.frame = CGRect(x: Int(UnitPhotoView.frame.width) - Int(lblNameRight.frame.width), y: 0, width:  Int(lblNameRight.frame.width) , height: LABEL_HEIGHT)
        viewAddUnit.addSubview(lblNameRight)
        
        let buttonAddImage = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: inside_internal_Space, width: SCREEN_WIDTH - (X_PADDING*2) , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddImage.setTitle("Add Photo", for: .normal)
        buttonAddImage.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        buttonAddImage.contentHorizontalAlignment = .left
        buttonAddImage.imgIcon.image = UIImage(named: DATATYPE_IMAGE_ICON)
        buttonAddImage.tag = UnitPhotoView.tag
        buttonAddImage.addTarget(self, action: #selector(btnAddImagePressed(sender:)), for: .touchUpInside)
        viewAddUnit.addSubview(buttonAddImage)
        
        internal_Space += Int(UnitPhotoView.frame.height) + common_margin
        printOn(pMessage: internal_Space)
        
        // Product Photo View
        let ProductPhotoView = GISImageDataTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: internal_view_Space))
        ProductPhotoView.tag = UploadTAG103
        ProductPhotoView.type = .Image
        ProductPhotoView.delegate = self
        ProductPhotoView.backgroundColor = .clear
        
        let viewAddProduct = UIView(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ProductPhotoView.frame.size.width), height: controlsHeight))
        viewAddProduct.tag = UploadTAG203
        ProductPhotoView.addSubview(viewAddProduct)
        
        let lblProductPhotoRight = RightsideLabel()
        lblProductPhotoRight.text = "Max 10 Photos"
        lblProductPhotoRight.sizeToFit()
        lblProductPhotoRight.frame = CGRect(x: Int(ProductPhotoView.frame.width) - Int(lblProductPhotoRight.frame.width), y: 0, width:  Int(lblProductPhotoRight.frame.width) , height: LABEL_HEIGHT)
        viewAddProduct.addSubview(lblProductPhotoRight)
        
        
        let lblProductPhoto = UILabel(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ProductPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblProductPhoto.text = "Product Photo (if any)"
        lblProductPhoto.sizeToFit()
        lblProductPhoto.textColor = UIColor.darkGray
        lblProductPhoto.font = UIFont(name: TAB_FONT, size: SMALL_BUTTON_FONT_SIZE)
        viewAddProduct.addSubview(lblProductPhoto)
        
        
        let buttonAddProductPhoto = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: inside_internal_Space, width: SCREEN_WIDTH - (X_PADDING*2) , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddProductPhoto.setTitle("Add Photo", for: .normal)
        buttonAddProductPhoto.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        buttonAddProductPhoto.contentHorizontalAlignment = .left
        buttonAddProductPhoto.imgIcon.image = UIImage(named: DATATYPE_IMAGE_ICON)
        buttonAddProductPhoto.tag = ProductPhotoView.tag
        buttonAddProductPhoto.addTarget(self, action: #selector(btnAddImagePressed(sender:)), for: .touchUpInside)
        viewAddProduct.addSubview(buttonAddProductPhoto)
        
        internal_Space += Int(ProductPhotoView.frame.height ) + common_margin
        printOn(pMessage: internal_Space)
        
        
        // Manufacturing Unit View
        let ManufacturingUnitView = GISImageDataTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height:  internal_view_Space))
        ManufacturingUnitView.tag = UploadTAG105
        ManufacturingUnitView.type = .Image
        ManufacturingUnitView.delegate = self
        ManufacturingUnitView.backgroundColor = .clear
        
        let viewAddManifacturingPhoto = UIView(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ProductPhotoView.frame.size.width), height: internal_view_Space))
        viewAddManifacturingPhoto.tag = UploadTAG205
        ManufacturingUnitView.addSubview(viewAddManifacturingPhoto)
        
        let lblManufacturingUnit = UILabel(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ManufacturingUnitView.frame.width/2) , height: LABEL_HEIGHT))
        lblManufacturingUnit.text = "Manufacturing Unit Image (if any)"
        lblManufacturingUnit.textColor = UIColor.darkGray
        lblManufacturingUnit.sizeToFit()
        lblManufacturingUnit.font = UIFont(name: TAB_FONT, size: SMALL_BUTTON_FONT_SIZE)
        viewAddManifacturingPhoto.addSubview(lblManufacturingUnit)
        
        let lblManufacturingUnitRight = RightsideLabel()
        lblManufacturingUnitRight.text = "Max 3 Photos"
        lblManufacturingUnitRight.sizeToFit()
        lblManufacturingUnitRight.frame = CGRect(x: Int(ManufacturingUnitView.frame.width) - Int(lblManufacturingUnitRight.frame.width) , y: 0, width:  Int(lblManufacturingUnitRight.frame.width) , height: LABEL_HEIGHT)
        viewAddManifacturingPhoto.addSubview(lblManufacturingUnitRight)
        
        
        let buttonAddManufacturingUnit = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: inside_internal_Space, width: SCREEN_WIDTH - (X_PADDING*2) , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddManufacturingUnit.setTitle("Add Photo", for: .normal)
        buttonAddManufacturingUnit.contentHorizontalAlignment = .left
        buttonAddManufacturingUnit.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        buttonAddManufacturingUnit.imgIcon.image = UIImage(named: DATATYPE_IMAGE_ICON)
        buttonAddManufacturingUnit.tag = ManufacturingUnitView.tag
        buttonAddManufacturingUnit.addTarget(self, action: #selector(btnAddImagePressed(sender:)), for: .touchUpInside)
        viewAddManifacturingPhoto.addSubview(buttonAddManufacturingUnit)
        
        
        internal_Space += Int(ManufacturingUnitView.frame.height) + common_margin
        printOn(pMessage: internal_Space)
        
        
        // Manufacturing Unit Video View
        let ManufacturingUnitVideoView = GISImageDataTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height:  internal_view_Space))
        ManufacturingUnitVideoView.tag = UploadTAG107
        ManufacturingUnitVideoView.type = .Video
        ManufacturingUnitVideoView.delegate = self
        ManufacturingUnitVideoView.backgroundColor = .clear
        
        let viewAddManifacturingUnitVideo = UIView(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ProductPhotoView.frame.size.width), height: internal_view_Space))
        viewAddManifacturingUnitVideo.tag = UploadTAG207
        ManufacturingUnitVideoView.addSubview(viewAddManifacturingUnitVideo)
        
        
        let lblManufacturingUnitVideo = UILabel(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ManufacturingUnitVideoView.frame.width/2) , height: LABEL_HEIGHT))
        lblManufacturingUnitVideo.text = "Manufacturing Unit Video (if any)"
        lblManufacturingUnitVideo.textColor = UIColor.darkGray
        //        lblManufacturingUnitVideo.backgroundColor = .red
        lblManufacturingUnitVideo.sizeToFit()
        lblManufacturingUnitVideo.font = UIFont(name: TAB_FONT, size: SMALL_BUTTON_FONT_SIZE)
        viewAddManifacturingUnitVideo.addSubview(lblManufacturingUnitVideo)
        
        let lblManufacturingUnitVideoRight = RightsideLabel()
        lblManufacturingUnitVideoRight.text = "Max 2 Video"
        lblManufacturingUnitVideoRight.sizeToFit()
        lblManufacturingUnitVideoRight.frame = CGRect(x: Int(ManufacturingUnitView.frame.width) - Int(lblManufacturingUnitVideoRight.frame.width) , y: 0, width:  Int(lblManufacturingUnitVideoRight.frame.width) , height: LABEL_HEIGHT)
        viewAddManifacturingUnitVideo.addSubview(lblManufacturingUnitVideoRight)
        
        
        let buttonAddManufacturingUnitVideo = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: inside_internal_Space, width: SCREEN_WIDTH - (X_PADDING*2) , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddManufacturingUnitVideo.setTitle("Add Video", for: .normal)
        buttonAddManufacturingUnitVideo.contentHorizontalAlignment = .left
        buttonAddManufacturingUnitVideo.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        buttonAddManufacturingUnitVideo.imgIcon.image = UIImage(named: DATATYPE_VIDEO_ICON)
        buttonAddManufacturingUnitVideo.tag = ManufacturingUnitVideoView.tag
        buttonAddManufacturingUnitVideo.addTarget(self, action: #selector(btnAddVideoPressed(sender:)), for: .touchUpInside)
        viewAddManifacturingUnitVideo.addSubview(buttonAddManufacturingUnitVideo)
        
        internal_Space += Int(ManufacturingUnitView.frame.height) + common_margin
        printOn(pMessage: internal_Space)
        
        // Achievement Photo View
        let AchievementPhotoView = GISImageDataTypeView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height:  internal_view_Space))
        AchievementPhotoView.tag = UploadTAG109
        AchievementPhotoView.type = .Image
        AchievementPhotoView.delegate = self
        AchievementPhotoView.backgroundColor = .clear
        
        let viewAchievementView = UIView(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(ProductPhotoView.frame.size.width), height: controlsHeight))
        viewAchievementView.tag = UploadTAG209
        AchievementPhotoView.addSubview(viewAchievementView)
        
        let lblAchievementPhoto = UILabel(frame: CGRect(x: 0, y: inside_Y_Space, width: Int(AchievementPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblAchievementPhoto.text = "Achievement Photo (if any)"
        lblAchievementPhoto.textColor = UIColor.darkGray
        lblAchievementPhoto.sizeToFit()
        lblAchievementPhoto.font = UIFont(name: TAB_FONT, size: SMALL_BUTTON_FONT_SIZE)
        viewAchievementView.addSubview(lblAchievementPhoto)
        
        let lblAchievementPhotoRight = RightsideLabel()
        lblAchievementPhotoRight.text = "Max 3 Photos"
        lblAchievementPhotoRight.sizeToFit()
        lblAchievementPhotoRight.frame = CGRect(x: Int(ManufacturingUnitView.frame.width) - Int(lblAchievementPhotoRight.frame.width) , y: 0, width:  Int(lblAchievementPhotoRight.frame.width) , height: LABEL_HEIGHT)
        viewAchievementView.addSubview(lblAchievementPhotoRight)
        
        
        let buttonAddAchievementPhoto = CustomButtonImageOrDocument(frame: CGRect(x: 0, y: inside_internal_Space, width: SCREEN_WIDTH - (X_PADDING*2) , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddAchievementPhoto.setTitle("Add Photo", for: .normal)
        buttonAddAchievementPhoto.contentHorizontalAlignment = .left
        buttonAddAchievementPhoto.titleEdgeInsets = UIEdgeInsets (top: 0, left: 10, bottom: 0, right: 0)
        buttonAddAchievementPhoto.imgIcon.image = UIImage(named: DATATYPE_IMAGE_ICON)
        buttonAddAchievementPhoto.tag = AchievementPhotoView.tag
        buttonAddAchievementPhoto.addTarget(self, action: #selector(btnAddImagePressed(sender:)), for: .touchUpInside)
        viewAchievementView.addSubview(buttonAddAchievementPhoto)
        
        appUploadScrollView.addSubview(UnitPhotoView)
        appUploadScrollView.addSubview(ProductPhotoView)
        appUploadScrollView.addSubview(ManufacturingUnitView)
        appUploadScrollView.addSubview(ManufacturingUnitVideoView)
        appUploadScrollView.addSubview(AchievementPhotoView)
        
        
        internal_Space += Int(AchievementPhotoView.frame.height) + common_margin + 20
        
        btnNextUploadView = CustomButton (frame: CGRect (x: X_PADDING, y: internal_Space , width:  Int(appUploadScrollView.frame.width) - (X_PADDING * 2), height: NEXT_BUTTON_HEIGHT))
        btnNextUploadView.center = CGPoint (x: appUploadScrollView.center.x, y: btnNextUploadView.center.y)
        btnNextUploadView.tag = 1010
        btnNextUploadView.setTitle("Next", for: .normal)
        btnNextUploadView.addTarget(self, action: #selector(uploadSubmitPressed(sender:)), for: .touchUpInside)
        appUploadScrollView.addSubview(btnNextUploadView)

        internal_Space +=  Int(btnNextUploadView.bounds.height) + common_margin + 20

        
        let  subscrollViewWidth:CGFloat = appUploadScrollView.frame.width
        let  subscrollViewHeight:CGFloat = CGFloat(internal_Space )
        
        printOn(pMessage: subscrollViewHeight)
        
        appUploadScrollView.layoutIfNeeded()
        appUploadScrollView.isScrollEnabled = true
        appUploadScrollView.contentSize = CGSize (width: subscrollViewWidth , height: subscrollViewHeight)
        self.appUploadScrollView.delegate = self
        self.view.addSubview(self.appUploadScrollView)
        
    }
    
    func clearAllFilesFromTempDirectory(localPathName:URL,ptag: Int ,dic : imageData?,pKey : String) {
        let filemanager = FileManager.default

        do {
            try filemanager.removeItem(at: localPathName)
            let type = dic?.type
            let name = dic?.name
            let ImageTag = dic?.imageTag
            self.RemoveImagesInMemory(pType: type!, pFileName: name! , pKey: pKey, pImageTag: ImageTag! , ptag: ptag)
        } catch let error as NSError {
            print("------Error",error.debugDescription)
        }
    }

    @objc func handleLongPress(sender: CustomTap) {
        
        if sender.state == .began {
            //When lognpress is start or running
            let actionSheet = UIAlertController(title: "Are sure want to delete?", message:nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title:"Yes", style: .default, handler: { (action) -> Void in
                
                let isEditMode = SingletonClassSwift.sharedInstance.getDataForKey(strKey: INSPECTION_EDIT_MODE) as? Bool
                
                if isEditMode == true {
                    
                    
                    let imgdata = sender.dic as! imageData
                    // temporary initialized
                    var deletingObject = imgdata
                    var uploadId = ""
                    
                    for object in self.ALLimagesArray! {
                        self.printOn(pMessage: object.uploadedID)
                        self.printOn(pMessage: object.imageTag)
                        self.printOn(pMessage: imgdata.imageTag)
                        if object.imageTag == imgdata.imageTag {
                            self.printOn(pMessage: object.uploadedID)
                            uploadId = object.uploadedID
                            deletingObject = object
                            break
                        }
                    }
                    
                    self.printOn(pMessage: imgdata.uploadedID)
                    GISWebServicesManager.deleteImageWS(appId: self.storeViewData!["app_id"].stringValue, attachmentName: uploadId , onCompletion: { response in
                        

                        self.printOn(pMessage: response!["success"])
                        
                        if response!["success"] == true {
                            
                           self.clearAllFilesFromTempDirectory(localPathName: sender.imageName!, ptag: sender.cutomTag!, dic: sender.dic, pKey: sender.pKey!)
                            self.ALLimagesArray =  self.ALLimagesArray!.removing(deletingObject)
                            
                        } else {
                            self.displayAlertMessage(pMessage: response!["message"].string!)
                            self.printOn(pMessage: response!["message"])
                        }

                    },onError:{ error in
                        
                        if error != nil {
                            self.displayAlertMessage(pMessage: "Something went wrong. ")
                        }
                        
                    })
                } else {
                    // delete photo locally
                    self.clearAllFilesFromTempDirectory(localPathName: sender.imageName!, ptag: sender.cutomTag!, dic: sender.dic, pKey: sender.pKey!)
                }
               
                
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
  
    
    //MARK:- Reload upload view
    private func reloadUploadDesign( ptag : Int) {

        var internal_Space : Int = 20
        let viewSpace : Int = 5
        internal_Space += LABEL_HEIGHT  + common_margin
        printOn(pMessage: internal_Space)
        
        // unit photos
        let unitPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG101)")
        
        if ptag == UploadTAG101 {
            
            do {
            
                let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_UNIT_PHOTOS_KEY)
               SingletonClassSwift.sharedInstance.invisibleView(RefView: unitPhotoView!)
                
                if  imagesArray !=  nil && imagesArray!.count > 0 {
                    
                    let imgSize = (SCREEN_WIDTH-40) / 3
                    unitPhotoView?.frame = CGRect(x: (unitPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (unitPhotoView?.frame.size.width)!, height: CGFloat(controlsHeight + 20 + imgSize))
                    
                    var xPos = 0
            
                    for object in imagesArray! {
                
                        let fileManager = FileManager.default
                        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                            
                       // check image folder name
                        let filePath =  tDocumentDirectory!.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
                            
                        // check folder name
                        let imageFolderPath =  filePath.appendingPathComponent("\(UNIT_IMAGES)")
                        // image path
                        let imagePath = imageFolderPath.appendingPathComponent(object.name)
                        printOn(pMessage: imagePath)
                        if  object.name != ""{
                            let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath.path))
                            let img1 =  UIImageView (frame: CGRect (x: xPos, y: 0, width: imgSize, height: imgSize))
                            img1.image = UIImage(data: fileData)
                            unitPhotoView?.addSubview(img1)
                            img1.isUserInteractionEnabled = true
                            img1.tag = object.imageTag
                            
                            let lpgr = CustomTap(target: self, action: #selector(handleLongPress(sender:)))
                            lpgr.cutomTag = UploadTAG101
                            lpgr.imageName = imagePath
                            lpgr.pKey = STORED_UNIT_PHOTOS_KEY
                            lpgr.dic = object as imageData
                            lpgr.minimumPressDuration = 0.5
                            lpgr.delegate = self
                            img1.addGestureRecognizer(lpgr)
                            
                           
                            xPos += (imgSize + viewSpace)
                        }
                        
                    
                    }
                    
                    let viewAddUnit = unitPhotoView?.view(withId: "\(UploadTAG201)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                    
                } else {
                    unitPhotoView?.frame = CGRect(x: (unitPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (unitPhotoView?.frame.size.width)!, height: CGFloat(internal_view_Space))
                    
                    let viewAddUnit = unitPhotoView?.view(withId: "\(UploadTAG201)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                    
                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            internal_Space += Int(unitPhotoView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
            
        } else {
            
            let unitPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG101)")
            unitPhotoView?.frame = CGRect(x: (unitPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (unitPhotoView?.frame.size.width)!, height: (unitPhotoView?.frame.size.height)!)
            
            internal_Space += Int(unitPhotoView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
        }
        
        // productPhotoView photos
        let productPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG103)")
        var countImage : Int! = 0
        let imgSize = (Int((productPhotoView?.frame.width)!) - (X_PADDING * 2))  / 5

        if ptag == UploadTAG103 {
      
            do {
                
                    let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_PRODUCT_PHOTOS_KEY)
                    SingletonClassSwift.sharedInstance.invisibleView(RefView: productPhotoView!)
                    
                    if  imagesArray !=  nil && imagesArray!.count > 0 {
                        
                    productPhotoView?.frame = CGRect(x: (productPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (productPhotoView?.frame.size.width)!, height: CGFloat(controlsHeight + 20 + imgSize))
                        
                    var xPos = 0

                    for object in imagesArray! {
                        
                        let fileManager = FileManager.default
                        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                        
                        // check image folder name
                        let filePath =  tDocumentDirectory!.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
                        
                        // check folder name
                        let imageFolderPath =  filePath.appendingPathComponent("\(PRODUCT_IMAGES)")
                        // image path
                        
                        let imagePath = imageFolderPath.appendingPathComponent(object.name)
                        printOn(pMessage: imagePath)
                        if  object.name != ""{
                            let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath.path))
                            let img1 = UIImageView()

                            if countImage >= 5 {
                                if countImage == 5{xPos = 0}
                                img1.frame =  CGRect (x: xPos, y: imgSize + viewSpace, width: imgSize, height: imgSize)
                            }
                            else{
                                img1.frame =  CGRect (x: xPos, y: 0, width: imgSize, height: imgSize)
                            }
                            img1.image = UIImage(data: fileData)
                            productPhotoView!.addSubview(img1)
                            img1.isUserInteractionEnabled = true
                            img1.tag = object.imageTag
                            
                            let lpgr = CustomTap(target: self, action: #selector(handleLongPress(sender:)))
                            lpgr.cutomTag = UploadTAG103
                            lpgr.imageName = imagePath
                            lpgr.pKey = STORED_PRODUCT_PHOTOS_KEY
                            lpgr.dic = object as imageData
                            lpgr.minimumPressDuration = 0.5
                            lpgr.delegate = self
                            img1.addGestureRecognizer(lpgr)
                            
                            xPos += (imgSize + viewSpace)
                            countImage += 1
                        }
                    
                        let viewAddUnit = productPhotoView?.view(withId: "\(UploadTAG203)")
                        
                        if countImage > 5{
                            productPhotoView?.frame = CGRect(x: (productPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (productPhotoView?.frame.size.width)!, height: CGFloat(controlsHeight  + 20 + imgSize * 2))
                             viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize *  2 + viewSpace) , width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight ))
                        }
                        else{
                          viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                        }
                     
                    }

                } else {
                    productPhotoView?.frame = CGRect(x: (productPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (productPhotoView?.frame.size.width)!, height: CGFloat(internal_view_Space))
                        
                        let viewAddUnit = productPhotoView?.view(withId: "\(UploadTAG203)")
                          let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_PRODUCT_PHOTOS_KEY)
                        if imagesArray!.count > 5{
                            productPhotoView?.frame = CGRect(x: (productPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (productPhotoView?.frame.size.width)!, height: CGFloat(controlsHeight  + 20 + imgSize * 2))
                            viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace) , width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight ))
                        }
                        else{
                            viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                        }
                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            internal_Space += Int(productPhotoView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
            
        } else {
            // product
            let productPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG103)")
            productPhotoView?.frame = CGRect(x: (productPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (productPhotoView?.frame.size.width)!, height: (productPhotoView?.frame.size.height)!)
    
            internal_Space += Int(productPhotoView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
        }
        
        
        // unit photos
        let manufacturingUnitView = self.appUploadScrollView.view(withId:  "\(UploadTAG105)")
        
        // Manufacturing Unit photos View
        if ptag == UploadTAG105 {

            do {

                let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_MANIFACTURING_UNIT_PHOTOS_KEY)
                SingletonClassSwift.sharedInstance.invisibleView(RefView: manufacturingUnitView!)
                
                if  imagesArray !=  nil && imagesArray!.count > 0 {
                    
                    let imgSize = (SCREEN_WIDTH-40) / 3
                    manufacturingUnitView?.frame = CGRect(x: (manufacturingUnitView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitView?.frame.size.width)!, height: CGFloat(controlsHeight + 20 + imgSize))
                    
                    var xPos = 0
                    
                    for object in imagesArray! {
                        
                        let fileManager = FileManager.default
                        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                        
                        // check image folder name
                        let filePath =  tDocumentDirectory!.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
                        
                        // check folder name
                        let imageFolderPath =  filePath.appendingPathComponent("\(MANUFACTRUNG_IMAGES)")
                        // image path
                        
                        let imagePath = imageFolderPath.appendingPathComponent(object.name)
                        printOn(pMessage: imagePath)
                        if  object.name != ""{
                            let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath.path))
                            let img1 =  UIImageView (frame: CGRect (x: xPos, y: 0, width: imgSize, height: imgSize))
                            img1.image = UIImage(data: fileData)
                            manufacturingUnitView?.addSubview(img1)
                            img1.isUserInteractionEnabled = true
                            img1.tag = object.imageTag
                            
                            let lpgr = CustomTap(target: self, action: #selector(handleLongPress(sender:)))
                            lpgr.cutomTag = UploadTAG105
                            lpgr.imageName = imagePath
                            lpgr.pKey = STORED_MANIFACTURING_UNIT_PHOTOS_KEY
                            lpgr.dic = object as imageData
                            lpgr.minimumPressDuration = 0.5
                            lpgr.delegate = self
                            img1.addGestureRecognizer(lpgr)
                            
                            xPos += (imgSize + viewSpace)
                        }
            
                        let viewAddUnit = manufacturingUnitView?.view(withId: "\(UploadTAG205)")
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                        
                    }
                } else {
                    manufacturingUnitView?.frame = CGRect(x: (manufacturingUnitView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitView?.frame.size.width)!, height: CGFloat(internal_view_Space))
                    
                    let viewAddUnit = manufacturingUnitView?.view(withId: "\(UploadTAG205)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))

                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            internal_Space += Int(manufacturingUnitView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
            
        } else {
            
            // Manufacturing Unit View
            let manufacturingUnitView = self.appUploadScrollView.view(withId: "\(UploadTAG105)")
            manufacturingUnitView?.frame = CGRect(x: (manufacturingUnitView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitView?.frame.size.width)!, height: (manufacturingUnitView?.frame.size.height)!)
    
            internal_Space += Int(manufacturingUnitView!.frame.height) + common_margin
            printOn(pMessage: internal_Space)
        }
        
       
        
        // ManufacturingUnitVideoView

        let manufacturingUnitVideoView = self.appUploadScrollView.view(withId: "\(UploadTAG107)")
        manufacturingUnitVideoView?.frame = CGRect(x: (manufacturingUnitVideoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitVideoView?.frame.size.width)!, height: (manufacturingUnitVideoView?.frame.size.height)!)
        
        if ptag == UploadTAG107 {
        
                do {
                    let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_MANIFACTURING_UNIT_VIDEO_KEY)
                    SingletonClassSwift.sharedInstance.invisibleView(RefView: manufacturingUnitVideoView!)
                    
                    if  imagesArray !=  nil && imagesArray!.count > 0 {
                        
                        let imgSize = (SCREEN_WIDTH-40) / 3
                        manufacturingUnitVideoView?.frame = CGRect(x: (manufacturingUnitVideoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitVideoView?.frame.size.width)!, height: CGFloat(controlsHeight + 20 + imgSize))
                     
                        var xPos = 0
                        
                        for object in imagesArray! {
                            
                            let fileManager = FileManager.default
                            let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                            
                            // check folder name
                            let imageFolderPath =  tDocumentDirectory!.appendingPathComponent("\(VIDEOS_FOLDER_NAME)")
                            // image path
                            let imagePath = imageFolderPath.appendingPathComponent(object.name)
                            printOn(pMessage: imagePath)
                            if  object.name != ""{
                            
                                let img1 =  UIImageView (frame: CGRect (x: xPos, y: 0, width: imgSize, height: imgSize))
                                img1.backgroundColor = UIColor.lightGray
                                img1.image = self.createThumbnailOfVideoFromRemoteUrl(url: imagePath.path)
                                manufacturingUnitVideoView!.addSubview(img1)
                                img1.isUserInteractionEnabled = true
                                img1.tag = object.imageTag
                                
                                let imgThumbnail =  UIImageView (frame: CGRect (x: 0, y: 0, width: 20, height: 20))
                                imgThumbnail.backgroundColor = UIColor.clear
                                imgThumbnail.image = UIImage(named: "playIcon")
                                imgThumbnail.center = img1.center
                                manufacturingUnitVideoView!.addSubview(imgThumbnail)
               
                                
                                let lpgr = CustomTap(target: self, action: #selector(handleLongPress(sender:)))
                                lpgr.cutomTag = UploadTAG107
                                lpgr.imageName = imagePath
                                lpgr.dic = object as imageData
                                lpgr.pKey = STORED_MANIFACTURING_UNIT_VIDEO_KEY
                                lpgr.minimumPressDuration = 0.5
                                lpgr.delegate = self
                                img1.addGestureRecognizer(lpgr)
                                
                                xPos += (imgSize + viewSpace)
                            }
                     
                            let viewAddUnit = manufacturingUnitVideoView?.view(withId: "\(UploadTAG207)")
                            viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + 5), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                        }
                    } else {
                        manufacturingUnitVideoView?.frame = CGRect(x: (manufacturingUnitVideoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitVideoView?.frame.size.width)!, height: CGFloat(internal_view_Space))
                        
                        let viewAddUnit = manufacturingUnitVideoView?.view(withId: "\(UploadTAG207)")
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                    }
                } catch {
                    print("failed: \(error.localizedDescription)")
                }
                
                internal_Space += Int(manufacturingUnitVideoView!.frame.height) + common_margin
                printOn(pMessage: internal_Space)
                
            } else {
                let manufacturingUnitVideoView = self.appUploadScrollView.view(withId: "\(UploadTAG107)")
                manufacturingUnitVideoView?.frame = CGRect(x: (manufacturingUnitVideoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (manufacturingUnitVideoView?.frame.size.width)!, height: (manufacturingUnitVideoView?.frame.size.height)!)
        
                internal_Space += Int(manufacturingUnitVideoView!.frame.height) + common_margin
                printOn(pMessage: internal_Space)
            }


        // AchievementPhotoView
        let achievementPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG109)")
        
        if ptag == UploadTAG109 {
            
            do {

                let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_ACHIEVEMENT_PHOTO_KEY)
                SingletonClassSwift.sharedInstance.invisibleView(RefView: achievementPhotoView!)
                
                if  imagesArray !=  nil && imagesArray!.count > 0 {
                    
                    let imgSize = (SCREEN_WIDTH-40) / 3
                    achievementPhotoView?.frame = CGRect(x: (achievementPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (achievementPhotoView?.frame.size.width)!, height: CGFloat(controlsHeight + 20 + imgSize))
                    
                    var xPos = 0
                    
                    for object in imagesArray! {
                        
                        let fileManager = FileManager.default
                        let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                        
                        // check image folder name
                        let filePath =  tDocumentDirectory!.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
                        
                        // check folder name
                        let imageFolderPath =  filePath.appendingPathComponent("\(ACHIEVEMENT_IMAGES)")
                        // image path
                        
                        let imagePath = imageFolderPath.appendingPathComponent(object.name)
                        printOn(pMessage: imagePath)
                        if  object.name != ""{
                            let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath.path))
                            let img1 =  UIImageView (frame: CGRect (x: xPos, y: 0, width: imgSize, height: imgSize))
                            img1.image = UIImage(data: fileData)
                            achievementPhotoView?.addSubview(img1)
                            img1.isUserInteractionEnabled = true
                            img1.tag = object.imageTag
                            
                            let lpgr = CustomTap(target: self, action: #selector(handleLongPress(sender:)))
                            lpgr.cutomTag = UploadTAG105
                            lpgr.imageName = imagePath
                            lpgr.pKey = STORED_ACHIEVEMENT_PHOTO_KEY
                            lpgr.dic = object as imageData
                            lpgr.minimumPressDuration = 0.5
                            lpgr.delegate = self
                            img1.addGestureRecognizer(lpgr)
                            
                            xPos += (imgSize + viewSpace)
                        }
                      
                        
                        let viewAddUnit = achievementPhotoView?.view(withId: "\(UploadTAG209)")
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + 10), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                        
                     
                    }
                } else {
                    achievementPhotoView?.frame = CGRect(x: (achievementPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (achievementPhotoView?.frame.size.width)!, height: CGFloat(internal_view_Space))
                    
                    let viewAddUnit = achievementPhotoView?.view(withId: "\(UploadTAG209)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeight))
                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            internal_Space += Int(achievementPhotoView!.frame.height) + common_margin + 20
            printOn(pMessage: internal_Space)
            
        } else {
            // AchievementPhotoView
            let achievementPhotoView = self.appUploadScrollView.view(withId: "\(UploadTAG109)")
            achievementPhotoView?.frame = CGRect(x: (achievementPhotoView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (achievementPhotoView?.frame.size.width)!, height: (achievementPhotoView?.frame.size.height)!)
    
            internal_Space += Int(achievementPhotoView!.frame.height) + common_margin + 20
            printOn(pMessage: internal_Space)
        }
        
        
        btnNextUploadView?.frame = CGRect(x: (btnNextUploadView?.frame.origin.x)!, y: CGFloat(internal_Space), width: (btnNextUploadView?.frame.size.width)!, height: (btnNextUploadView?.frame.size.height)!)
        
        internal_Space += Int(btnNextUploadView!.frame.height) + common_margin

        let  subscrollViewWidth:CGFloat = appUploadScrollView.frame.width
        let  subscrollViewHeight:CGFloat = CGFloat(internal_Space )
        
        printOn(pMessage: subscrollViewHeight)
        
        appUploadScrollView.layoutIfNeeded()
        appUploadScrollView.isScrollEnabled = true
        appUploadScrollView.contentSize = CGSize (width: subscrollViewWidth , height: subscrollViewHeight)
      
        
    }
    
    private func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(fileURLWithPath: url))
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
        }
    }
    
    
    //MARK: actions
    @objc func btnAddImagePressed(sender: UIButton) {
        
        if sender.tag == UploadTAG101 {
            // unit
            let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_UNIT_PHOTOS_KEY)
            
            if imagesArray?.count == 3 {
                self.displayAlertMessage(pMessage: "Max 3 Photos allowed!")
                return
            }
        } else if sender.tag == UploadTAG103 {
            // product
            let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_PRODUCT_PHOTOS_KEY)
            
            if imagesArray?.count == 10 {
                self.displayAlertMessage(pMessage: "Max 10 Photos allowed!")
                return
            }
        } else if sender.tag == UploadTAG105 {
            // man unit image
            let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_MANIFACTURING_UNIT_PHOTOS_KEY)
            
            if imagesArray?.count == 3 {
                self.displayAlertMessage(pMessage: "Max 3 Photos allowed!")
                return
            }
        } else if sender.tag == UploadTAG109 {
            // man unit image
            let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_ACHIEVEMENT_PHOTO_KEY)
            
            if imagesArray?.count == 3 {
                self.displayAlertMessage(pMessage: "Max 3 Photos allowed!")
                return
            }
        }
        
        

        self.openCamera(pTag: sender.tag)
        
    }
    
    @objc func btnAddVideoPressed(sender: UIButton) {
        
       if sender.tag == UploadTAG107 {
           // man unit video
           let imagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: STORED_MANIFACTURING_UNIT_VIDEO_KEY)
           
           if imagesArray?.count == 2 {
               self.displayAlertMessage(pMessage: "Max 2 Videos allowed!")
               return
           }
       }
        
       VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera,pickerTag: sender.tag)
        
    }
    
    private func openCamera(pTag:Int)
    {
        printOn(pMessage: pTag)
        if pTag == UploadTAG107{
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.mediaTypes = ["public.movie"]
                imagePicker.cameraCaptureMode = .video;
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                picker = UIImagePickerController()
                picker!.allowsEditing = false
                picker.view.tag = pTag
                picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                picker!.sourceType = UIImagePickerController.SourceType.camera
                picker!.cameraCaptureMode = .photo
                self.present(picker!, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
 
    //MARK:- SectionClick
      @objc  func onbtnSetionPressed(sender : UIButton) {
        
        global_Y_Position = TOP_HEADER_HEIGHT + 3 + common_margin + TOP_SUBHEADER_HEIGHT + ( STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
        printOn(pMessage: global_Y_Position)
        global_ADD_Y_Position =  global_Y_Position


        if sender.tag == 1{
            
            if   self.buttonView.isSelected == false{
//                if tabVIEW_View != nil{
//                    self.tabVIEW_View.removeFromSuperview()
//                }
                
//                if tabVIEW_View == nil{
//                    self.initScrollView()
//                }
                self.buttonUpload.isSelected = false
                self.buttonView.isSelected = true
                self.buttonAdd.isSelected = false
                
                self.tabVIEW_View.isHidden = false
                self.tabAdd_View.isHidden = true
                  if appUploadScrollView != nil{
                    self.appUploadScrollView.isHidden = true
                }
            }
           
        }
        else if sender.tag == 2{

            if  self.buttonAdd.isSelected == false{
//                if tabAdd_View != nil{
//                    self.tabAdd_View.removeFromSuperview()
//                }
                
                if tabAdd_View == nil{
                    self.initScrollAdd()
                }
                self.buttonUpload.isSelected = false
                self.buttonView.isSelected = false
                self.buttonAdd.isSelected = true
                self.buttonUpload.isEnabled = true
                
                self.tabVIEW_View.isHidden = true
                self.tabAdd_View.isHidden = false
                if appUploadScrollView != nil{
                    self.appUploadScrollView.isHidden = true
                }
            }
          
        }
        else{
            
            if SingletonViewControllerClassSwift.shared.add_Validation == "1"{
                if  self.buttonUpload.isSelected == false{
                    //                clearDiskCache(folderName:IMAGES_FOLDER_NAME)
                    
                    //                if appUploadScrollView != nil{
                    //                    self.appUploadScrollView.removeFromSuperview()
                    //                }
                    
                    if appUploadScrollView == nil{
                        self.initUploadDesign(ptag: 0)
                    }
                    self.tabVIEW_View.isHidden = true
                    self.tabAdd_View.isHidden = true
                    self.appUploadScrollView.isHidden = false
                    
                    
                    self.buttonUpload.isSelected = true
                    self.buttonView.isSelected = false
                    self.buttonAdd.isSelected = false
                }
            }else{
                self.displayAlertMessage(pMessage: "Please complete Add section")
            }

           
           
        }
        
    }

    //MARK:- Button Click
    @objc func addSubmitPressed(sender:UIButton) {
        
        let unitNameTxtView = UnitName.view(withId: "\(TAG6)") as! CustomTextView
        let udhyogAdharNoOtpView = UdyogAadharNumber.view(withId: "\(TAG7)") as! DPOTPView
        let estblishDateView = UnitEstablishmentDate.view(withId: "\(TAG8)") as! CustomTextFieldForAttribute
        let prodCommeDate = ProductionCommencementDate.view(withId: "\(TAG9)") as! CustomTextFieldForAttribute
        currentAddr = (addressView.view(withId: "\(TAG1)") as! CustomTextView)
        let year = SalesValueperYear.view(withId: "\(TAG10)") as! CustomTextField
        let prodVl = ProductionValue.view(withId: "\(TAG11)") as! CustomTextField
        let salesVl = SalesValue.view(withId: "\(TAG12)") as! CustomTextField
        fulltimeVl = (self.fullTimeView.view(withId: "\(TAG13)") as! CustomTextField)
        parttimeVl = (self.partTimeView.view(withId: "\(TAG14)") as! CustomTextField)
        seasonalVl = (self.seasonalView.view(withId: "\(TAG15)") as! CustomTextField)
        femaleEmpVl = (N_FemaleEmployees.view(withId: "\(TAG16)") as! CustomTextField)
        maleEmpVl = (N_MaleEmployees.view(withId: "\(TAG17)") as! CustomTextField)
        totalEmpVl = (TotalNumberEmployees.view(withId: "\(TAG18)") as! CustomTextField)
        if unitNameTxtView.text == "" {
            self.displayAlertMessage(pMessage: "Please enter unit name")
            return
        } else if udhyogAdharNoOtpView.text == "" {
            self.displayAlertMessage(pMessage: "Please enter udhyog adhaar number")
            return
        } else if estblishDateView.text == "" {
            self.displayAlertMessage(pMessage: "Please enter establishment date")
            return
        } else if prodCommeDate.text == "" {
            self.displayAlertMessage(pMessage: "Please enter production coomencement date")
            return
        } else if currentAddr.text == "" {
            self.displayAlertMessage(pMessage: "Please enter current address")
            return
        } 
//        } else if fulltimeVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter full time")
//            return
//        } else if parttimeVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter part time")
//            return
//        } else if seasonalVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter seasonal")
//            return
//        } else if femaleEmpVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter numer of \n female employees")
//            return
//        } else if maleEmpVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter numer of \n male employees")
//            return
//        } else if totalEmpVl.text == "" {
//            self.displayAlertMessage(pMessage: "Please enter total \n number of employees")
//            return
//        }

      
        if self.marginSelected.isMarginMoneyCallback == true {
            
            let callBackAmtVl = self.CallBackAmount.view(withId: "\(TAG20)") as! CustomTextField
            let reasonVl = self.ReasonCallBack.view(withId: "\(TAG21)") as! CustomTextView
            
            if callBackAmtVl.text == "" {
                self.displayAlertMessage(pMessage: "Please enter call \n back amount")
                return
            }
          else if reasonVl.text == "" {
                self.displayAlertMessage(pMessage: "Please enter reason \n for call back")
                return
            }
            let maxLength = Int(SingletonViewControllerClassSwift.shared.mm_rel_amt!)!
            let currentString: NSString = callBackAmtVl.text! as NSString
            let currInt = Int(currentString as String)!
            
            if maxLength <= currInt{
                self.displayAlertMessage(pMessage: "Call back amount is not greater than\nmargin money release amount.")
                return
            }
            
            dic_unitMMInfo.setValue(callBackAmtVl.text, forKey:"callBackAmt")
            dic_unitMMInfo.setValue(reasonVl.text, forKey:"callbackReason")
        }
        else{
            dic_unitMMInfo.setValue("", forKey:"callBackAmt")
            dic_unitMMInfo.setValue("", forKey:"callbackReason")
        }
//MM INFO Details Fill
        dic_unitMMInfo.setValue(self.marginSelected.isMarginMoneyCallback, forKey:"isMmCallback")
        
     
        print(dic_unitMMInfo)
        
// UnitProd details fill
        dic_unitProd.setValue(year.text, forKey:"year")
        dic_unitProd.setValue(salesVl.text, forKey:"salesValue")
        dic_unitProd.setValue(prodVl.text, forKey:"prodValue")
        
//verifier INFO Details Fill
//        dic_verifierInfo.setValue("2020-2-25", forKey:"verificationDate")
//        dic_verifierInfo.setValue("l", forKey:"verificationStatus")
//        dic_verifierInfo.setValue("abc", forKey:"agencyName")
//        dic_verifierInfo.setValue("Good", forKey:"remarks")
        
//unit INFO Details Fill
        dic_unitInfo.setValue(estblishDateView.text, forKey:"unitEstDate")
        dic_unitInfo.setValue(prodCommeDate.text, forKey:"prodCommDate")
        dic_unitInfo.setValue(unitNameTxtView.text, forKey:"unitName")
        dic_unitInfo.setValue(udhyogAdharNoOtpView.text, forKey:"udhyogAadharNo")
        dic_unitInfo.setValue(fulltimeVl.text, forKey:"employmentFullTime")
        dic_unitInfo.setValue(parttimeVl.text, forKey:"employmentPartTime")
        dic_unitInfo.setValue(seasonalVl.text, forKey:"employmentSeasonal")
        dic_unitInfo.setValue(femaleEmpVl.text, forKey:"noFemaleEmployees")
        dic_unitInfo.setValue(maleEmpVl.text, forKey:"noMaleEmployees")
        dic_unitInfo.setValue(totalEmpVl.text, forKey:"total_employees")
        dic_unitInfo.setValue(currentAddr.text, forKey:"unitAddress")
        
        
        if SingletonClassSwift.sharedInstance.is_location_changed == true {
            dic_unitInfo.setValue("\(SingletonClassSwift.sharedInstance.changed_location_latitude)", forKey:"latitude")
            dic_unitInfo.setValue("\(SingletonClassSwift.sharedInstance.changed_location_longitude)", forKey:"longitude")
        } else {
            dic_unitInfo.setValue(self.storeViewData["latitude"].stringValue, forKey:"latitude")
            dic_unitInfo.setValue(self.storeViewData["longitude"].stringValue, forKey:"longitude")
        }
        
       GISWebServicesManager.addDetail_forInspectionWS(appId: self.storeViewData["app_id"].stringValue , unitProd:dic_unitProd , unitMMInfo: dic_unitMMInfo, unitInfo: dic_unitInfo, verifierInfo: "" ,onCompletion: { response in
    
                self.printOn(pMessage: response)
                //self.displayAlertMessage(pMessage: "Data Added Successfully!")
                let alert = UIAlertController(title: "Message", message: "Data Added Successfully!", preferredStyle:
                    .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler:{ (UIAlertAction)in
                    // opening upload screen
                    let btn = UIButton()
                    btn.tag = 3
                    SingletonViewControllerClassSwift.shared.add_Validation = "1"
                    self.onbtnSetionPressed(sender: btn)
                }))
                
                self.present(alert, animated: true, completion:nil)
        
                
            },onError:{ error in
                if error != nil {
                    self.displayAlertMessage(pMessage: "Something went wrong. ")
                }
            })
       }
    
    @objc func uploadSubmitPressed(sender:UIButton) {
        
        var allowSubmit = false
        
        var uploadingArray = [imageData]()
        uploadingArray = self.ALLimagesArray!
        
        
        for objectImage in uploadingArray{
            self.printOn(pMessage: objectImage.type)
            if objectImage.type == UNIT_IMAGES {
                allowSubmit = true
                break
            }
            
        }
        
        if allowSubmit == false {
            self.displayAlertMessage(pMessage: "Please upload Unit Photo!")
            return
        }
        
        let isEditMode = SingletonClassSwift.sharedInstance.getDataForKey(strKey: INSPECTION_EDIT_MODE) as? Bool
        
        if isEditMode == true {
        
            
            for object in uploadingArray {
                if object.isUploaded == true {
                    uploadingArray =  uploadingArray.removing(object)
                }
                
            }
        }
        
        if uploadingArray.count == 0 {
            
            let isVerifyDone = SingletonClassSwift.sharedInstance.getDataForKey(strKey: IS_VERIFICATION_SCREEN_DONE) as! Bool
            
            if isVerifyDone == true {
                self.previewVC = PreviewViewController()
                self.previewVC.appid = self.storeViewData["app_id"].stringValue
                self.previewVC.storeViewData = self.storeViewData
                self.navigationController?.pushViewController(self.previewVC, animated: true)
            } else {
                self.VerificationDetailVC = VerificationDetailViewController()
                self.VerificationDetailVC.storeViewData = self.storeViewData
                self.VerificationDetailVC.isFromVerification = true
                self.navigationController?.pushViewController(self.VerificationDetailVC, animated: true)
            }
            
            
            
           
            
            return
        }
        
        var imageCount = uploadingArray.count
        
                    DispatchQueue.main.async {
                        for objectImage in uploadingArray{
                                GISWebServicesManager.ImageAndVideoOnServer(appId: self.storeViewData["app_id"].string!, imagedata: objectImage ,onCompletion: { response in
                                
                                    imageCount -= 1
                                    
                                    if imageCount == 0 {
                                        self.openAlertView()
                                    }
                                    
                        },onError:{ error in
                        if error != nil {
                                self.displayAlertMessage(pMessage: "Something went wrong. ")
                        }
                    })
                }
        }
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


extension InspectionFormViewController:FlexibleSteppedProgressBarDelegate {
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     didSelectItemAtIndex index: Int) {
        progressBar.currentIndex = index
        if index > maxIndex {
            maxIndex = index
            progressBar.completedTillIndex = maxIndex
        }else{
            printOn(pMessage: index)
        }
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     canSelectItemAtIndex index: Int) -> Bool {
        
        if progressBar == myProgressBar{
            if index > maxIndex {
                maxIndex = index
                self.onbtnProgressbarPressed(newIndex: index)
            }else{
                printOn(pMessage: index)
                self.onbtnProgressbarPressed(newIndex: index)
            }
        }
        else{
            if index > maxIndex {
                maxIndex = index
                self.onAddSectionbtnProgressbarPressed(newIndex: index)
            }else{
                printOn(pMessage: index)
                self.onAddSectionbtnProgressbarPressed(newIndex: index)
            }
        }
      
        return true
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
       
        if  progressBar == myProgressBar{
            if position == FlexibleSteppedProgressBarTextLocation.top {
                return ""
            } else if position == FlexibleSteppedProgressBarTextLocation.bottom {
                switch index {
                case 0: return "Beneficiary Detail"
                case 1: return "Unit Detail"
                case 2: return "Project Cost"
                case 3: return "Bank Detail"
                case 4: return "Fifth"
                default: return "Date"
                }
            } else if position == FlexibleSteppedProgressBarTextLocation.center {
                switch index {
                case 0: return "1"
                case 1: return "2"
                case 2: return "3"
                case 3: return "4"
                case 4: return "5"
                default: return "0"
                }
            }
        }
        else{
            if position == FlexibleSteppedProgressBarTextLocation.top {
                return ""
            } else if position == FlexibleSteppedProgressBarTextLocation.bottom {
                switch index {
                case 0: return "Unit Detail"
                case 1: return "Sales Detail"
                case 2: return "Employment Detail"
                case 3: return "Margin Money"
                case 4: return "Fifth"
                default: return "Date"
                }
            } else if position == FlexibleSteppedProgressBarTextLocation.center {
                switch index {
                case 0: return "1"
                case 1: return "2"
                case 2: return "3"
                case 3: return "4"
                case 4: return "5"
                default: return "0"
                }
            }
        }
        
        return ""
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     imageAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> UIImageView {
        if progressBar == myProgressBar{
            if position == FlexibleSteppedProgressBarTextLocation.center {
                switch index {
                case 0:
                    // for icon
                    if index == myProgressBar.currentIndex {
                        return UIImageView(image:UIImage(named: "pUserBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pUserWhite"))
                    }
                    
                case 1:
                    if index == myProgressBar.currentIndex {
                        return UIImageView(image:UIImage(named: "pUnitBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pUnitWhite"))
                    }
                case 2:
                    if index == myProgressBar.currentIndex {
                        return UIImageView(image:UIImage(named: "pCostBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pCostWhite"))
                    }
                case 3:
                    if index == myProgressBar.currentIndex {
                        return UIImageView(image:UIImage(named: "pBankBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pBankWhite"))
                    }
                default:
                    return UIImageView(image:UIImage(named: "buttonSetting"))
                }
            }
        }
      else{
            if position == FlexibleSteppedProgressBarTextLocation.center {
                switch index {
                case 0:
                    if index == myProgressBarAdd.currentIndex {
                        return UIImageView(image:UIImage(named: "pUnitBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pUnitWhite"))
                    }
                case 1:
                    if index == myProgressBarAdd.currentIndex {
                        return UIImageView(image:UIImage(named: "pCostBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pCostWhite"))
                    }
                case 2:
                    if index == myProgressBarAdd.currentIndex {
                        return UIImageView(image:UIImage(named: "pEmploymentBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pEmploymentWhite"))
                    }
                case 3:
                    if index == myProgressBarAdd.currentIndex {
                        return UIImageView(image:UIImage(named: "pBankBlue"))
                    } else {
                        return UIImageView(image:UIImage(named: "pBankWhite"))
                    }
                default:
                    return UIImageView(image:UIImage(named: "buttonSetting"))
                }
            }
        }
        
        return UIImageView(image:UIImage(named: "buttonSetting"))

    }

    func addCommenVIew(Y: Int ,Width:Int) -> UIView {
        let cView = UIView (frame: CGRect (x: 0, y: Y, width:Width, height: 1))
        cView.backgroundColor = LINE_BACKGROUND_COLOUR
        return cView
    }
    func addSeparateVIew(Y: Int ,Width:Int) -> UIView {
        let cView = UIView (frame: CGRect (x: 0, y: Y, width:Width, height: X_PADDING_SUBHEADER))
        cView.backgroundColor = SEPARATE_BACKGROUND_COLOUR
        return cView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView ==  self.appFormScrollView{
            let value = scrollView.contentOffset.y
            let page = Int(round(value))
            printOn(pMessage: "scrollViewDidEndDragging + \(page)")

            if page >  Int(slideToY_bankDetail)  - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding  {
                myProgressBar.currentIndex = 3
            }else if page > Int(slideToY_projectcost)  {
                myProgressBar.currentIndex = 2
            }else if page > Int(slideToY_unitDetail){
                myProgressBar.currentIndex = 1
            }else  {
                myProgressBar.currentIndex = 0
            }
        }else {
            let value = scrollView.contentOffset.y
            let page = Int(round(value))
//            printOn(pMessage: "scrollViewDidEndDragging + \(page)")
            printOn(pMessage: Int(TotalNumberEmployees.center.y + 20) )

            if page > Int(slideToY_margin) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding   {
                myProgressBarAdd.currentIndex = 3
            }else if page > Int(slideToY_employment) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding  {
                myProgressBarAdd.currentIndex = 2
            }else if page > Int(slideToY_sales ) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding{
                myProgressBarAdd.currentIndex = 1
            }else  {
                myProgressBarAdd.currentIndex = 0
            }
        }
    }

    
    // actions
    @objc func buttonBackPressed(sender:UIButton) {
        
        let alert = UIAlertController(title: "Message", message: "Data may be lost! Are you sure?", preferredStyle:
                   .alert)
               
               alert.addAction(UIAlertAction(title: "Okay", style: .default, handler:{ (UIAlertAction)in
                    self.navigationController?.popViewController(animated: true)
               }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                          
                      }))
               
               self.present(alert, animated: true, completion:nil)

    }

   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        if scrollView ==  self.appFormScrollView{
            let value = scrollView.contentOffset.y
            let page = Int(round(value))
            printOn(pMessage: "scrollViewDidEndDecelerating + \(page)")

            if page > Int(slideToY_bankDetail) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding   {
                myProgressBar.currentIndex = 3
            }else if page >  Int(slideToY_projectcost)  {
                myProgressBar.currentIndex = 2
            }else if page > Int(slideToY_unitDetail) {
                myProgressBar.currentIndex = 1
            }else  {
                myProgressBar.currentIndex = 0
            }
        } else{
            let value = scrollView.contentOffset.y
            let page = Int(round(value))

            printOn(pMessage: Int(TotalNumberEmployees.center.y + 20) )

            if page > Int(slideToY_margin) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding  {
                myProgressBarAdd.currentIndex = 3
            }else if page > Int(slideToY_employment)  - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding {
                myProgressBarAdd.currentIndex = 2
            }else if page > Int(slideToY_sales) - SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding{
                myProgressBarAdd.currentIndex = 1
            }else  {
                myProgressBarAdd.currentIndex = 0
            }
        }
     }

  
    
    //MARK:- image / video delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            // For Saving Videos
            self.saveVideoOnLocalFolder(picker, didFinishPickingMediaWithInfo: info, videoURL: url)
            
        } else {
            // For Saving Images
            self.saveImageOnLocalFolder(picker, didFinishPickingMediaWithInfo: info)
           
        }
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Taking Image functins
    private func saveImageOnLocalFolder(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // check layer id folder name
            let filePath =  tDocumentDirectory.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                    
                } catch {
                    NSLog("Couldn't create layer id directory")
                }
            }
            
            var imageFolderPath:URL!
            
            if picker.view.tag == UploadTAG101 {
                // unit photos
                // check folder name
                imageFolderPath =  filePath.appendingPathComponent("\(UNIT_IMAGES)")
                
                do {
                    
                    if !fileManager.fileExists(atPath: imageFolderPath.path) {
                        try fileManager.createDirectory(atPath: imageFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                } catch {
                    NSLog("Couldn't create image directory")
                }
            } else  if picker.view.tag == UploadTAG103 {
                // product photos
                // check folder name
                imageFolderPath =  filePath.appendingPathComponent("\(PRODUCT_IMAGES)")
                
                do {
                    
                    if !fileManager.fileExists(atPath: imageFolderPath.path) {
                        try fileManager.createDirectory(atPath: imageFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                } catch {
                    NSLog("Couldn't create image directory")
                }
            } else  if picker.view.tag == UploadTAG105 {
                // MANUFACTRUNG_IMAGES photos
                // check folder name
                imageFolderPath =  filePath.appendingPathComponent("\(MANUFACTRUNG_IMAGES)")
                
                do {
                    
                    if !fileManager.fileExists(atPath: imageFolderPath.path) {
                        try fileManager.createDirectory(atPath: imageFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                } catch {
                    NSLog("Couldn't create image directory")
                }
            } else  if picker.view.tag == UploadTAG109 {
                // ACHIEVEMENT_IMAGES photos
                // check folder name
                imageFolderPath =  filePath.appendingPathComponent("\(ACHIEVEMENT_IMAGES)")
                
                do {
                    
                    if !fileManager.fileExists(atPath: imageFolderPath.path) {
                        try fileManager.createDirectory(atPath: imageFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                    }
                    
                } catch {
                    NSLog("Couldn't create image directory")
                }
            }
            
            
            
            let timestamp = NSDate().timeIntervalSince1970
            let myInt = Int(timestamp)
            print(myInt)

 
            // choose a name for your image
            let imageName = Date().toMillis()
            print(imageName!)
            let fileName = "\(imageName!).jpg"
            // create the destination file url to save your image
            let fileURL = imageFolderPath.appendingPathComponent(fileName)
            // get your UIImage jpeg data representation and check if the destination file url already exists
            if let data = selectedImage.jpegData(compressionQuality:  IMAGE_COMPRESS_QUALITY),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    do {
                        // writes the image data to disk
                        try data.write(to: fileURL)
                        
                        print("file saved")
                    } catch {
                        print("error saving file:", error)
                    }
                    var attachment_name : String!
                    
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                        
                        if picker.view.tag == UploadTAG101 {
                            // unit photos
                            attachment_name = UNIT_IMAGES + "_\(myInt)_" +  self.storeViewData["app_id"].string! + ".jpg"
                            
                            self.saveImagesInMemory(pType: UNIT_IMAGES, pFileName: fileName, pKey: STORED_UNIT_PHOTOS_KEY, pImageTag: myInt, img_videoData: data, attachment_name: attachment_name)
                        } else if picker.view.tag == UploadTAG103 {
                            // product photos
                             attachment_name = PRODUCT_IMAGES + "_\(myInt)_" +  self.storeViewData["app_id"].string! + ".jpg"
                            self.saveImagesInMemory(pType: PRODUCT_IMAGES, pFileName: fileName, pKey: STORED_PRODUCT_PHOTOS_KEY, pImageTag:  myInt, img_videoData: data, attachment_name: attachment_name)
                        } else if picker.view.tag == UploadTAG105 {
                            // MANIFACTURING photos
                                 attachment_name = MANUFACTRUNG_IMAGES + "_\(myInt)_" +  self.storeViewData["app_id"].string! + ".jpg"
                            self.saveImagesInMemory(pType: MANUFACTRUNG_IMAGES, pFileName: fileName, pKey: STORED_MANIFACTURING_UNIT_PHOTOS_KEY, pImageTag:  myInt, img_videoData: data, attachment_name: attachment_name)
                        } else if picker.view.tag == UploadTAG109 {
                            // ACHIEVEMENT photos
                                attachment_name = ACHIEVEMENT_IMAGES + "_\(myInt)_" +  self.storeViewData["app_id"].string! + ".jpg"
                            self.saveImagesInMemory(pType: ACHIEVEMENT_IMAGES, pFileName: fileName, pKey: STORED_ACHIEVEMENT_PHOTO_KEY, pImageTag:  myInt, img_videoData: data, attachment_name: attachment_name)
                        }
      
                        self.reloadUploadDesign(ptag: picker.view.tag)
                    }
                    
                }
            }
        
        }
        
    }
//    ,attachment_name:String
    private func saveImagesInMemory(pType:String,pFileName:String,pKey:String,pImageTag:Int , img_videoData : Data ,attachment_name:String) {
        
        KVICimagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: pKey)
        
        if KVICimagesArray == nil {
            KVICimagesArray = [imageData]()
        }
        
        
//        let appid =  String(self.storeViewData["app_id"].string!)
//        print(appid)
        let lat = SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.latitude ?? 0
        let lng = SingletonClassSwift.sharedInstance.locationManager.location?.coordinate.longitude ?? 0
        
        let dic = imageData (name:pFileName , type: pType, imageTag: pImageTag, latitude:"\(lat)", longitude:"\(lng)", img_videoData: img_videoData,attachment_name: attachment_name , appID: self.storeViewData["app_id"].stringValue,uploadedID: "",isUploaded: false)
        printOn(pMessage: dic)

        KVICimagesArray!.append(dic)
        ALLimagesArray?.append(dic)
        SingletonClassSwift.sharedInstance.setImageData(strData: KVICimagesArray!, strKey: pKey)
      
    }
    
    private func RemoveImagesInMemory(pType:String,pFileName:String,pKey:String,pImageTag:Int,ptag:Int) {
        
        KVICimagesArray = SingletonClassSwift.sharedInstance.getImageDataForKey(strKey: pKey)
    
        
        if KVICimagesArray != nil {
            
            for i in KVICimagesArray!{
                if  i.imageTag == pImageTag {
                    KVICimagesArray =  KVICimagesArray!.removing(i)
                }
                
             }
        } else {
        }
        printOn(pMessage: KVICimagesArray!.count)
        
        SingletonClassSwift.sharedInstance.setImageData(strData: KVICimagesArray!, strKey: pKey)

        reloadUploadDesign(ptag: ptag)
    }
    
    private func saveVideoOnLocalFolder(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], videoURL:URL) {
        

           let fileManager = FileManager.default
           if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
               
               // check layer id folder name
               let videoFolderPath =  tDocumentDirectory.appendingPathComponent("\(VIDEOS_FOLDER_NAME)")
               if !fileManager.fileExists(atPath: videoFolderPath.path) {
                   do {
                       try fileManager.createDirectory(atPath: videoFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                       
                   } catch {
                       NSLog("Couldn't create layer id directory")
                   }
               }
            let timestamp = NSDate().timeIntervalSince1970
            let myInt = Int(timestamp)
            print(myInt)

               
               // choose a name for your image
                let videoName = Date().toMillis()
                print(videoName!)
                let fileName = "\(videoName!).mp4"
                // create the destination file url to save your video
                let fileURL = videoFolderPath.appendingPathComponent(fileName)
                var videoData  : Data?
            
               if let selectedVideoURL:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
                   
                   DispatchQueue.global(qos: .userInitiated).async {
                       
                       do {
                           let videoData = try? Data(contentsOf: selectedVideoURL)
                           
                           // writes the image data to disk
                           try videoData!.write(to: fileURL)
                           
                        // Bounce back to the main thread to update the UI
                                              DispatchQueue.main.async {
                                                  
                                               let imageSize = fileURL.fileSizeString
                                               print(imageSize)
                                               
                                               let attachmentVideo_name : String!
                                               attachmentVideo_name = VIDEOS_FOLDER_NAME + "_\(myInt)_" +  self.storeViewData["app_id"].string! + ".mp4"
                                               
                                               self.saveImagesInMemory(pType: VIDEOS_FOLDER_NAME, pFileName: fileName, pKey: STORED_MANIFACTURING_UNIT_VIDEO_KEY, pImageTag:myInt, img_videoData: videoData!, attachment_name: attachmentVideo_name)
                                           
                                               self.reloadUploadDesign(ptag: picker.view.tag)
                                           
                                               
                                              }
                        
                           print("file saved")
                       } catch {
                           print("error saving file:", error)
                       }
                       

                   }
               }
               
               
               
           }
       }
}
    


extension Array where Element: Equatable {
    func removing(_ obj: Element) -> [Element] {
        return filter { $0 != obj }
    }
}
