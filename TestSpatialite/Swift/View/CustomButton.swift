//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class CustomButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        
        // corner
        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 1
//        self.layer.borderColor = buttonBorderColor.cgColor
        
        // title color
        self.setTitleColor(UIColor.white, for: .normal)
        
        // font
        self.titleLabel?.font = UIFont(name:APP_FONT_NAME, size: BUTTON_FONT_SIZE)
        
        // shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2

  //          self.layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
