//
//  KhadiProductView.swift
//  TestSpatialite
//
//  Created by Gaurav on 05/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import Foundation

class KhadiProductView:UIView {
    
    fileprivate var myScrollview:UIScrollView!
    
    func initDesign(pOptions:[String]) {
        
        self.myScrollview = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 200))
        self.myScrollview.backgroundColor = UIColor.white
        self.addSubview(self.myScrollview)
        
        let btnWidth = self.frame.size.width / 3
        let btnHeight = 100
        var tagIndex = 1
        var xPos = 0
        var yPos = 0
        
        for obj in pOptions {
            
            let btn = CustomImageButton(frame: CGRect(x: xPos, y: yPos, width: Int(btnWidth), height: btnHeight))
            btn.tag = tagIndex
            btn.enableShadow = false
            btn.initDesign(pTitle: obj, pImage: UIImage(named: "1023134")!)
            btn.lblTitle.textColor = UIColor.lightGray
            btn.lblTitle.backgroundColor = UIColor.clear
            btn.imgLogo.frame = CGRect(x: (btn.frame.size.width/2) - 18, y: btn.imgLogo.frame.origin.y, width: 36, height: 36)
            btn.lblTitle.frame = CGRect(x: 0, y: Int(btn.imgLogo.frame.origin.y) + Int(btn.imgLogo.frame.size.height + 5), width: Int(btnWidth), height: 20)
            btn.lblTitle.font = UIFont(name: REGULAR_FONT_NAME, size: 15.0)
            btn.addTarget(self, action: #selector(btnPressed(sender:)), for: .touchUpInside)
            self.myScrollview.addSubview(btn)
            
            tagIndex+=1
            xPos += Int(btnWidth)
            
            if xPos >= Int(self.frame.width) {
                xPos = 0
                yPos += btnHeight
            }
        }
        
    }
    
    @objc func btnPressed(sender:UIButton) {
        
    }
    
}
