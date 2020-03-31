//
//  KVICApplicationFormIndividualViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

protocol GDL90_Enum  {
    var label: String { get }
}

enum INDIVIDUAL_FORM_FIELDS:Int, GDL90_Enum {
    
    case TITLE = 1
    case NAME_APPLICANT
    case DATE_OF_BIRTH
    case GENDER
    case SOCIAL_CATEGORY
    case SPEACIAL_CATEGORY
    case EDU_QUALIFICATION
    case STATE
    case DISTRICT
    case PINCODE
    case TALUKA
    case ADDRESS
    case MOBILE_NUMBER
    case EMAIL_ID
    case AADHAAR_CARD
    case PAN_CARD
    case UNIT_LOCATION
    case UNIT_ACTIVITY_TYPE
    case INDUSTRY_TYPE
    case PRODUCT_DETAILS
    case UNIT_SPONSORING_OFFICE
    case CAPITAL_EXPENDITURE
    case WORKING_CAPITAL
    case TOTAL_IN_RUPEES
    case TOTAL_NO_FULL_EMPLOYEE
    case TOTAL_NO_PART_TIME_EMPLOYEE
    case NO_MEN_EMPLOYEE
    case NO_WOMEN_EMPLOYEE
    case NO_DIFF_ABLE_EMPLOYEE
    case PREFERRED_FINANCE_BANK_NAME_1
    case IFSC_CODE_1
    case BRANCH_NAME_1
    case BRANCH_ADDRESS_1
    case PREFERRED_FINANCE_BANK_NAME_2
    case IFSC_CODE_2
    case BRANCH_NAME_2
    case BRANCH_ADDRESS_2
    
    var label: String {
        switch self {
        case .TITLE:
            return "Title"
        case .NAME_APPLICANT:
            return "Name Of Applicant"
        case .DATE_OF_BIRTH:
            return "Date Of Birth"
        case .GENDER:
            return "Gender"
        case .SOCIAL_CATEGORY:
            return "Social Category"
        case .SPEACIAL_CATEGORY:
            return "Speacial category"
        case .EDU_QUALIFICATION:
            return "Educational Qualification"
        case .STATE:
            return "State*"
        case .DISTRICT:
            return "District*"
        case .PINCODE:
            return "Pincode*"
        case .TALUKA:
            return "Taluka/Block*"
        case .ADDRESS:
            return "Address"
        case .MOBILE_NUMBER:
            return "Mobile Number*"
        case .EMAIL_ID:
            return "Email ID*"
        case .AADHAAR_CARD:
            return "Aadhaar Card Number"
        case .PAN_CARD:
            return "PAN Card Number"
        case .UNIT_LOCATION:
            return "Unit Location"
        case .UNIT_ACTIVITY_TYPE:
            return "Unit Activity Type"
        case .INDUSTRY_TYPE:
            return "Industry Type / Activity Name"
        case .PRODUCT_DETAILS:
            return "Product Details"
        case .UNIT_SPONSORING_OFFICE:
            return "Unit Sponsoring Office"
        case .CAPITAL_EXPENDITURE:
            return "Capital Expenditure (In Rupees)"
        case .WORKING_CAPITAL:
            return "Working Capital (In Rupees)"
        case .TOTAL_IN_RUPEES:
            return "Total (In Rupees)"
        case .TOTAL_NO_FULL_EMPLOYEE:
            return "Total Number of Full Time Employee"
        case .TOTAL_NO_PART_TIME_EMPLOYEE:
            return "Total Number of Part Time Employee"
        case .NO_MEN_EMPLOYEE:
            return "Number of Men Employee"
        case .NO_WOMEN_EMPLOYEE:
            return "Number of Women Employee"
        case .NO_DIFF_ABLE_EMPLOYEE:
            return "Number of Differently Able Employee"
        case .PREFERRED_FINANCE_BANK_NAME_1:
            return "Preferred Finance Bank Name"
        case .IFSC_CODE_1:
            return "IFSC Code"
        case .BRANCH_NAME_1:
            return "Branch Name"
        case .BRANCH_ADDRESS_1:
            return "Branch Address"
        case .PREFERRED_FINANCE_BANK_NAME_2:
            return "Preferred Finance Bank Name"
        case .IFSC_CODE_2:
            return "IFSC Code"
        case .BRANCH_NAME_2:
            return "Branch Name"
        case .BRANCH_ADDRESS_2:
            return "Branch Address"
        default:
            return "Reserved"
        }
    }
    
}

