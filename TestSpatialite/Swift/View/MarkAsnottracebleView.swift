//
//  MarkAsnottracebleView.swift
//  TestSpatialite
//
//  Created by Gaurav on 19/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit

class MarkAsnottracebleView: UIView, UITextFieldDelegate, UITextViewDelegate {

    var lblAgencyName:UILabel!
    var lblReason:UILabel!
    
    var txtAgencyName:UITextField!
    var txtViewReason:UITextView!
    var delegate:Any?
    
    func initDesign() {
        
        self.backgroundColor = UIColor.white
        
        var yPos = 10
        let lblHeight = 30
        
        let lblTitle = UILabel(frame: CGRect(x: 20, y: yPos, width: Int(self.frame.size.width) - 40, height: lblHeight))
        lblTitle.text = "Mark As Not Traceable"
        lblTitle.font = UIFont(name: APP_FONT_NAME_BOLD, size: 17)
        lblTitle.textColor = SUBHEADER_BACKGROUND_COLOUR
        lblTitle.textAlignment = .center
        self.addSubview(lblTitle)
        
        yPos += 40
        
        self.lblAgencyName = UILabel(frame: CGRect(x: 20, y: yPos, width: Int(self.frame.size.width) - 40, height: lblHeight))
        self.lblAgencyName.text = "Agency Name *"
        lblAgencyName.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: 14)
        self.lblAgencyName.textColor = UIColor.lightGray
        self.addSubview(self.lblAgencyName)
        
        yPos += lblHeight
        
        self.txtAgencyName = CustomTextField(frame: CGRect(x: 20, y: yPos, width: Int(self.frame.size.width) - 40, height: 40))
        self.txtAgencyName.delegate = self
        self.txtAgencyName.returnKeyType = .done
        self.txtAgencyName.backgroundColor = UIColor.clear
        self.addSubview(self.txtAgencyName)
        
        yPos += 50
        

        self.lblReason = UILabel(frame: CGRect(x: 20, y: yPos, width: Int(self.frame.size.width) - 40, height: lblHeight))
        self.lblReason.text = "Reason *"
        self.lblReason.textColor = UIColor.lightGray
        lblReason.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: 14)
        self.addSubview(self.lblReason)
        
        yPos += lblHeight
        
        self.txtViewReason = CustomTextView(frame: CGRect(x: 20, y: yPos, width: Int(self.frame.size.width) - 40, height: 70))
        self.txtViewReason.backgroundColor = UIColor.clear
        self.txtViewReason.delegate = self
        self.txtViewReason.returnKeyType = .done
        self.addSubview(self.txtViewReason)
        
        yPos += 80
        
        let btnOkay = UIButton(frame: CGRect(x: 20, y: Int(self.frame.size.height) - 50, width: Int(self.frame.size.width) / 2 - 40, height: 50))
        btnOkay.setTitle("Okay", for: .normal)
        btnOkay.setTitleColor(UIColor.black, for: .normal)
        btnOkay.addTarget(self, action: #selector(btnOkayPressed(sender:)), for: .touchUpInside)
        self.addSubview(btnOkay)
        
        let btnCancel = UIButton(frame: CGRect(x: Int(self.frame.size.width) / 2 + 20, y: Int(self.frame.size.height) - 50, width: Int(self.frame.size.width) / 2 - 40, height: 50))
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.black, for: .normal)
        btnCancel.addTarget(self, action: #selector(btnCancelPressed(sender:)), for: .touchUpInside)
        self.addSubview(btnCancel)
    }
    
    @objc func btnOkayPressed(sender:UIButton) {
        
        let del = self.delegate as! KhadiStoreListViewController
        
        if self.txtAgencyName.text == "" {
            del.displayAlertMessage(pMessage:"Please enter agency name")
            return
        } else if self.txtViewReason.text == "" {
            del.displayAlertMessage(pMessage:"Please enter reason")
            return
        }
        
        
        del.markViewOkayPressed(sender: sender, pView: self, reason: self.txtViewReason.text! , agancyName:  self.txtAgencyName.text!)
    }
    
    @objc func btnCancelPressed(sender:UIButton) {
        let del = self.delegate as! KhadiStoreListViewController
        del.markViewCancelPressed(sender: sender, pView: self)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
         self.backgroundColor = UIColor.white
         // Shadow and Radius
         self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         //self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         self.layer.shadowOffset = .zero
         self.layer.shadowOpacity = 1.0
         self.layer.shadowRadius = 4.0
         self.layer.masksToBounds = false
         self.layer.cornerRadius = 4.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
