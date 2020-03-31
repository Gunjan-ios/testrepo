//
//  CustomOTPTypeView.swift
//  TestSpatialite
//
//  Created by Gaurav on 31/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class CustomOTPTypeView : UIView, DPOTPViewDelegate {

    private var labelTitle:UILabel! = nil
    var txtOTPView:DPOTPView!
    var delegateAppForm:KVICApplicationFormIndividualViewController?
     var delegateApp:InspectionFormViewController?
    var previewDelegateApp:PreviewViewController?

    let labelHeight = 25
    
    func initDesign(pName:String,pTag:Int,pNoOfBox:Int) {
        
        labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: Int(frame.size.width), height: labelHeight))
        labelTitle.textColor = labelTextColor
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: LABEL_FONT_SIZE)
        labelTitle.text = pName
        labelTitle.textAlignment = .left
        self.addSubview(labelTitle)
        
        txtOTPView = DPOTPView(frame: CGRect(x: 0, y: 25, width: Int(frame.size.width), height: 45))
        txtOTPView.count = pNoOfBox
        txtOTPView.spacing = 0
        txtOTPView.tag = pTag
        txtOTPView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        txtOTPView.dismissOnLastEntry = true
        txtOTPView.borderColorTextField = .lightGray
        txtOTPView.selectedBorderColorTextField = .lightGray
        txtOTPView.borderWidthTextField = 1
        txtOTPView.backGroundColorTextField = .clear
        txtOTPView.cornerRadiusTextField = 0
        txtOTPView.isCursorHidden = true
        txtOTPView.dpOTPViewDelegate = self
        //        txtOTPView.isSecureTextEntry = true
        //        txtOTPView.isBottomLineTextField = true
        //        txtOTPView.isCircleTextField = true
        self.addSubview(txtOTPView)
        
    }
    
    //MARK: DPOTPViewDelegate delegate
    func dpOTPViewAddText(_ text: String, at position: Int) {
        
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        
    }
    
    func dpOTPViewBecomeFirstResponder() {
//        if let delegate = self.delegateAppForm {
//            delegate.dpOTPViewBecomeFirstResponder_VC(self.txtOTPView)
//        }
//        if let delegate = self.delegateApp {
//            delegate.dpOTPViewBecomeFirstResponder_VC(self.txtOTPView)
//        }
        
    }
    
    func dpOTPViewResignFirstResponder() {
        
    }
    
}
