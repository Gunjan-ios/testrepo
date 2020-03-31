//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class CustomButtonImageOrDocument : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    var imgIcon:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgIcon = UIImageView(frame: CGRect(x: self.bounds.size.width - 34, y: 7, width: 24, height: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(imgIcon)
        
        self.backgroundColor = .clear
        
        // corner
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = buttonBorderColor.cgColor
        
        // title color
        self.setTitleColor(buttonTextColor, for: .normal)
        
        // font
        self.titleLabel?.font = UIFont(name:APP_FONT_NAME, size: BUTTON_FONT_SIZE)
        
        // shadow
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
//            shadowLayer.fillColor = UIColor.white.cgColor
//
//            shadowLayer.shadowColor = UIColor.darkGray.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//            shadowLayer.shadowOpacity = 0.8
//            shadowLayer.shadowRadius = 2
//
//            //layer.insertSublayer(shadowLayer, at: 0)
//            self.layer.insertSublayer(shadowLayer, below: nil) // also works
//        }
    }
    
       
}
