//
//  infectionFormViewController.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 29/01/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import SwiftyJSON
import FlexibleSteppedProgressBar
import MobileCoreServices
import AVFoundation
import Alamofire
import AlamofireImage

class PreviewViewController: UIViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate,UIPickerViewDelegate{
    
        fileprivate let IMAGE_BASE_URL = "\(BASE_URL)api/kvic/getImage?appId="
        // Screen Controls
        fileprivate var headerview:UIView!
        fileprivate var buttonBack: UIButton!
        fileprivate var buttonSave: UIButton!
        fileprivate var lblHeader:UILabel!
        fileprivate var global_Y_Position:Int! = 0
        fileprivate var global_ADD_Y_Position:Int! = 0

        fileprivate var globalScroll_Y_Position:Int! = 0

        fileprivate let spacing = 20
        fileprivate let controlsHeight = 40
        //    fileprivate let controlsHeightView = 200
        let common_margin : Int = 10

        //SUBHEADER (VIEW,ADD,UPLOAD)
        fileprivate var subHeaderview:UIView!
        fileprivate var formView:UIView!
        fileprivate var buttonView: UIButton!
        fileprivate var buttonAdd: UIButton!
        fileprivate var buttonUpload: UIButton!


        fileprivate var addUnitDetailView:UIView!
        fileprivate var UdyogAadharNumber:DynamicLabel!
        fileprivate var UnitName:DynamicLabel!
        fileprivate var UnitEstablishmentDate:DynamicLabel!
        fileprivate var ProductionCommencementDate:DynamicLabel!


        fileprivate var addSalesDetailView:UIView!
        fileprivate var  SalesValueperYear :DynamicLabel!
        fileprivate var ProductionValue :DynamicLabel!
        fileprivate var productionYear :DynamicLabel!
        fileprivate var  SalesValue:DynamicLabel!

        fileprivate var addEmploymentDetailView:UIView!
        fileprivate var  fullTime :DynamicLabel!
        fileprivate var partTime :DynamicLabel!
        fileprivate var  seasonal :DynamicLabel!
        fileprivate var  N_FemaleEmployees :DynamicLabel!
        fileprivate var N_MaleEmployees :DynamicLabel!
        fileprivate var  TotalNumberEmployees:DynamicLabel!

        fileprivate var addMarginMoneyView:UIView!
        fileprivate var marginAmount: DynamicLabel!
        fileprivate var marginReleaseDate: DynamicLabel!
        fileprivate var ReasonCallBack:DynamicLabel!
        fileprivate var CallBackAmount:DynamicLabel!
        fileprivate var MarginMoneyCallBack:DynamicLabel!
        var mmCalBack = ""
        fileprivate  var lbl_ReasonCallBack :CustomLabel!
        fileprivate  var lbl_CallBackAmount : CustomLabel!
        //    fileprivate var marginSelected:MarginSelectView!
        var selectedStatus: String!
        fileprivate var btnNextMarginView : CustomButton!
        fileprivate var yScroll_subscroll : Int!

        var slideToY_unitDetail : CGFloat!
        var slideToY_projectcost : CGFloat!
        var slideToY_bankDetail : CGFloat!
        var slideToY_sales : CGFloat!
        var slideToY_employment : CGFloat!
        var slideToY_margin : CGFloat!


        //    fileprivate var  subScrollViewmarginView : UIScrollView!
        fileprivate var appFormScrollView:UIScrollView!
        fileprivate var appAddScrollView:UIScrollView!
        fileprivate var appUploadScrollView:UIScrollView!

        var picker:UIImagePickerController!
        fileprivate var importMenuForImages:UIDocumentPickerViewController!
        var isFromTable:Bool! = false

        fileprivate var imagesDic = [Dictionary<String, String>]()

        //    fileprivate var tabView_View:UIView!
        fileprivate var tabAdd_View:UIView!
        fileprivate var tabVIEW_View:UIView!
        var viewAlert = AlertView()


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
        fileprivate var stateView:CustomComboBoxView!
        fileprivate var districtView:CustomComboBoxView!
        fileprivate var pincodeView:CustomOTPTypeView!
        fileprivate  var talukaView:CustomInputFieldView!
        fileprivate  var addressView:CustomInputTextView!

        fileprivate var currentAddress: DynamicLabel!
        fileprivate var currentTaluka: DynamicLabel!
        fileprivate var currentDistrict: DynamicLabel!
        fileprivate var currentState: DynamicLabel!
        fileprivate var currentPincode: DynamicLabel!


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
        //    fileprivate var myProgressBar: FlexibleSteppedProgressBar!
        //    fileprivate var myProgressBarAdd: FlexibleSteppedProgressBar!
        var storeViewData:JSON!

