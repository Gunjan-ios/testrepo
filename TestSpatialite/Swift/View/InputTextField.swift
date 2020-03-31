//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class InputTextField : UITextField {
    
    let padding: CGFloat = 10
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
//        self.layer.cornerRadius = 5;
//        self.layer.borderColor = boxBorderColor
//        self.layer.borderWidth = 1
//        self.backgroundColor = UIColor.white
//
//        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
//        self.textColor = blueTextColor
        
        let border = CALayer()
       let lineWidth = CGFloat(0.3)
       border.borderColor = textFieldTextColor.cgColor
       border.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width:  self.frame.size.width, height: self.frame.size.height)
       border.borderWidth = lineWidth
       self.layer.addSublayer(border)
       self.layer.masksToBounds = true
       
       self.font = UIFont(name: APP_FONT_NAME, size: TEXTFIELD_FONT_SIZE)
        
    }
    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    }
    
}
