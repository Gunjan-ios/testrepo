//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class CustomImageButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    var enableShadow = true
    var lblTitle:UILabel!
    var imgLogo:UIImageView!
    
    func initDesign(pTitle:String, pImage:UIImage) {
        
        imgLogo = UIImageView(frame: CGRect(x: (self.frame.size.width/2) - 17, y: 15, width: 34, height: 34))
        imgLogo.image = pImage
        self.addSubview(imgLogo)
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: 65, width: self.frame.size.width, height: 20))
        lblTitle.textColor = blueTextColor
        lblTitle.font = UIFont(name: REGULAR_FONT_NAME, size: 17.0)
        lblTitle.text = pTitle
        lblTitle.textAlignment = .center
        self.addSubview(lblTitle)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableShadow == true {
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
    }
    
}