class KVICApplicationFormIndividualViewController: UIViewController {
    
    // Screen Controls
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonSave: UIButton!
    fileprivate var lblHeader:UILabel!
    fileprivate var global_Y_Position:Int! = 0
    fileprivate var appFormScrollView:UIScrollView!
    
    fileprivate let spacing = 20
    fileprivate let controlsHeight = 70
    
    private var imgCheckbox:UIImageView!
    private var agreeTermsButton:UIButton!
    private var submitButton:CustomButton!
    private var isTermCondition = false
    
    // Fields
    // personal details
    fileprivate var titleComboBox:CustomComboBoxView!
    fileprivate var nameApplicant:CustomInputFieldView!
    fileprivate var dateOfBirth:CustomComboBoxView!
    fileprivate var genderView:GenderView!
    fileprivate var socailCategoryView:CustomComboBoxView!
    fileprivate var specialCategoryView:CustomComboBoxView!
    fileprivate var eduQualificationView:CustomComboBoxView!
    fileprivate var stateView:CustomInputTextView!
    fileprivate var districtView:CustomInputTextView!
    fileprivate var pincodeView:CustomOTPTypeView!
    fileprivate var talukaView:CustomInputTextView!
    fileprivate var addressView:CustomInputTextView!
    fileprivate var mobileNoView:CustomOTPTypeView!
    fileprivate var emailIdView:CustomInputFieldView!
    fileprivate var aadhardcardNoView:CustomOTPTypeView!
    fileprivate var panCardView:CustomOTPTypeView!
    
    // proposed unit details
    fileprivate var unitLocView:CustomComboBoxView!
    fileprivate var unitActivityTypeView:CustomComboBoxView!
    fileprivate var industryTypeView : CustomComboBoxView!
    fileprivate var productDetailsView : CustomInputTextView!
    fileprivate var unitSponsoringOfficeView : CustomComboBoxView!
    fileprivate var capExpenditureView : CustomInputFieldView!
    fileprivate var workingCapitalView : CustomInputFieldView!
    fileprivate var total_Rupees_View : CustomInputFieldView!
    
    // empl generation details
    fileprivate var total_Full_Time_emp_View:CustomInputFieldView!
    fileprivate var total_Part_time_empl_View :CustomInputFieldView!
    fileprivate var no_men_emp_View : CustomInputFieldView!
    fileprivate var no_women_empl_View : CustomInputFieldView!
    fileprivate var no_of_diff_able_empl_View : CustomInputFieldView!
    
   // bank 1st preference
    fileprivate var bankNameView1: CustomComboBoxView!
    fileprivate var ifsc_Code_View1: CustomInputFieldView!
    fileprivate var branch_Name_View1: CustomInputFieldView!
    fileprivate var branch_Address_View1: CustomInputFieldView!
    