        fileprivate var progressColor = UIColor(red: 53.0 / 255.0, green: 226.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0)
        fileprivate var textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)

        fileprivate var maxIndex = -1
        var appid : String!
     
    var dummyViewData = ["BeneficiaryData":["KVMH161741-1518099", "Yogita Sachin Kohle" ,"Female","Schedule Cast" ,"sachinkolhe15@gmail.com", "8883646901"],"UnitData": ["Urban", "Manufacturing" ,"Pottery Making","Earthen Pot, Gullak, Wind Chain, Dishes, Showpiece" ,"No", "Shop No. 8, Ground Floor, Panchwati Plaza, Kutchery Rd, Deputy Para","Ranchi","Ahirtoli","Jharkhand","834001","Same as above Address"], "ProjectCostData": ["8.00 Lakhs", "4.32 Lakhs" ,"1.17 Lakhs","13.49 Lakhs"],"BankData":["State Bank of India", "Lal Darwaja Branch" ,"Shop No. 8, Ground Floor, Panchwati Plaza, Kutchery Rd, Deputy Para","SBIN0000301"]]
    
    var dummyAddData = ["unitData":["Khadi Grama Soubhagya Attukal Shopping Complex Eastfort","UP27D0002849","22 February 2020","30 March 2020"], "SalesData":["Rs 2,01,239","Rs 1,00,000"],"EmploymentData" : ["12","6","3","4","17","21"],"MmData":["Rs 2,01,239","22 December 2019","Yes","Rs 2,50,000","Due to xyz Reason"]]
    
    
        var arrUnitDetail : JSON!
        var arrSaleDetail :  JSON!
        var arrMMInfo :  JSON!
        var arrUnitPhotos :  [JSON]!
        var arrAchievementPhoto : [JSON]!
        var arrProductPhoto :  [JSON]!
        var arrManufacturingVideo : [JSON]!
        var arrManufacturingPhoto : [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        SingletonClassSwift.sharedInstance.setData(strData: true, strKey: INSPECTION_EDIT_MODE)

        self.initPreviewDataAPI()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
   
    func initPreviewDataAPI()  {

        GISWebServicesManager.getPreviewDataWS(appId: appid, onCompletion: { response in
            
            self.arrUnitDetail = response!["data"]["unitInfo"]
            self.arrSaleDetail = response!["data"]["unitProd"]
            self.arrMMInfo = response!["data"]["unitMMInfo"]
            
            if let items = response!["data"]["attachments"]["UnitPhoto"].array {
                self.arrUnitPhotos = items
            }
            
            if let items = response!["data"]["attachments"]["ManufacturingPhoto"].array {
                           self.arrManufacturingPhoto = items
                       }
            
            if let items = response!["data"]["attachments"]["ProductPhoto"].array {
                           self.arrProductPhoto = items
                       }
            
            if let items = response!["data"]["attachments"]["ManufacturingVideo"].array {
                           self.arrManufacturingVideo = items
                       }
            
            if let items = response!["data"]["attachments"]["AchievementPhoto"].array {
                           self.arrAchievementPhoto = items
                       }
            
//            self.arrUnitPhotos = response!["data"]["attachments"]["UnitPhoto"].array
            //self.arrManufacturingPhoto = response!["data"]["attachments"]["ManufacturingPhoto"]
            //self.arrProductPhoto = response!["data"]["attachments"]["ProductPhoto"]
            //self.arrManufacturingVideo = response!["data"]["attachments"]["ManufacturingVideo"]
           // self.arrAchievementPhoto = response!["data"]["attachments"]["AchievementPhoto"]
            
            print(self.arrUnitDetail)
            self.initHeader()
        
        },onError:{ error in
            
            if error != nil {
                self.displayAlertMessage(pMessage: "Something went wrong. ")
            }
            
        })
        
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
        self.buttonBack.setTitle("Edit", for: .normal)
        self.buttonBack.setTitleColor(blueTextColor, for: .normal)
        let buttonBackSpace:CGFloat = 5.0
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonBack.addTarget(self, action: #selector(btnCancelPressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        self.buttonSave = UIButton(frame: CGRect(x: SCREEN_WIDTH - HEADER_BUTTON_WIDTH, y: 0, width: HEADER_BUTTON_WIDTH, height: TOP_HEADER_HEIGHT))
        self.buttonSave.setTitle("Save", for: .normal)
        self.buttonSave.setTitleColor(blueTextColor, for: .normal)
        self.buttonSave.backgroundColor = UIColor.clear
        self.buttonSave.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonSave.addTarget(self, action: #selector(btnSavePressed), for: .touchUpInside)
        headerview.addSubview(self.buttonSave)
        
        self.lblHeader = UILabel(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH - 100, height: TOP_HEADER_HEIGHT))
        self.lblHeader.textColor = blueTextColor
        self.lblHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        self.lblHeader.text = "Inspection Form Preview"
        self.lblHeader.textAlignment = .center
        headerview.addSubview(self.lblHeader)
        self.initPersonalDetails()
    }
    
    @objc func btnCancelPressed(sender:UIButton) {
        let desiredViewController = self.navigationController!.viewControllers.filter { $0 is InspectionFormViewController }.first!
        self.navigationController!.popToViewController(desiredViewController, animated: true)
    }
    
    @objc func btnSavePressed() {
        
        GISWebServicesManager.callFinalSubmit(appId: self.storeViewData["app_id"].stringValue, status: "Visited",onCompletion: { response in
            
            self.printOn(pMessage: response!["success"])
            
            if response!["success"] == true {
                self.openAlertView()
               
                
            } else {
                self.displayAlertMessage(pMessage: response!["message"].string!)
                self.printOn(pMessage: response!["message"])
            }

        }, onError:{ error in
            
            if error != nil {
                self.displayAlertMessage(pMessage: "Something went wrong. ")
            }
            
        })
    }
    
    func onPreviewPressed() {
        
        SingletonClassSwift.sharedInstance.is_preview_done = true
  
        viewAlert.removeFromSuperview()
        let desiredViewController = self.navigationController!.viewControllers.filter { $0 is KhadiStoreListViewController }.first!
        self.navigationController!.popToViewController(desiredViewController, animated: true)

    }
    
    private func openAlertView() {
        viewAlert = AlertView (frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH , height: SCREEN_HEIGHT))
        viewAlert.initDesign(title: "Form Previewed Successfully.", btnTitle: "Done")
        viewAlert.previewAlertDelegate = self
        viewAlert.backgroundColor = ALERT_BACKGROUND_COLOUR
        viewAlert.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        self.view.addSubview(viewAlert)
    }

    private func initPersonalDetails() {
        
        global_Y_Position += TOP_HEADER_HEIGHT + 3
        let btnWidth = 70

        subHeaderview = UIView(frame: CGRect(x: 0, y: global_Y_Position, width: Int(UIScreen.main.bounds.width), height: TOP_SUBHEADER_HEIGHT));
        subHeaderview.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        self.view.addSubview(subHeaderview)

        let view1 = UIView(frame: CGRect(x: X_PADDING, y: 1, width: btnWidth , height: btnWidth))
        subHeaderview.addSubview(view1)

        self.buttonView = UIButton(frame: CGRect(x: 0, y: 15, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
       self.buttonView.center = CGPoint(x:Int(view1.center.x), y: Int(buttonView.center.y))
        printOn(pMessage: self.buttonView.frame)
        self.buttonView.titleLabel?.font = UIFont .boldSystemFont(ofSize:LABEL_FONT_SIZE )
        self.buttonView.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonView.backgroundColor = UIColor.clear
         self.buttonView.isSelected = true
        self.buttonView.setBackgroundImage(UIImage (named: "first"), for: .normal)
        self.buttonView.setBackgroundImage(UIImage (named: "firstSelect"), for: .selected)
        self.buttonView.tag = 1
        self.buttonView.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        view1.addSubview(self.buttonView)
    
        self.buttonAdd = UIButton(frame: CGRect(x: 0 , y: 15, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
        self.buttonAdd.center = CGPoint(x:Int(subHeaderview.center.x), y: Int(self.buttonAdd.center.y))
        printOn(pMessage: self.buttonAdd.frame)

        self.buttonAdd.isSelected = false
        self.buttonAdd.titleLabel?.font = UIFont .boldSystemFont(ofSize:LABEL_FONT_SIZE )
        self.buttonAdd.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonAdd.backgroundColor = UIColor.clear
        self.buttonAdd.setBackgroundImage(UIImage (named: "second"), for: .normal)
        self.buttonAdd.setBackgroundImage(UIImage (named: "secondSelect"), for: .selected)
        self.buttonAdd.tag = 2
        self.buttonAdd.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        subHeaderview.addSubview(self.buttonAdd)
        
        let upload_View = UIView(frame: CGRect(x: Int(subHeaderview.frame.width) - btnWidth - (X_PADDING*2), y: 1, width: btnWidth, height: btnWidth))
        subHeaderview.addSubview(upload_View)

        self.buttonUpload = UIButton(frame: CGRect(x: X_PADDING, y: 15, width: SUBHEADER_BUTTON_WIDTH , height: SUBHEADER_BUTTON_HEIGHT))
//        self.buttonUpload.center = CGPoint (x: Int(upload_View.center.x), y: Int(self.buttonUpload.center.y))
        printOn(pMessage: self.buttonUpload.frame)
        self.buttonUpload.isSelected = false
        self.buttonUpload.isEnabled = true
//        self.buttonUpload.backgroundColor = .red
        self.buttonUpload.titleLabel?.font = UIFont (name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        self.buttonUpload.setTitleColor(LABEL_HEADER_COLOUR, for: .normal)
        self.buttonUpload.backgroundColor = UIColor.clear
        self.buttonUpload.setBackgroundImage(UIImage (named: "third"), for: .normal)
        self.buttonUpload.setBackgroundImage(UIImage (named: "thirdSelect"), for: .selected)
        self.buttonUpload.tag = 3
        self.buttonUpload.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        upload_View.addSubview(self.buttonUpload)
        
        global_Y_Position += TOP_SUBHEADER_HEIGHT 
        global_ADD_Y_Position =  global_Y_Position
        
        self.initScrollView()
        self.tabAdd_View = UIView()
//        self.tabAdd_View.backgroundColor = .red
        self.appUploadScrollView = UIScrollView()
//        self.appUploadScrollView.backgroundColor = .gray
    }
    
    //------------------------------------------
    //    MARK:  VIEW SECTION
    //------------------------------------------
    
    private func initScrollView() {
        
        self.tabVIEW_View = UIView (frame:  CGRect (x: 0, y: CGFloat (global_Y_Position), width: self.view.frame.width, height: self.view.frame.height - CGFloat (global_Y_Position)))
        globalScroll_Y_Position = 0

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
        
         var internal_Space : Int = 30
        var viewSpace : Int = 10

        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Beneficiary Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        BeneficialyView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 20

        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Beneficiary ID"
        BeneficialyView.addSubview(lbl_Beneficiary_ID)
        
        beneficiary_ID = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        beneficiary_ID.text = self.storeViewData["app_id"].string
        BeneficialyView.addSubview(beneficiary_ID)
        
        
        internal_Space += Int(beneficiary_ID.bounds.height) + common_margin + viewSpace

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Beneficiary Name"
        BeneficialyView.addSubview(lbl_Beneficiary_Name)
        
        beneficiary_Name = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        beneficiary_Name.text = self.storeViewData["app_name"].string
        let hight = SingletonClassSwift.sharedInstance.heightForView(text:beneficiary_Name.text , width: CGFloat(LABEL_WIDTH), Label: beneficiary_Name)
        beneficiary_Name.frame = CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight)
        BeneficialyView.addSubview(beneficiary_Name)
        
        
        internal_Space += Int(beneficiary_Name.bounds.height) + common_margin + viewSpace

        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Gender"
        BeneficialyView.addSubview(lbl_Gender)
        
        gender = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        gender.text = self.storeViewData["gender"].string
        BeneficialyView.addSubview(gender)
        
        internal_Space +=  Int(gender.bounds.height) + common_margin + viewSpace

        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Social Category"
        BeneficialyView.addSubview(lbl_Social_Category)
        
        social_Category = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        social_Category.text = self.storeViewData["benf_category"].string
        BeneficialyView.addSubview(social_Category)
        
        internal_Space += Int(social_Category.bounds.height) + common_margin + viewSpace
        
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
        BeneficialyView.addSubview(email_ID)
        
        internal_Space += Int(email_ID.bounds.height) + common_margin + viewSpace

        let lbl_mobile_Number = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_mobile_Number.text = "Mobile Number"
        BeneficialyView.addSubview(lbl_mobile_Number)
        
        mobile_Number = DynamicLabel (frame: CGRect (x: Int(BeneficialyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        mobile_Number.text = self.storeViewData["mob_no"].string
        BeneficialyView.addSubview(mobile_Number)
        
        internal_Space +=  Int(mobile_Number.bounds.height) + common_margin + 20
        
        let btnNext = CustomButton (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.frame.width) - (X_PADDING * 2), height: NEXT_BUTTON_HEIGHT))
        btnNext.setTitle("Next", for: .normal)
        btnNext.tag = 2
        btnNext.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        btnNext.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        BeneficialyView.addSubview(btnNext)
        
        internal_Space +=  Int(btnNext.bounds.height) + common_margin + 20 + viewSpace
        
        slideToY_unitDetail  = CGFloat(internal_Space)
//        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(BeneficialyView.bounds.width))
//        BeneficialyView.addSubview(sView)
//        internal_Space +=  Int(sView.bounds.height) + common_margin + 20 + viewSpace

        global_Y_Position = internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)
        
        printOn(pMessage: scrollViewHeight)
        printOn(pMessage: unitDetailView.frame)
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        
//        unitDetailView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))
//        self.appFormScrollView.addSubview(unitDetailView)
//        self.initUnitDetails()
    }
    
    
    //MARK:- Unit
    private func initUnitDetails() {
        
        var internal_Space : Int = 0
        printOn(pMessage: internal_Space)
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Unit Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        unitDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        let lbl_Office_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Office_Name.text = "Office Name"
        unitDetailView.addSubview(lbl_Office_Name)
        
        office_Name = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        office_Name.text = dummyViewData["UnitData"]![0]
        unitDetailView.addSubview(office_Name)
        
        internal_Space += Int(office_Name.bounds.height) + common_margin
        
        let lbl_Agency = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Agency.text = "Agency"
        unitDetailView.addSubview(lbl_Agency)
        
        agency = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        agency.text = dummyViewData["UnitData"]![0]
        unitDetailView.addSubview(agency)
        
        internal_Space += Int(agency.bounds.height) + common_margin
        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Unit Location"
        unitDetailView.addSubview(lbl_Beneficiary_ID)
        
        unit_Location = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        unit_Location.text =  dummyViewData["UnitData"]![0]
        unitDetailView.addSubview(unit_Location)
        
        internal_Space += Int(unit_Location.bounds.height) + common_margin
        
        let cView =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView)

        internal_Space += Int(cView.bounds.height) + common_margin

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Industry Type"
        unitDetailView.addSubview(lbl_Beneficiary_Name)
        
        industry_Type = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        industry_Type.text =  dummyViewData["UnitData"]![1]
        unitDetailView.addSubview(industry_Type)
        
        internal_Space += Int(industry_Type.bounds.height) + common_margin
        
        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Industry Activity"
        unitDetailView.addSubview(lbl_Gender)
        
        industry_Activity = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - 10, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        industry_Activity.text =  dummyViewData["UnitData"]![2]
        unitDetailView.addSubview(industry_Activity)
        
        internal_Space +=  Int(industry_Activity.bounds.height) + common_margin
        
        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Product Description"
        unitDetailView.addSubview(lbl_Social_Category)
        
        product_Description = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - 10, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT ))
//        let  social_Category_hegiht = heightForView(text:product_Description.text! , width: CGFloat(LABEL_WIDTH))
        product_Description.text =  dummyViewData["UnitData"]![3]
        product_Description.lineBreakMode = .byWordWrapping
        product_Description.numberOfLines = 0
        unitDetailView.addSubview(product_Description)
        
        internal_Space += Int(product_Description.bounds.height) + common_margin
        
        let cView1 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView1)
        
        internal_Space += Int(cView1.bounds.height) + common_margin
        
        let EDP_Completed = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        EDP_Completed.text = "EDP Completed"
        unitDetailView.addSubview(EDP_Completed)
        
        edp_Completed = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT ))
        edp_Completed.text =  dummyViewData["UnitData"]![4]
        unitDetailView.addSubview(edp_Completed)

        internal_Space += Int(edp_Completed.bounds.height) + common_margin

        let cView2 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView2)
        
        internal_Space += Int(cView2.bounds.height) + common_margin

        let lbl_Email_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Email_ID.text = "Address"
        unitDetailView.addSubview(lbl_Email_ID)
        
        address = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT * 2 ))
        address.text =  dummyViewData["UnitData"]![5]
        address.lineBreakMode = .byWordWrapping
        address.numberOfLines = 0
        unitDetailView.addSubview(address)
        
        internal_Space += Int(address.bounds.height) + common_margin
        
        let lbl_mobile_Number = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_mobile_Number.text = "Taluka/ Block"
        unitDetailView.addSubview(lbl_mobile_Number)
        
        taluka = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        taluka.text =  dummyViewData["UnitData"]![6]
        unitDetailView.addSubview(taluka)
        
        internal_Space +=  Int(taluka.bounds.height) + common_margin
        
        let lbl_District = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_District.text = "District"
        unitDetailView.addSubview(lbl_District)
        
        district = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        district.text =  dummyViewData["UnitData"]![7]
        unitDetailView.addSubview(district)
        
        internal_Space +=  Int(district.bounds.height) + common_margin
        
        let lbl_State = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_State.text = "State"
        unitDetailView.addSubview(lbl_State)
        
        state = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        state.text =  dummyViewData["UnitData"]![8]
        unitDetailView.addSubview(state)
        
        internal_Space +=  Int(state.bounds.height) + common_margin
        
        let lbl_Pincode = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_Pincode.text = "Pincode"
        unitDetailView.addSubview(lbl_Pincode)
        
         pincode = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        pincode.text =  dummyViewData["UnitData"]![9]
        unitDetailView.addSubview(pincode)
        
        internal_Space +=  Int(pincode.bounds.height) + common_margin
        
        let cView3 =  self.addCommenVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(cView3)
        
        internal_Space +=  Int(cView3.bounds.height) + common_margin

        
        let lbl_currentAddress = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentAddress.text = "Current Address"
        unitDetailView.addSubview(lbl_currentAddress)
        
        currentAddress = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT * 2 ))
        currentAddress.text =  dummyViewData["UnitData"]![5]
        currentAddress.lineBreakMode = .byWordWrapping
        currentAddress.numberOfLines = 0
        unitDetailView.addSubview(currentAddress)
        
        internal_Space += Int(currentAddress.bounds.height) + common_margin
        
        let lbl_taluka = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_taluka.text = "Taluka/Block"
        unitDetailView.addSubview(lbl_taluka)
        
        currentTaluka = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentTaluka.text =  dummyViewData["UnitData"]![6]
        unitDetailView.addSubview(currentTaluka)
        
        internal_Space +=  Int(currentTaluka.bounds.height) + common_margin
        
        let lbl_currentDistrict = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentDistrict.text = "District"
        unitDetailView.addSubview(lbl_currentDistrict)
        
        currentDistrict = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentDistrict.text =  dummyViewData["UnitData"]![7]
        unitDetailView.addSubview(currentDistrict)
        
        internal_Space +=  Int(currentDistrict.bounds.height) + common_margin
        
        let lbl_currentState = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentState.text = "State"
        unitDetailView.addSubview(lbl_currentState)
        
        currentState = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentState.text =  dummyViewData["UnitData"]![8]
        unitDetailView.addSubview(currentState)
        
        internal_Space +=  Int(currentState.bounds.height) + common_margin
        
        let lbl_currentPincode = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentPincode.text = "Pincode"
        unitDetailView.addSubview(lbl_currentPincode)
        
        currentPincode = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentPincode.text =  dummyViewData["UnitData"]![9]
        unitDetailView.addSubview(currentPincode)
        
        internal_Space +=  Int(currentPincode.bounds.height) + common_margin + 20
        

        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(unitDetailView.bounds.width))
        unitDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin + 20
        
         unitDetailView.frame =  CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: CGFloat(global_Y_Position + internal_Space))
        
        global_Y_Position += internal_Space
        
        slideToY_projectcost  = CGFloat(global_Y_Position - common_margin - 40)

        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)
        
        printOn(pMessage: scrollViewHeight)
    
    
        projectCostView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))

        printOn(pMessage: projectCostView.frame)
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.addSubview(projectCostView)
    
        self.initProjectCostDetails()
    }
    //MARK:- ProjectCost

    private func initProjectCostDetails() {
        
//        global_Y_Position += TOP_SUBHEADER_HEIGHT
//        appFormScrollView.contentSize = CGSize (width: SCREEN_WIDTH , height: 400)

        var internal_Space : Int = 0
        
//        global_Y_Position += TOP_SUBHEADER_HEIGHT
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Project Cost"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        projectCostView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
       slideToY_bankDetail = CGFloat(global_Y_Position + internal_Space)
        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Capital Expenditure"
        projectCostView.addSubview(lbl_Beneficiary_ID)
        
        capital_Expenditure = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        capital_Expenditure.text =  dummyViewData["ProjectCostData"]![0]
        projectCostView.addSubview(capital_Expenditure)
        
        internal_Space += Int(capital_Expenditure.bounds.height) + common_margin

        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Working Capital"
        projectCostView.addSubview(lbl_Beneficiary_Name)
        
        working_Capital = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        working_Capital.text = dummyViewData["ProjectCostData"]![1]
        projectCostView.addSubview(working_Capital)
        
        internal_Space += Int(working_Capital.bounds.height) + common_margin

        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Own Contribution"
        projectCostView.addSubview(lbl_Gender)
        
        own_Contribution = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        own_Contribution.text = dummyViewData["ProjectCostData"]![2]
        projectCostView.addSubview(own_Contribution)
        
        internal_Space +=  Int(own_Contribution.bounds.height) + common_margin

        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(projectCostView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "Total"
        projectCostView.addSubview(lbl_Social_Category)
        
        total = DynamicLabel (frame: CGRect (x: Int(projectCostView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        total.text = dummyViewData["ProjectCostData"]![3]
        projectCostView.addSubview(total)
        
        internal_Space +=  Int(total.bounds.height) + common_margin + 20

        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(projectCostView.bounds.width))
        projectCostView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin + 20
        
        projectCostView.frame =  CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: CGFloat(global_Y_Position + internal_Space))
        global_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_Y_Position)
        
        printOn(pMessage: scrollViewHeight)
        bankDeatilView = UIView(frame: CGRect (x:0, y:  CGFloat(global_Y_Position) , width: self.appFormScrollView.frame.width, height: self.appFormScrollView.frame.height))
        printOn(pMessage: bankDeatilView.frame)
        self.appFormScrollView.contentSize = CGSize (width: self.appFormScrollView.frame.width, height: scrollViewHeight)
        self.appFormScrollView.addSubview(bankDeatilView)
        self.initBankDetails()
        
    }
    
    //MARK:- Bank
    private func initBankDetails() {
//        appFormScrollView.contentSize = CGSize (width: SCREEN_WIDTH , height: 400)
        var internal_Space : Int = 0
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Bank Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        bankDeatilView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(BeneficialyView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_ID.text = "Bank"
        bankDeatilView.addSubview(lbl_Beneficiary_ID)
        
        bank = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        bank.text =  dummyViewData["BankData"]![0]
        bankDeatilView.addSubview(bank)
        
        
        internal_Space += Int(beneficiary_ID.bounds.height) + common_margin

        
        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Beneficiary_Name.text = "Branch"
        bankDeatilView.addSubview(lbl_Beneficiary_Name)
        
        branch = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        branch.text =  dummyViewData["BankData"]![1]
        bankDeatilView.addSubview(branch)
        
        
        internal_Space +=   Int(branch.bounds.height) + common_margin
        
        let lbl_Gender = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Gender.text = "Bank Address"
        bankDeatilView.addSubview(lbl_Gender)
        
        bank_Address = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: (LABEL_HEIGHT * 2)))
        bank_Address.text =   dummyViewData["BankData"]![2]
        bank_Address.lineBreakMode = .byWordWrapping
        bank_Address.numberOfLines = 0
        bankDeatilView.addSubview(bank_Address)
        
        
        internal_Space +=  Int(bank_Address.bounds.height) + common_margin
        
        let lbl_Social_Category = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(bankDeatilView.bounds.width), height: LABEL_HEIGHT))
        lbl_Social_Category.text = "IFSC Code"
        bankDeatilView.addSubview(lbl_Social_Category)
        
        ifscCode = DynamicLabel (frame: CGRect (x: Int(bankDeatilView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        ifscCode.text =   dummyViewData["BankData"]![3]
        bankDeatilView.addSubview(ifscCode)
        
        internal_Space +=  Int(ifscCode.bounds.height) + common_margin + 20

//        let btnNext = CustomButton (frame: CGRect (x: Int(bankDeatilView.bounds.width) - 150, y: internal_Space , width:  NEXT_BUTTON_WIDTH, height: NEXT_BUTTON_HEIGHT))
//        btnNext.center = CGPoint (x: self.view.center.x, y: btnNext.center.y)
//        btnNext.setTitle("Next", for: .normal)
////        btnNext.addTarget(self, action: #selector(onbtnNextPressed), for: .touchUpInside)
//
//        btnNext.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
//        bankDeatilView.addSubview(btnNext)
//
//        internal_Space +=  Int(btnNext.bounds.height) + common_margin + 20

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

//        if self.myProgressBar.currentIndex < 3 {
//            self.myProgressBar.currentIndex = self.myProgressBar.currentIndex + 1
//            printOn(pMessage: myProgressBar.currentIndex)
//            if self.myProgressBar.currentIndex > maxIndex {
//                maxIndex = self.myProgressBar.currentIndex
//                myProgressBar.completedTillIndex = maxIndex
//            }
//        }
//
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
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        addUnitDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10

       let lbl_UnitName = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_UnitName.text = "Unit Name"
        addUnitDetailView.addSubview(lbl_UnitName)
        
        UnitName = DynamicLabel(frame: CGRect(x: Int(addUnitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        UnitName.text =  self.arrUnitDetail["unit_name"].stringValue
        UnitName.lineBreakMode = .byWordWrapping
        UnitName.numberOfLines = 0
        addUnitDetailView.addSubview(UnitName)
        
        internal_Space +=  Int(UnitName.bounds.height) + common_margin
        
        
        let lbl_UdyogAadharNumber = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_UdyogAadharNumber.text = "Udyog Aadhar Number"
        addUnitDetailView.addSubview(lbl_UdyogAadharNumber)
        
        UdyogAadharNumber = DynamicLabel(frame: CGRect(x: Int(addUnitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        UdyogAadharNumber.text =  self.arrUnitDetail["udhyog_aadhar_no"].stringValue
        addUnitDetailView.addSubview(UdyogAadharNumber)
        
        internal_Space +=  Int(UdyogAadharNumber.bounds.height) + common_margin
        
        
        let lbl_UnitEstablishmentDate = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_UnitEstablishmentDate.text = "Unit Establishment Date"
        addUnitDetailView.addSubview(lbl_UnitEstablishmentDate)
        
        UnitEstablishmentDate = DynamicLabel(frame: CGRect(x: Int(addUnitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        let dateVar = Date(timeIntervalSince1970: (self.arrUnitDetail["unit_est_date"].doubleValue / 1000.0))
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        print(dateFormatter.string(from: dateVar))
        UnitEstablishmentDate.text = dateFormatter.string(from: dateVar)

        addUnitDetailView.addSubview(UnitEstablishmentDate)
        
        internal_Space +=  Int(UnitEstablishmentDate.bounds.height) + common_margin
        
        let lbl_ProductionCommencementDate = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width/2) , height: LABEL_HEIGHT*2))
        lbl_ProductionCommencementDate.text = "Production Commencement Date"
        lbl_ProductionCommencementDate.lineBreakMode = .byWordWrapping
        lbl_ProductionCommencementDate.numberOfLines = 0
        addUnitDetailView.addSubview(lbl_ProductionCommencementDate)
        
        ProductionCommencementDate = DynamicLabel(frame: CGRect(x: Int(addUnitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        ProductionCommencementDate.text =   self.arrUnitDetail["prod_comm_date"].stringValue
        addUnitDetailView.addSubview(ProductionCommencementDate)
        
        internal_Space +=  Int(lbl_ProductionCommencementDate.bounds.height) + common_margin
        
        let lbl_currentAddress = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentAddress.text = "Current Address"
        addUnitDetailView.addSubview(lbl_currentAddress)
        
        currentAddress = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT * 2 ))
        currentAddress.text =  self.arrUnitDetail["unit_address"].stringValue
        
        let hight = SingletonClassSwift.sharedInstance.heightForView(text:self.arrUnitDetail["unit_address"].stringValue , width: CGFloat(LABEL_WIDTH), Label: currentAddress)
        currentAddress.frame = CGRect (x: Int(addUnitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height:hight)
        
       // currentAddress.lineBreakMode = .byWordWrapping
      //  currentAddress.numberOfLines = 0
        addUnitDetailView.addSubview(currentAddress)
        
        internal_Space += Int(currentAddress.bounds.height) + common_margin
        
       /* let lbl_taluka = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_taluka.text = "Taluka/Block"
        addUnitDetailView.addSubview(lbl_taluka)
        
        currentTaluka = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentTaluka.text =  dummyViewData["UnitData"]![6]
        addUnitDetailView.addSubview(currentTaluka)
        
        internal_Space +=  Int(currentTaluka.bounds.height) + common_margin
        
        let lbl_currentDistrict = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentDistrict.text = "District"
        addUnitDetailView.addSubview(lbl_currentDistrict)
        
        currentDistrict = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentDistrict.text =  dummyViewData["UnitData"]![7]
        addUnitDetailView.addSubview(currentDistrict)
        
        internal_Space +=  Int(currentDistrict.bounds.height) + common_margin
        
        let lbl_currentState = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentState.text = "State"
        addUnitDetailView.addSubview(lbl_currentState)
        
        currentState = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentState.text =  dummyViewData["UnitData"]![8]
        addUnitDetailView.addSubview(currentState)
        
        internal_Space +=  Int(currentState.bounds.height) + common_margin
        
        let lbl_currentPincode = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addUnitDetailView.bounds.width), height: LABEL_HEIGHT))
        lbl_currentPincode.text = "Pincode"
        addUnitDetailView.addSubview(lbl_currentPincode)
        
        currentPincode = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        currentPincode.text =  dummyViewData["UnitData"]![9]
        addUnitDetailView.addSubview(currentPincode)
        
        internal_Space +=  Int(currentPincode.bounds.height) + common_margin + 10
        
 
        let cView3 =  self.addCommenVIew(Y: internal_Space, Width: Int(addUnitDetailView.bounds.width))
        addUnitDetailView.addSubview(cView3)
        
        internal_Space +=  Int(cView3.bounds.height) + common_margin
        
        let lbl_Current_Address = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(unitDetailView.bounds.width/3), height: LABEL_HEIGHT * 2))
        lbl_Current_Address.text = "Communication Address"
        lbl_Current_Address.lineBreakMode = .byWordWrapping
        lbl_Current_Address.numberOfLines = 0
        addUnitDetailView.addSubview(lbl_Current_Address)
        //
        let Current_Address = DynamicLabel (frame: CGRect (x: Int(unitDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT * 2))
        Current_Address.text =  dummyViewData["UnitData"]![5]
        Current_Address.lineBreakMode = .byWordWrapping
        Current_Address.numberOfLines = 0
        addUnitDetailView.addSubview(Current_Address)
        
        internal_Space +=  Int(Current_Address.bounds.height) + common_margin + 20*/

        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(addUnitDetailView.bounds.width))
        addUnitDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin
        
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
    
    //MARK:- Production / Sales Detail
    
    private func initSalesDetails() {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Production / Sales Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        addSalesDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        
        
        let lbl_Year = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width/2), height: LABEL_HEIGHT))
       lbl_Year.text = "Year"
       lbl_Year.lineBreakMode = .byWordWrapping
       lbl_Year.numberOfLines = 0
       addSalesDetailView.addSubview(lbl_Year)
       
       productionYear = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
       productionYear.text = self.arrSaleDetail["year"].stringValue
       addSalesDetailView.addSubview(productionYear)
       
       internal_Space +=  Int(productionYear.bounds.height) + common_margin
        
        
        let lbl_ProductionValueperYear = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width-110), height: LABEL_HEIGHT))
        lbl_ProductionValueperYear.text = "Production Value (in Rupees)"
        lbl_ProductionValueperYear.lineBreakMode = .byWordWrapping
        lbl_ProductionValueperYear.numberOfLines = 0
        addSalesDetailView.addSubview(lbl_ProductionValueperYear)
        
        ProductionValue = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        ProductionValue.text = self.arrSaleDetail["prod_value"].stringValue
        addSalesDetailView.addSubview(ProductionValue)
        
        internal_Space +=  Int(lbl_ProductionValueperYear.bounds.height) + common_margin
        
        let lbl_SalesValueperYear = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addUnitDetailView.frame.size.width/2), height: LABEL_HEIGHT ))
        lbl_SalesValueperYear.text = "Sales Value (in Rupees)"
        lbl_SalesValueperYear.lineBreakMode = .byWordWrapping
        lbl_SalesValueperYear.numberOfLines = 0
        addSalesDetailView.addSubview(lbl_SalesValueperYear)
        
        SalesValueperYear = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        SalesValueperYear.text =  self.arrSaleDetail["sales_value"].stringValue
        addSalesDetailView.addSubview(SalesValueperYear)
        
    internal_Space +=  Int(SalesValueperYear.bounds.height) + common_margin + 20
        
        let sView =  self.addSeparateVIew(Y: internal_Space, Width: Int(addSalesDetailView.bounds.width))
        addSalesDetailView.addSubview(sView)
        
        internal_Space +=  Int(sView.bounds.height) + common_margin
        
        global_ADD_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        slideToY_employment = scrollViewHeight

        printOn(pMessage: scrollViewHeight)
        addEmploymentDetailView = UIView(frame: CGRect (x:0, y:  CGFloat(global_ADD_Y_Position) , width: self.appAddScrollView.frame.width, height: self.appAddScrollView.frame.height))
        printOn(pMessage: addEmploymentDetailView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addEmploymentDetailView)
        
        self.initEmploymentDetail()
        
    }
    //MARK:- Employment Detail
    
    private func initEmploymentDetail() {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Employment Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        addEmploymentDetailView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        
        let Fulltime = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width/2), height: LABEL_HEIGHT))
        Fulltime.text = "Full Time"
        Fulltime.lineBreakMode = .byWordWrapping
        Fulltime.numberOfLines = 0
        addEmploymentDetailView.addSubview(Fulltime)
        
        fullTime = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        fullTime.text = self.arrUnitDetail["employment_full_time"].stringValue
        addEmploymentDetailView.addSubview(fullTime)
        
        
        internal_Space +=  Int(Fulltime.bounds.height) + common_margin

        
        
        let PartTime = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width/2), height: LABEL_HEIGHT))
        PartTime.text = "Part Time"
        PartTime.lineBreakMode = .byWordWrapping
        PartTime.numberOfLines = 0
        addEmploymentDetailView.addSubview(PartTime)
        
        partTime = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        partTime.text =  self.arrUnitDetail["employment_part_time"].stringValue
        addEmploymentDetailView.addSubview(partTime)
        
        
        internal_Space +=  Int(PartTime.bounds.height) + common_margin

        
        let Seasonal = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width/2), height: LABEL_HEIGHT))
        Seasonal.text = "Seasonal"
        Seasonal.lineBreakMode = .byWordWrapping
        Seasonal.numberOfLines = 0
        addEmploymentDetailView.addSubview(Seasonal)
        
        seasonal = DynamicLabel(frame: CGRect(x: Int(addEmploymentDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        seasonal.text = self.arrUnitDetail["employment_seasonal"].stringValue
        addEmploymentDetailView.addSubview(seasonal)
        
        
        internal_Space +=  Int(Seasonal.bounds.height) + common_margin
        
        
        let lbl_N_FemaleEmployees = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_N_FemaleEmployees.text = "Number of Female Employees"
        lbl_N_FemaleEmployees.lineBreakMode = .byWordWrapping
        lbl_N_FemaleEmployees.numberOfLines = 0
        addEmploymentDetailView.addSubview(lbl_N_FemaleEmployees)
        
        
        N_FemaleEmployees = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        N_FemaleEmployees.text = self.arrUnitDetail["no_female_employees"].stringValue
     
        addEmploymentDetailView.addSubview(N_FemaleEmployees)

        internal_Space += Int(N_FemaleEmployees.bounds.height) + common_margin
        
        
        let lbl_N_MaleEmployees = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_N_MaleEmployees.text = "Number of Male Employees"
        lbl_N_MaleEmployees.lineBreakMode = .byWordWrapping
        lbl_N_MaleEmployees.numberOfLines = 0
        addEmploymentDetailView.addSubview(lbl_N_MaleEmployees)
        
        N_MaleEmployees = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        N_MaleEmployees.text =  self.arrUnitDetail["no_male_employees"].stringValue
        addEmploymentDetailView.addSubview(N_MaleEmployees)
        
        internal_Space += Int(N_MaleEmployees.bounds.height) + common_margin
        
        
        let lbl_TotalNumberEmployees = CustomLabel(frame: CGRect(x: X_PADDING, y: internal_Space, width: Int(self.addEmploymentDetailView.frame.size.width) - (X_PADDING * 2), height: LABEL_HEIGHT))
        lbl_TotalNumberEmployees.text = "Total Number of Employees"
        lbl_TotalNumberEmployees.lineBreakMode = .byWordWrapping
        lbl_TotalNumberEmployees.numberOfLines = 0
        addEmploymentDetailView.addSubview(lbl_TotalNumberEmployees)
        
        TotalNumberEmployees = DynamicLabel(frame: CGRect(x: Int(addSalesDetailView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space, width:  LABEL_WIDTH, height: (LABEL_HEIGHT)))
        TotalNumberEmployees.text =  self.arrUnitDetail["total_employees"].stringValue
        addEmploymentDetailView.addSubview(TotalNumberEmployees)
        
        internal_Space += Int(TotalNumberEmployees.bounds.height) + common_margin + 20
        
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
        
        if self.arrMMInfo["is_mm_callback"].stringValue == "true" {
            mmCalBack = "Yes"
            self.initMarginMoneyDetail(status: "Yes")

        } else {
            mmCalBack = "No"
            self.initMarginMoneyDetail(status: "No")

        }
    }
    
    //MARK:- Margin Money Detail
    
    private func initMarginMoneyDetail(status : String) {
        
        var internal_Space : Int = 20
        
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Margin Money Detail"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        addMarginMoneyView.addSubview(lblTitle)
        
        internal_Space += Int(lblTitle.bounds.height) + common_margin + 10
        
        let lbl_Beneficiary_ID = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT * 2  - common_margin))
        lbl_Beneficiary_ID.text = "Margin Money Release Amount"
        lbl_Beneficiary_ID.lineBreakMode = .byWordWrapping
        lbl_Beneficiary_ID.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_Beneficiary_ID)
        
        marginAmount = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        marginAmount.text = self.storeViewData["mm_rel_amt"].stringValue
        addMarginMoneyView.addSubview(marginAmount)
        
        internal_Space += Int(lbl_Beneficiary_ID.bounds.height) + common_margin
        
        let lbl_Beneficiary_Name = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT * 2  - common_margin ))
        lbl_Beneficiary_Name.text = "Margin Money Release Date"
        lbl_Beneficiary_Name.lineBreakMode = .byWordWrapping
        lbl_Beneficiary_Name.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_Beneficiary_Name)
        
        marginReleaseDate = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        marginReleaseDate.text = SingletonClassSwift.getDate(complete:  self.storeViewData["mm_rel_dt"].string!)
        addMarginMoneyView.addSubview(marginReleaseDate)
        
        internal_Space += Int(lbl_Beneficiary_Name.bounds.height) + common_margin
        
        
        let lbl_MarginMoneyCallBack = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT))
        lbl_MarginMoneyCallBack.text = "Margin Money Call Back"
        lbl_MarginMoneyCallBack.lineBreakMode = .byWordWrapping
        lbl_MarginMoneyCallBack.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_MarginMoneyCallBack)
        
        MarginMoneyCallBack = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        
        MarginMoneyCallBack.text = mmCalBack
        addMarginMoneyView.addSubview(MarginMoneyCallBack)
        
        internal_Space += Int(lbl_MarginMoneyCallBack.bounds.height) + common_margin
      
         lbl_CallBackAmount = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT ))
        lbl_CallBackAmount.text = "Call Back Amount"
        lbl_CallBackAmount.lineBreakMode = .byWordWrapping
        lbl_CallBackAmount.numberOfLines = 2

        addMarginMoneyView.addSubview(lbl_CallBackAmount)
        
        CallBackAmount = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        CallBackAmount.text = self.arrMMInfo["call_back_amt"].stringValue
        addMarginMoneyView.addSubview(CallBackAmount)
        
        internal_Space += Int(lbl_CallBackAmount.bounds.height) + common_margin
       
         lbl_ReasonCallBack = CustomLabel (frame: CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.bounds.width/2), height: LABEL_HEIGHT))
        lbl_ReasonCallBack.text = "Reason for Call Back"
        lbl_ReasonCallBack.lineBreakMode = .byWordWrapping
        lbl_ReasonCallBack.numberOfLines = 2
        addMarginMoneyView.addSubview(lbl_ReasonCallBack)
        
        ReasonCallBack = DynamicLabel (frame: CGRect (x: Int(addMarginMoneyView.bounds.width) - LABEL_WIDTH - X_PADDING, y: internal_Space , width:LABEL_WIDTH , height: LABEL_HEIGHT))
        ReasonCallBack.text =  self.arrMMInfo["callback_reason"].stringValue
        addMarginMoneyView.addSubview(ReasonCallBack)
        
        internal_Space += Int(ReasonCallBack.bounds.height) + common_margin  + 20
        
         btnNextMarginView = CustomButton (frame:  CGRect (x: X_PADDING, y: internal_Space , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT))
        btnNextMarginView.center = CGPoint (x: addMarginMoneyView.center.x, y: btnNextMarginView.center.y)
        btnNextMarginView.setTitle("Next", for: .normal)
        btnNextMarginView.tag = 3
        btnNextMarginView.addTarget(self, action: #selector(onbtnSetionPressed(sender:)), for: .touchUpInside)
        addMarginMoneyView.addSubview(btnNextMarginView)

        internal_Space +=  Int(btnNextMarginView.bounds.height) + common_margin + 20
        
        global_ADD_Y_Position += internal_Space
        
        let scrollViewHeight:CGFloat = CGFloat(global_ADD_Y_Position)
        
        printOn(pMessage: scrollViewHeight)
        printOn(pMessage: addMarginMoneyView.frame)
        self.appAddScrollView.contentSize = CGSize (width: self.appAddScrollView.frame.width, height: scrollViewHeight)
        self.appAddScrollView.addSubview(addMarginMoneyView)
        
        getMarginStatus(status: status)
    
        
    }
    
        func getMarginStatus(status : String)  {
    
            if status == "Yes"{
                self.setView(view: lbl_CallBackAmount, hidden: false)
                self.setView(view: CallBackAmount, hidden: false)
                self.setView(view: lbl_ReasonCallBack, hidden: false)
                self.setView(view: ReasonCallBack, hidden: false)

                btnNextMarginView.frame =  CGRect (x: X_PADDING, y: Int(ReasonCallBack.frame.origin.y) + NEXT_BUTTON_WIDTH + 20  , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT)
                btnNextMarginView.center = CGPoint (x: self.view.center.x, y: btnNextMarginView.center.y)
                self.setView(view: btnNextMarginView, hidden: false)
                appAddScrollView.layoutIfNeeded()
                
            }else{
                self.setView(view: lbl_CallBackAmount, hidden: true)
                self.setView(view: CallBackAmount, hidden: true)
                self.setView(view: lbl_ReasonCallBack, hidden: true)
                self.setView(view: ReasonCallBack, hidden: true)
                 btnNextMarginView.frame = CGRect (x: X_PADDING, y: Int(MarginMoneyCallBack.frame.origin.y) + NEXT_BUTTON_HEIGHT + 30  , width: Int(addMarginMoneyView.frame.width) - (X_PADDING * 2 ) , height: NEXT_BUTTON_HEIGHT)
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
        
//        if self.myProgressBarAdd.currentIndex < 3 {
//            self.myProgressBarAdd.currentIndex = self.myProgressBarAdd.currentIndex + 1
//            printOn(pMessage: myProgressBarAdd.currentIndex)
//            if self.myProgressBarAdd.currentIndex > maxIndex {
//                maxIndex = self.myProgressBarAdd.currentIndex
//                myProgressBarAdd.completedTillIndex = maxIndex
//            }
//        }
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
//            self.initUploadDesign(ptag: 0)
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
    
    
    
    private func initUploadDesign(ptag : Int) {
        DispatchQueue.main.async {

            self.appUploadScrollView = UIScrollView (frame: CGRect (x: 0, y:  CGFloat (self.global_Y_Position), width: self.view.frame.width, height: self.view.frame.height - CGFloat (self.global_Y_Position)))
        
        var internal_Space : Int = 20
//        let inside_internal_Space : Int = LABEL_HEIGHT
        var inside_Y_Space : Int = 5
        let viewSpace : Int = 5
        
        //Title
        let lblTitle = UILabel (frame: CGRect (x: 0, y: internal_Space , width: Int(UIScreen.main.bounds.width), height: LABEL_HEIGHT))
        lblTitle.text = "Uploaded Images"
        lblTitle.textColor = blueTextColor
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont (name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
            self.appUploadScrollView.addSubview(lblTitle)
        
            internal_Space += LABEL_HEIGHT  + self.common_margin
//        printOn(pMessage: internal_Space)
        
          let imageWidth = SCREEN_WIDTH - (X_PADDING*2)
            let controlsHeightView = LABEL_HEIGHT + imageWidth/3 + self.common_margin
//        let  HeightView =  imageWidth/3 + common_margin

        //Unit photo View
        let unitPhotoView = UIView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: controlsHeightView))
        unitPhotoView.tag = UploadTAG101
        self.appUploadScrollView.addSubview(unitPhotoView)
 
        let lblName = UILabel(frame: CGRect(x: 0, y: 5, width: Int(unitPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblName.text = "Unit Photo"
        lblName.textColor = blueTextColor
        lblName.sizeToFit()
        lblName.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: SMALL_BUTTON_FONT_SIZE)
        unitPhotoView.addSubview(lblName)
        
        
            do {
               //let imagesArrayUnit = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORED_UNIT_PHOTOS_KEY) as? [[String:String]]
                if self.arrUnitPhotos != nil && self.arrUnitPhotos.count > 0 {
                    
                    let imgSize = (SCREEN_WIDTH-40) / 3
                    
                    unitPhotoView.frame = CGRect(x: (unitPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (unitPhotoView.frame.size.width), height: CGFloat(controlsHeightView))
                    
                    unitPhotoView.backgroundColor = UIColor.clear
                    var xPos = 0
                    
                    
                    for object in self.arrUnitPhotos {

                        let imgURL = "\(self.IMAGE_BASE_URL)\(object["app_id"].stringValue)&attachmentName=\(object["attachment_name"].stringValue)"
                        self.printOn(pMessage: "at URL = \(imgURL)")
                        
                        let img1 =  UIImageView(frame: CGRect (x: xPos, y: LABEL_HEIGHT + viewSpace, width: imgSize, height: imgSize))
                        
                        Alamofire.request(imgURL, method: .get)
                               .validate()
                               .responseData(completionHandler: { (responseData) in
                                   img1.image = UIImage(data: responseData.data!)
                                   DispatchQueue.main.async {
                                       // Refresh you views
                                   }
                               })
    
                        unitPhotoView.addSubview(img1)
                        
                        let viewAddUnit = unitPhotoView.view(withId: "\(UploadTAG201)")
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeightView))
                        xPos += (imgSize + viewSpace)
                    }
                    
                } else {
                    unitPhotoView.frame = CGRect(x: (unitPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (unitPhotoView.frame.size.width), height: CGFloat(self.controlsHeight))
                }
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            internal_Space += Int(unitPhotoView.frame.height) + self.common_margin
//            printOn(pMessage: internal_Space)
        
        
        
        let productPhotoView = UIView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height:controlsHeightView))
        productPhotoView.tag = UploadTAG103
            self.appUploadScrollView.addSubview(productPhotoView)
        
        let lblProductPhoto = UILabel(frame: CGRect(x: 0, y: 5, width: Int(unitPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblProductPhoto.text = "Product Photo"
        lblProductPhoto.textColor = blueTextColor
        lblProductPhoto.sizeToFit()
        lblProductPhoto.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: SMALL_BUTTON_FONT_SIZE)
        productPhotoView.addSubview(lblProductPhoto)
        
        
        do {
           // let imagesArrayProduct = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORED_PRODUCT_PHOTOS_KEY) as? [[String:String]]
            
            if self.arrProductPhoto != nil && self.arrProductPhoto.count > 0 {
                
                let imgSize = (Int((productPhotoView.frame.width)) - (X_PADDING * 2))  / 5
//                 let imageWidth1 = SCREEN_WIDTH - (X_PADDING*5) + 25
                let controlsHeightView1 = LABEL_HEIGHT + imgSize + self.common_margin

                productPhotoView.frame = CGRect(x: (productPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (productPhotoView.frame.size.width), height: CGFloat(controlsHeightView1))
                productPhotoView.backgroundColor = UIColor.clear
                
                var xPos = 0
                var countImage : Int! = 0

                
                for object in self.arrProductPhoto {
                    
                     let img1 = UIImageView()
                    //let img1 =  UIImageView(frame: CGRect (x: xPos, y: LABEL_HEIGHT + 5 + 10, width: imgSize, height: imgSize))
                    
                    let imgURL = "\(self.IMAGE_BASE_URL)\(object["app_id"].stringValue)&attachmentName=\(object["attachment_name"].stringValue)"
                    self.printOn(pMessage: "at URL = \(imgURL)")
                    
                    if countImage >= 5 {
                        if countImage == 5{xPos = 0}
                        img1.frame =  CGRect (x: xPos, y: LABEL_HEIGHT + imgSize + viewSpace, width: imgSize, height: imgSize)
                    }
                    else{
                        img1.frame =  CGRect (x: xPos, y: LABEL_HEIGHT, width: imgSize, height: imgSize)
                    }
                    
                    Alamofire.request(imgURL, method: .get)
                                                              .validate()
                                                              .responseData(completionHandler: { (responseData) in
                                                                  img1.image = UIImage(data: responseData.data!)
                                                                  DispatchQueue.main.async {
                                                                      // Refresh you views
                                                                  }
                                                              })
                    
                   // img1.image = UIImage(data: fileData)
                    productPhotoView.addSubview(img1)
                    
                    let viewAddUnit = productPhotoView.view(withId: "\(UploadTAG203)")
                    
                    if countImage >= 5{
                        
                        productPhotoView.frame =  CGRect(x: Int(productPhotoView.frame.origin.x), y: internal_Space, width: Int((productPhotoView.frame.size.width)), height: self.controlsHeight  + imgSize * 2)
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize *  2  + viewSpace + LABEL_HEIGHT) , width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeightView1))
                    }
                    else{
                        
                        productPhotoView.frame = CGRect(x: (productPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (productPhotoView.frame.size.width), height: CGFloat(self.controlsHeight + imgSize))
                        
                        viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(internal_Space + LABEL_HEIGHT + self.common_margin), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(self.controlsHeight))
                    }
                    countImage += 1
                    xPos += (imgSize + viewSpace)
                }
                
            } else {
                productPhotoView.frame = CGRect(x: (productPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (productPhotoView.frame.size.width), height: CGFloat(self.controlsHeight))
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
            internal_Space += Int(productPhotoView.frame.height) + self.common_margin
//        printOn(pMessage: internal_Space)
        
        
        //manufacturingUnitView photo View
        let manufacturingUnitView = UIView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: controlsHeightView))
        manufacturingUnitView.tag = UploadTAG105
        self.appUploadScrollView.addSubview(manufacturingUnitView)
        
        let lblManufacturingPhoto = UILabel(frame: CGRect(x: 0, y: 5, width: Int(manufacturingUnitView.frame.width/2) , height: LABEL_HEIGHT))
        lblManufacturingPhoto.text = "Manufacturing Unit Photo"
        lblManufacturingPhoto.textColor = blueTextColor
        lblManufacturingPhoto.sizeToFit()
        lblManufacturingPhoto.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: SMALL_BUTTON_FONT_SIZE)
        manufacturingUnitView.addSubview(lblManufacturingPhoto)
        
        do {
            let imagesArraymanufacture = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORED_MANIFACTURING_UNIT_PHOTOS_KEY) as? [[String:String]]
            
            
            if self.arrManufacturingPhoto != nil && self.arrManufacturingPhoto.count > 0 {
                
                let imgSize = (SCREEN_WIDTH-40) / 3
                
                manufacturingUnitView.frame = CGRect(x: (manufacturingUnitView.frame.origin.x), y: CGFloat(internal_Space), width: (manufacturingUnitView.frame.size.width), height: CGFloat(controlsHeightView))
                
                var xPos = 0
                
                for object in self.arrManufacturingPhoto {
                    
                     let imgURL = "\(self.IMAGE_BASE_URL)\(object["app_id"].stringValue)&attachmentName=\(object["attachment_name"].stringValue)"
                    let img1 =  UIImageView(frame: CGRect (x: xPos, y: LABEL_HEIGHT + viewSpace, width: imgSize, height: imgSize))
                    
                     Alamofire.request(imgURL, method: .get)
                                                              .validate()
                                                              .responseData(completionHandler: { (responseData) in
                                                                  img1.image = UIImage(data: responseData.data!)
                                                                  DispatchQueue.main.async {
                                                                      // Refresh you views
                                                                  }
                                                              })
                    
                    manufacturingUnitView.addSubview(img1)
                    
                    let viewAddUnit = manufacturingUnitView.view(withId: "\(UploadTAG205)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeightView))
                    xPos += (imgSize + viewSpace)
                }
                
            } else {
                manufacturingUnitView.frame = CGRect(x: (manufacturingUnitView.frame.origin.x), y: CGFloat(internal_Space), width: (manufacturingUnitView.frame.size.width), height: CGFloat(self.controlsHeight))
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
            internal_Space += Int(manufacturingUnitView.frame.height) + self.common_margin
//        printOn(pMessage: internal_Space)
        
        
        
        //manufacturingUnitView photo View
        let manufacturingVideoView = UIView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: controlsHeightView))
        manufacturingVideoView.tag = UploadTAG105
        self.appUploadScrollView.addSubview(manufacturingVideoView)
        
        let lblManufacturingVideo = UILabel(frame: CGRect(x: 0, y: 5, width: Int(manufacturingVideoView.frame.width/2) , height: LABEL_HEIGHT))
        lblManufacturingVideo.text = "Manufacturing Unit Video"
        lblManufacturingVideo.textColor = blueTextColor
        lblManufacturingVideo.sizeToFit()
        lblManufacturingVideo.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: SMALL_BUTTON_FONT_SIZE)
        manufacturingVideoView.addSubview(lblManufacturingVideo)
        
        do {
            let videoArraymanufacture = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORED_MANIFACTURING_UNIT_VIDEO_KEY) as? [[String:String]]
            
            if self.arrManufacturingVideo != nil && self.arrManufacturingVideo.count > 0 {
                
                let imgSize = (SCREEN_WIDTH-40) / 3
                
                manufacturingVideoView.frame = CGRect(x: (manufacturingVideoView.frame.origin.x), y: CGFloat(internal_Space), width: (manufacturingVideoView.frame.size.width), height: CGFloat(controlsHeightView))
                
                var xPos = 0
                let imgSize1 = (SCREEN_WIDTH-40)

                for object in self.arrManufacturingVideo {
                    
                    let imgURL = "\(self.IMAGE_BASE_URL)\(object["app_id"].stringValue)&attachmentName=\(object["attachment_name"].stringValue)"
                    
                    //                            let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath.path))
                    let img1 =  UIImageView(frame: CGRect (x: xPos, y: LABEL_HEIGHT + viewSpace, width: imgSize, height: imgSize))
                    img1.backgroundColor = UIColor.lightGray
                    
                    Alamofire.request(imgURL, method: .get)
                    .validate()
                    .responseData(completionHandler: { (responseData) in
                        img1.image = UIImage(data: responseData.data!)
                        DispatchQueue.main.async {
                            // Refresh you views
                        }
                    })
                    
                    //img1.image = self.createThumbnailOfVideoFromRemoteUrl(url: imagePath.path)
                    manufacturingVideoView.addSubview(img1)
                    
                    let imgThumbnail =  UIImageView (frame: CGRect (x: 0, y: 0, width: 35, height: 35))
                    imgThumbnail.backgroundColor = UIColor.clear
                    imgThumbnail.image = UIImage(named: "playIcon")
                    imgThumbnail.center = img1.center
                    manufacturingVideoView.addSubview(imgThumbnail)
                    
                    let viewAddUnit = manufacturingVideoView.view(withId: "\(UploadTAG207)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeightView))
                    xPos += (imgSize + viewSpace)
                }
                
            } else {
                manufacturingVideoView.frame = CGRect(x: (manufacturingVideoView.frame.origin.x), y: CGFloat(internal_Space), width: (manufacturingVideoView.frame.size.width), height: CGFloat(self.controlsHeight))
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
            internal_Space += Int(manufacturingVideoView.frame.height) + self.common_margin
//        printOn(pMessage: internal_Space)
        
        
        
        
        //achievementPhotoView photo View
        let achievementPhotoView = UIView(frame: CGRect(x: X_PADDING, y: internal_Space, width: SCREEN_WIDTH - (X_PADDING*2), height: controlsHeightView))
        achievementPhotoView.tag = UploadTAG109
        self.appUploadScrollView.addSubview(achievementPhotoView)
        
        let lblAchievementPhoto = UILabel(frame: CGRect(x: 0, y: 5, width: Int(achievementPhotoView.frame.width/2) , height: LABEL_HEIGHT))
        lblAchievementPhoto.text = "Achievement Photo"
        lblAchievementPhoto.textColor = blueTextColor
        lblAchievementPhoto.sizeToFit()
        lblAchievementPhoto.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: SMALL_BUTTON_FONT_SIZE)
        achievementPhotoView.addSubview(lblAchievementPhoto)
        
        do {
            let imagesArraymanufacture = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORED_ACHIEVEMENT_PHOTO_KEY) as? [[String:String]]
            
            if self.arrAchievementPhoto != nil && self.arrAchievementPhoto.count > 0 {
                
                let imgSize = (SCREEN_WIDTH-40) / 3
                
                achievementPhotoView.frame = CGRect(x: (achievementPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (achievementPhotoView.frame.size.width), height: CGFloat(controlsHeightView))
                
                var xPos = 0
                
                for object in self.arrAchievementPhoto {
                    
                   
                    let imgURL = "\(self.IMAGE_BASE_URL)\(object["app_id"].stringValue)&attachmentName=\(object["attachment_name"].stringValue)"
                    self.printOn(pMessage: "at URL = \(imgURL)")
                    
                    let img1 =  UIImageView(frame: CGRect (x: xPos, y: LABEL_HEIGHT + viewSpace, width: imgSize, height: imgSize))
                    
                    Alamofire.request(imgURL, method: .get)
                           .validate()
                           .responseData(completionHandler: { (responseData) in
                               img1.image = UIImage(data: responseData.data!)
                               DispatchQueue.main.async {
                                   // Refresh you views
                               }
                           })
                    
                    achievementPhotoView.addSubview(img1)
                    
                    let viewAddUnit = achievementPhotoView.view(withId: "\(UploadTAG209)")
                    viewAddUnit?.frame = CGRect(x: (viewAddUnit?.frame.origin.x)!, y: CGFloat(imgSize + viewSpace), width: (viewAddUnit?.frame.size.width)!, height: CGFloat(controlsHeightView))
                    xPos += (imgSize + viewSpace)
                }
                
            } else {
                achievementPhotoView.frame = CGRect(x: (achievementPhotoView.frame.origin.x), y: CGFloat(internal_Space), width: (achievementPhotoView.frame.size.width), height: CGFloat(self.controlsHeight))
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
            internal_Space += Int(achievementPhotoView.frame.height) + self.common_margin + 20
//        printOn(pMessage: internal_Space)

     
//        let btnNext = CustomButton (frame: CGRect (x: 0, y: internal_Space , width:  NEXT_BUTTON_WIDTH, height: NEXT_BUTTON_HEIGHT))
//        btnNext.center = CGPoint (x: self.appUploadScrollView.center.x, y: btnNext.center.y)
//        btnNext.setTitle("Next", for: .normal)
////        btnNext.addTarget(self, action: #selector(onbtnNextPressed), for: .touchUpInside)
//        self.appUploadScrollView.addSubview(btnNext)
//
//        internal_Space +=  Int(btnNext.bounds.height) + common_margin + 20
        
        let  subscrollViewWidth:CGFloat = self.appUploadScrollView.frame.width
        let  subscrollViewHeight:CGFloat = CGFloat(internal_Space )
        
//        printOn(pMessage: subscrollViewHeight)
        
        self.appUploadScrollView.layoutIfNeeded()
        self.appUploadScrollView.isScrollEnabled = true
        self.appUploadScrollView.contentSize = CGSize (width: subscrollViewWidth , height: subscrollViewHeight)
        self.self.appUploadScrollView.delegate = self
        self.view.addSubview(self.appUploadScrollView)
        }
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
    
   
    
    
    //MARK:- SectionClick
      @objc  func onbtnSetionPressed(sender : UIButton) {
        
        global_Y_Position = TOP_HEADER_HEIGHT + 3 + common_margin + TOP_SUBHEADER_HEIGHT + ( STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding)
        printOn(pMessage: global_Y_Position)
        global_ADD_Y_Position =  global_Y_Position


        if sender.tag == 1{
            
            if   self.buttonView.isSelected == false{
                if tabVIEW_View != nil{
                    self.tabVIEW_View.removeFromSuperview()
                }
                self.initScrollView()
                self.buttonUpload.isSelected = false
                self.buttonView.isSelected = true
                self.buttonAdd.isSelected = false
                
                self.tabVIEW_View.isHidden = false
                self.tabAdd_View.isHidden = true
                self.appUploadScrollView.isHidden = true
            }
           
        }
        else if sender.tag == 2{

            if  self.buttonAdd.isSelected == false{
                if tabAdd_View != nil{
                    self.tabAdd_View.removeFromSuperview()
                }
                self.initScrollAdd()
                self.buttonUpload.isSelected = false
                self.buttonView.isSelected = false
                self.buttonAdd.isSelected = true
                self.buttonUpload.isEnabled = true
                self.buttonSave.isEnabled = true

                self.tabVIEW_View.isHidden = true
                self.tabAdd_View.isHidden = false
                self.appUploadScrollView.isHidden = true
            }
          
        }
        else{
            if  self.buttonUpload.isSelected == false{
                
                if appUploadScrollView != nil{
                    self.appUploadScrollView.removeFromSuperview()
                }
                self.tabVIEW_View.isHidden = true
                self.tabAdd_View.isHidden = true
                self.appUploadScrollView.isHidden = false
                
                self.initUploadDesign(ptag: 0)
                self.buttonUpload.isSelected = true
                self.buttonView.isSelected = false
                self.buttonAdd.isSelected = false
            }
           
        }
        
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
    
    func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    //MARK:- image / video delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            // For Saving Videos
            //            self.saveVideoOnLocalFolder(picker, didFinishPickingMediaWithInfo: info, videoURL: url)
            
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
            
            // check folder name
            let imageFolderPath =  filePath.appendingPathComponent("\(UNIT_IMAGES)")
            
            do {
                
                if !fileManager.fileExists(atPath: imageFolderPath.path) {
                    try fileManager.createDirectory(atPath: imageFolderPath.path, withIntermediateDirectories: true, attributes: nil)
                }
                
            } catch {
                NSLog("Couldn't create image directory")
            }
            
            
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
                    
                    
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                        
                        let imageSize = fileURL.fileSizeString
                        print(imageSize)
                        // print("size of image in KB: %f ", Double(imageSize) / 1000.0)
                        
                        let imageObj = GISDownloadedImage(pName: fileName, pSize: imageSize, pPath: fileURL.path)
                        imageObj.isFromTable = true
                        self.printOn(pMessage: picker.view.tag)
                        
                        let smallView = self.appUploadScrollView.view(withId:String(picker.view.tag)) as! GISImageDataTypeView
                        
                        smallView.imagesArray.append(imageObj)
                        self.appUploadScrollView.removeFromSuperview()
                        
                        //                        self.initUploadDesign(ptag: picker.view.tag)
                    }
                    
                }
            }
            
            
            
        }
        
    }
}