    // bank 2nd preference
    fileprivate var bankNameView2: CustomComboBoxView!
    fileprivate var ifsc_Code_View2: CustomInputFieldView!
    fileprivate var branch_Name_View2: CustomInputFieldView!
    fileprivate var branch_Address_View2: CustomInputFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        self.initHeader()
        self.initDesign()
    }
    
    private func initHeader() {
        
        headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding), width: Int(UIScreen.main.bounds.width), height: TOP_HEADER_HEIGHT));
        headerview.backgroundColor = HEADER_BACKGROUND_COLOUR
        self.view.addSubview(headerview)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect:CGRect(x: 0, y: TOP_HEADER_HEIGHT-1, width: SCREEN_WIDTH, height: 1), cornerRadius: 5).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        //shadowLayer.shadowOffset = .zero
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.shadowRadius = 2
        
        headerview.layer.insertSublayer(shadowLayer, below: nil) // also works
        
        self.buttonBack = UIButton(frame: CGRect(x: 5, y: 0, width: 80, height: TOP_HEADER_HEIGHT))
        self.buttonBack.setTitle("Cancel", for: .normal)
        self.buttonBack.setTitleColor(blueTextColor, for: .normal)
        let buttonBackSpace:CGFloat = 5.0
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonBack.addTarget(self, action: #selector(btnBackPressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        
        self.buttonSave = UIButton(frame: CGRect(x: SCREEN_WIDTH - 100, y: 0, width: 80, height: TOP_HEADER_HEIGHT))
        self.buttonSave.setTitle("Save", for: .normal)
        self.buttonSave.setTitleColor(blueTextColor, for: .normal)
        self.buttonSave.backgroundColor = UIColor.clear
        self.buttonSave.imageEdgeInsets = UIEdgeInsets(top: buttonBackSpace, left: 0, bottom: buttonBackSpace, right: buttonBackSpace+5);
        self.buttonSave.addTarget(self, action: #selector(btnSavePressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonSave)
        
        self.lblHeader = UILabel(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH - 100, height: TOP_HEADER_HEIGHT))
        self.lblHeader.textColor = blueTextColor
        self.lblHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        self.lblHeader.text = "Application Form"
        self.lblHeader.textAlignment = .center
        headerview.addSubview(self.lblHeader)
    }
    
    private func initDesign() {
        
        self.appFormScrollView = UIScrollView(frame: CGRect(x: X_PADDING, y:  TOP_HEADER_HEIGHT + STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding, width:SCREEN_WIDTH - (X_PADDING*2), height: SCREEN_HEIGHT - self.global_Y_Position))
        self.appFormScrollView.showsVerticalScrollIndicator = false
        self.appFormScrollView.backgroundColor = UIColor.clear
        self.view.addSubview(self.appFormScrollView)
        
        self.initPersonalDetails()
    }
    
    private func initPersonalDetails() {
        
        self.global_Y_Position = 30
        
        let labelSubHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        labelSubHeader.textColor = labelTextColor
        labelSubHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        labelSubHeader.text = "Personal Details"
        labelSubHeader.textAlignment = .center
        self.appFormScrollView.addSubview(labelSubHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        titleComboBox = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width: 100, height: controlsHeight))
        titleComboBox.initDesign(pName: INDIVIDUAL_FORM_FIELDS.TITLE.label, pTag: INDIVIDUAL_FORM_FIELDS.TITLE.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(titleComboBox)
        
        nameApplicant = CustomInputFieldView(frame: CGRect(x: 110, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) - 110, height: controlsHeight))
        nameApplicant.initDesign(pName: INDIVIDUAL_FORM_FIELDS.NAME_APPLICANT.label, pTag: INDIVIDUAL_FORM_FIELDS.NAME_APPLICANT.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(nameApplicant)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        dateOfBirth = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        dateOfBirth.initDesign(pName: INDIVIDUAL_FORM_FIELDS.DATE_OF_BIRTH.label, pTag: INDIVIDUAL_FORM_FIELDS.DATE_OF_BIRTH.rawValue, pOptions: [],pPlaceHolder: "Date")
        dateOfBirth.setDatePicker()
        self.appFormScrollView.addSubview(dateOfBirth)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        genderView = GenderView(frame:  CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        genderView.initDesign(pName: "Gender", pTag: 6, pOptions: ["Male","Female","Other"])
        self.appFormScrollView.addSubview(genderView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        socailCategoryView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        socailCategoryView.delegateAppForm = self
        socailCategoryView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.SOCIAL_CATEGORY.label, pTag: INDIVIDUAL_FORM_FIELDS.SOCIAL_CATEGORY.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(socailCategoryView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        specialCategoryView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        specialCategoryView.delegateAppForm = self
        specialCategoryView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.SPEACIAL_CATEGORY.label, pTag: INDIVIDUAL_FORM_FIELDS.SPEACIAL_CATEGORY.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(specialCategoryView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        eduQualificationView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        eduQualificationView.delegateAppForm = self
        eduQualificationView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.EDU_QUALIFICATION.label, pTag: INDIVIDUAL_FORM_FIELDS.EDU_QUALIFICATION.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(eduQualificationView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        let labelCommAddr = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: 150, height: 25))
        labelCommAddr.textColor = labelTextColor
        labelCommAddr.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelCommAddr.text = "Communication Address"
        labelCommAddr.textAlignment = .left
        self.appFormScrollView.addSubview(labelCommAddr)
        
        self.global_Y_Position += spacing
        
        stateView = CustomInputTextView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        stateView.delegateAppForm = self
//        stateView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.STATE.label, pTag: INDIVIDUAL_FORM_FIELDS.STATE.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(stateView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        districtView = CustomInputTextView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        districtView.delegateAppForm = self
//        districtView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.DISTRICT.label, pTag: INDIVIDUAL_FORM_FIELDS.DISTRICT.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(districtView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        pincodeView = CustomOTPTypeView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        pincodeView.delegateAppForm = self
        pincodeView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.PINCODE.label, pTag: INDIVIDUAL_FORM_FIELDS.PINCODE.rawValue,pNoOfBox: 6)
        self.appFormScrollView.addSubview(pincodeView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        talukaView = CustomInputTextView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        talukaView.delegateAppForm = self
        talukaView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.TALUKA.label, pTag: INDIVIDUAL_FORM_FIELDS.TALUKA.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(talukaView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        addressView = CustomInputTextView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: 125))
        addressView.delegateAppForm = self
        addressView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.ADDRESS.label, pTag: INDIVIDUAL_FORM_FIELDS.ADDRESS.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(addressView)
        
        self.global_Y_Position += (125 + spacing)
        
        let labelContactDetails = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: 150, height: 25))
        labelContactDetails.textColor = labelTextColor
        labelContactDetails.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelContactDetails.text = "Contact Details"
        labelContactDetails.textAlignment = .left
        self.appFormScrollView.addSubview(labelContactDetails)
        
        self.global_Y_Position += spacing
        
        mobileNoView = CustomOTPTypeView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        mobileNoView.delegateAppForm = self
        mobileNoView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.MOBILE_NUMBER.label, pTag: INDIVIDUAL_FORM_FIELDS.MOBILE_NUMBER.rawValue,pNoOfBox: 10)
        self.appFormScrollView.addSubview(mobileNoView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        emailIdView = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        emailIdView.delegateAppForm = self
        emailIdView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.EMAIL_ID.label, pTag: INDIVIDUAL_FORM_FIELDS.EMAIL_ID.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(emailIdView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        aadhardcardNoView = CustomOTPTypeView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        aadhardcardNoView.delegateAppForm = self
        aadhardcardNoView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.AADHAAR_CARD.label, pTag: INDIVIDUAL_FORM_FIELDS.AADHAAR_CARD.rawValue,pNoOfBox: 12)
        self.appFormScrollView.addSubview(aadhardcardNoView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        panCardView = CustomOTPTypeView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        panCardView.delegateAppForm = self
        panCardView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.PAN_CARD.label, pTag: INDIVIDUAL_FORM_FIELDS.PAN_CARD.rawValue,pNoOfBox: 10)
        self.appFormScrollView.addSubview(panCardView)
        
        self.global_Y_Position += (controlsHeight + spacing) + 30
        
        self.initProposedUnitDetails()
    }
    
    private func initProposedUnitDetails() {
        
        // =============== Proposed Unit Details ============================= //
        
        let labelProposedHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        labelProposedHeader.textColor = labelTextColor
        labelProposedHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        labelProposedHeader.text = "Proposed Unit Details"
        labelProposedHeader.textAlignment = .center
        self.appFormScrollView.addSubview(labelProposedHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        unitLocView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        unitLocView.delegateAppForm = self
        unitLocView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.UNIT_LOCATION.label, pTag: INDIVIDUAL_FORM_FIELDS.UNIT_LOCATION.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(unitLocView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        unitActivityTypeView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        unitActivityTypeView.delegateAppForm = self
        unitActivityTypeView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.UNIT_ACTIVITY_TYPE.label, pTag: INDIVIDUAL_FORM_FIELDS.UNIT_ACTIVITY_TYPE.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(unitActivityTypeView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        industryTypeView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        industryTypeView.delegateAppForm = self
        industryTypeView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.INDUSTRY_TYPE.label, pTag: INDIVIDUAL_FORM_FIELDS.INDUSTRY_TYPE.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(industryTypeView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        productDetailsView = CustomInputTextView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: 125))
        productDetailsView.delegateAppForm = self
        productDetailsView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.PRODUCT_DETAILS.label, pTag: INDIVIDUAL_FORM_FIELDS.PRODUCT_DETAILS.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(productDetailsView)
        
        self.global_Y_Position += (125 + spacing)
        
        unitSponsoringOfficeView = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        unitSponsoringOfficeView.delegateAppForm = self
        unitSponsoringOfficeView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.UNIT_SPONSORING_OFFICE.label, pTag: INDIVIDUAL_FORM_FIELDS.UNIT_SPONSORING_OFFICE.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(unitSponsoringOfficeView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        let labelProjectCost = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: 150, height: 25))
        labelProjectCost.textColor = labelTextColor
        labelProjectCost.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelProjectCost.text = "Project Cost"
        labelProjectCost.textAlignment = .left
        self.appFormScrollView.addSubview(labelProjectCost)
        
        self.global_Y_Position += spacing
        
        capExpenditureView = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        capExpenditureView.delegateAppForm = self
        capExpenditureView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.CAPITAL_EXPENDITURE.label, pTag: INDIVIDUAL_FORM_FIELDS.CAPITAL_EXPENDITURE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(capExpenditureView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        workingCapitalView = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        workingCapitalView.delegateAppForm = self
        workingCapitalView.initDesign(pName: INDIVIDUAL_FORM_FIELDS.WORKING_CAPITAL.label, pTag: INDIVIDUAL_FORM_FIELDS.WORKING_CAPITAL.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(workingCapitalView)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        total_Rupees_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        total_Rupees_View.delegateAppForm = self
        total_Rupees_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.TOTAL_IN_RUPEES.label, pTag: INDIVIDUAL_FORM_FIELDS.TOTAL_IN_RUPEES.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(total_Rupees_View)
        
        self.global_Y_Position += (controlsHeight + spacing + 30)
        
        
        self.initEmploymentGenerationDetails()
        
    }
    
    private func initEmploymentGenerationDetails() {
        
        let labelEmplGenDetailsHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        labelEmplGenDetailsHeader.textColor = labelTextColor
        labelEmplGenDetailsHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        labelEmplGenDetailsHeader.text = "Employment Generation Details"
        labelEmplGenDetailsHeader.textAlignment = .center
        self.appFormScrollView.addSubview(labelEmplGenDetailsHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        total_Full_Time_emp_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        total_Full_Time_emp_View.delegateAppForm = self
        total_Full_Time_emp_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.TOTAL_NO_FULL_EMPLOYEE.label, pTag: INDIVIDUAL_FORM_FIELDS.TOTAL_NO_FULL_EMPLOYEE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(total_Full_Time_emp_View)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        total_Part_time_empl_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        total_Part_time_empl_View.delegateAppForm = self
        total_Part_time_empl_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.TOTAL_NO_PART_TIME_EMPLOYEE.label, pTag: INDIVIDUAL_FORM_FIELDS.TOTAL_NO_PART_TIME_EMPLOYEE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(total_Part_time_empl_View)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        no_men_emp_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        no_men_emp_View.delegateAppForm = self
        no_men_emp_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.NO_MEN_EMPLOYEE.label, pTag: INDIVIDUAL_FORM_FIELDS.NO_MEN_EMPLOYEE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(no_men_emp_View)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        no_women_empl_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        no_women_empl_View.delegateAppForm = self
        no_women_empl_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.NO_WOMEN_EMPLOYEE.label, pTag: INDIVIDUAL_FORM_FIELDS.NO_MEN_EMPLOYEE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(no_women_empl_View)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        no_of_diff_able_empl_View = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        no_of_diff_able_empl_View.delegateAppForm = self
        no_of_diff_able_empl_View.initDesign(pName: INDIVIDUAL_FORM_FIELDS.NO_DIFF_ABLE_EMPLOYEE.label, pTag: INDIVIDUAL_FORM_FIELDS.NO_DIFF_ABLE_EMPLOYEE.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(no_of_diff_able_empl_View)
        
        self.global_Y_Position += (controlsHeight + spacing + 30)
        
        
       self.initFinanceBankDetailsPreference1()
       
    }
    
    private func initFinanceBankDetailsPreference1() {
        
        let labelFinanceBankdetailsHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        labelFinanceBankdetailsHeader.textColor = labelTextColor
        labelFinanceBankdetailsHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: HEADER_LABEL_FONT_SIZE)
        labelFinanceBankdetailsHeader.text = "Financing Bank Details"
        labelFinanceBankdetailsHeader.textAlignment = .center
        self.appFormScrollView.addSubview(labelFinanceBankdetailsHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        let label1stPreferenceHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        label1stPreferenceHeader.textColor = labelTextColor
        label1stPreferenceHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)
        label1stPreferenceHeader.text = "1st Preference"
        label1stPreferenceHeader.textAlignment = .center
        self.appFormScrollView.addSubview(label1stPreferenceHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        bankNameView1 = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        bankNameView1.delegateAppForm = self
        bankNameView1.initDesign(pName: INDIVIDUAL_FORM_FIELDS.PREFERRED_FINANCE_BANK_NAME_1.label, pTag: INDIVIDUAL_FORM_FIELDS.PREFERRED_FINANCE_BANK_NAME_1.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(bankNameView1)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        ifsc_Code_View1 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        ifsc_Code_View1.delegateAppForm = self
        ifsc_Code_View1.initDesign(pName: INDIVIDUAL_FORM_FIELDS.IFSC_CODE_1.label, pTag: INDIVIDUAL_FORM_FIELDS.IFSC_CODE_1.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(ifsc_Code_View1)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        branch_Name_View1 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        branch_Name_View1.delegateAppForm = self
        branch_Name_View1.initDesign(pName: INDIVIDUAL_FORM_FIELDS.BRANCH_NAME_1.label, pTag: INDIVIDUAL_FORM_FIELDS.BRANCH_NAME_1.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(branch_Name_View1)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        branch_Address_View1 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        branch_Address_View1.delegateAppForm = self
        branch_Address_View1.initDesign(pName: INDIVIDUAL_FORM_FIELDS.BRANCH_ADDRESS_1.label, pTag: INDIVIDUAL_FORM_FIELDS.BRANCH_ADDRESS_1.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(branch_Address_View1)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        self.initFinanceBankDetailsPreference2()
        
    }
    
    private func initFinanceBankDetailsPreference2() {
        
        let label1stPreferenceHeader = UILabel(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) , height: 30))
        label1stPreferenceHeader.textColor = labelTextColor
        label1stPreferenceHeader.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)
        label1stPreferenceHeader.text = "2nd Preference"
        label1stPreferenceHeader.textAlignment = .center
        self.appFormScrollView.addSubview(label1stPreferenceHeader)
        
        self.global_Y_Position += (10 + spacing)
        
        bankNameView2 = CustomComboBoxView(frame: CGRect(x: 0, y: self.global_Y_Position, width:  Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        bankNameView2.delegateAppForm = self
        bankNameView2.initDesign(pName: INDIVIDUAL_FORM_FIELDS.PREFERRED_FINANCE_BANK_NAME_2.label, pTag: INDIVIDUAL_FORM_FIELDS.PREFERRED_FINANCE_BANK_NAME_2.rawValue, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        self.appFormScrollView.addSubview(bankNameView2)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        ifsc_Code_View2 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        ifsc_Code_View2.delegateAppForm = self
        ifsc_Code_View2.initDesign(pName: INDIVIDUAL_FORM_FIELDS.IFSC_CODE_2.label, pTag: INDIVIDUAL_FORM_FIELDS.IFSC_CODE_2.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(ifsc_Code_View2)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        branch_Name_View2 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        branch_Name_View2.delegateAppForm = self
        branch_Name_View2.initDesign(pName: INDIVIDUAL_FORM_FIELDS.BRANCH_NAME_2.label, pTag: INDIVIDUAL_FORM_FIELDS.BRANCH_NAME_2.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(branch_Name_View2)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        branch_Address_View2 = CustomInputFieldView(frame: CGRect(x: 0, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width), height: controlsHeight))
        branch_Address_View2.delegateAppForm = self
        branch_Address_View2.initDesign(pName: INDIVIDUAL_FORM_FIELDS.BRANCH_ADDRESS_2.label, pTag: INDIVIDUAL_FORM_FIELDS.BRANCH_ADDRESS_2.rawValue,pPlaceHolder: "")
        self.appFormScrollView.addSubview(branch_Address_View2)
        
        self.global_Y_Position += (controlsHeight + spacing)
        
        imgCheckbox = UIImageView(frame: CGRect(x: 0, y: self.global_Y_Position + 5, width: 20, height: 20))
        imgCheckbox.image = UIImage(named: "deselectedCheckbox")
        self.appFormScrollView.addSubview(imgCheckbox)
        
        let checkBoxBtn = UIButton(frame: CGRect(x: 0, y: self.global_Y_Position, width: 30, height: CUSTOM_TEXTFIELD_HEIGHT))
        checkBoxBtn.addTarget(self, action: #selector(termsConditionPressed(sender:)), for: .touchUpInside)
        self.appFormScrollView.addSubview(checkBoxBtn)
        
        self.agreeTermsButton = UIButton(frame: CGRect(x: 30, y: self.global_Y_Position, width: Int(self.appFormScrollView.frame.size.width) - 50, height: CUSTOM_TEXTFIELD_HEIGHT))
        self.agreeTermsButton.backgroundColor = UIColor.clear
        self.agreeTermsButton.setTitleColor(UIColor.gray, for: .normal)
        self.agreeTermsButton.contentHorizontalAlignment = .left
        self.agreeTermsButton.titleLabel?.font = UIFont(name: APP_FONT_NAME, size: SMALL_BUTTON_FONT_SIZE)
        self.agreeTermsButton.titleLabel?.numberOfLines = 2
        self.agreeTermsButton.setTitle("I nearby declare that all the information filled by me is correct.", for: .normal)
        self.agreeTermsButton.addTarget(self, action: #selector(termsConditionPressed(sender:)), for: .touchUpInside)
        self.appFormScrollView.addSubview(self.agreeTermsButton)
        
        self.global_Y_Position += CUSTOM_TEXTFIELD_HEIGHT + 20
        
        self.submitButton = CustomButton(frame: CGRect(x: 0, y: self.global_Y_Position, width: 150, height: CUSTOM_BUTTON_HEIGHT))
        self.submitButton.backgroundColor = UIColor.green
        self.submitButton.setTitleColor(UIColor.gray, for: .normal)
        self.submitButton.setTitle("SUBMIT", for: .normal)
        self.submitButton.center = CGPoint(x:Int(self.appFormScrollView.center.x) - X_PADDING, y: Int(self.submitButton.center.y))
        self.submitButton.addTarget(self, action: #selector(submitPressed(sender:)), for: .touchUpInside)
        self.appFormScrollView.addSubview(self.submitButton)
        //self.appFormScrollView.backgroundColor = UIColor.blue
        self.printOn(pMessage: Int(self.appFormScrollView.center.x) - X_PADDING)
        self.printOn(pMessage: SCREEN_WIDTH)
        
        self.appFormScrollView.contentSize = CGSize(width:  Int(self.appFormScrollView.frame.size.width), height: self.global_Y_Position + 300)
        
    }
    
    
    
    //MARK: action
    @objc func btnBackPressed(sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSavePressed(sender: UIButton) {
        
        
    }
    
    @objc func termsConditionPressed(sender:UIButton) {
        
        if (self.isTermCondition == true) {
            
            self.imgCheckbox.image = UIImage(named: "deselectedCheckbox")
            self.isTermCondition = false
            
        } else {
            
            self.imgCheckbox.image = UIImage(named: "selectedCheckboxBlue")
            self.isTermCondition = true
            
        }
        
        
    }
    
    @objc func submitPressed(sender:UIButton) {
        
       self.printOn(pMessage: self.titleComboBox.txtField.text!)
       self.printOn(pMessage: self.dateOfBirth.txtField.text!)
       self.printOn(pMessage: self.socailCategoryView.txtField.text!)
       self.printOn(pMessage: self.addressView.txtField.text!)
        
    }
    
    //MARK:- textfield del
    func textFieldDidBeginEditing_VC(_ textField: UITextField) {
        
        self.printOn(pMessage: (SCREEN_HEIGHT - Int((textField.frame.origin.y + 300))))
        self.printOn(pMessage: SCREEN_HEIGHT)
        self.printOn(pMessage: textField.frame.origin.y)
   
        let view = textField.superview
        self.printOn(pMessage: view!.frame.origin.y)
        
        if (SCREEN_HEIGHT - Int((view!.frame.origin.y))) < 400 {
            self.appFormScrollView.setContentOffset(CGPoint(x: 0, y: view!.frame.origin.y - 200), animated: true)
        }
    }
    
    //MARK:- textview del
    func textViewDidBeginEditing_VC(_ textView: UITextView) {
        print((SCREEN_HEIGHT - Int((textView.frame.origin.y + 300))))
        print(SCREEN_HEIGHT)
        print(textView.frame.origin.y)
        
        let view = textView.superview
        print(view!.frame.origin.y)
        
        if (SCREEN_HEIGHT - Int((view!.frame.origin.y))) < 400 {
            self.appFormScrollView.setContentOffset(CGPoint(x: 0, y: view!.frame.origin.y - 200), animated: true)
        }
    }
    
    //MARK:- otpview  del
    func dpOTPViewBecomeFirstResponder_VC(_ optView: DPOTPView) {
        print((SCREEN_HEIGHT - Int((optView.frame.origin.y + 300))))
        print(SCREEN_HEIGHT)
        print(optView.frame.origin.y)
        
        let view = optView.superview
        print(view!.frame.origin.y)
        
        if (SCREEN_HEIGHT - Int((view!.frame.origin.y))) < 400 {
            self.appFormScrollView.setContentOffset(CGPoint(x: 0, y: view!.frame.origin.y - 200), animated: true)
        }
    }
}

extension UIViewController {
    
    func printOn(pMessage:Any) {
        print("Printed Below:")
        print(pMessage)
    }
    
}
