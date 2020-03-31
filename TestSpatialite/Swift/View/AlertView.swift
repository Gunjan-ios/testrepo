//
//  AlertView.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 11/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit

class AlertView: UIView {

    var alertDelegate:InspectionFormViewController!
    var previewAlertDelegate:PreviewViewController!
    var popUpView:UIView!

    
    func initDesign(title:String,btnTitle: String)  {
        
        self.popUpView = UIView (frame: CGRect (x: 0 , y: 15 , width: SCREEN_WIDTH - 80 , height: 250))
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.backgroundColor = .white
        self.addSubview(self.popUpView)
        
        var yPosition = 10
        
        let img = UIImageView (frame: CGRect (x:  0, y: yPosition, width: 100, height: 100))
//        img.backgroundColor = .red
        img.center = CGPoint (x: self.popUpView.center.x , y: img.center.y)
        print(img.frame)
        img.image = UIImage (named: "success")
        popUpView.addSubview(img)
        
        yPosition += Int(img.frame.height) 
        
        let lbl_title = UILabel (frame: CGRect (x: 0, y: yPosition, width: Int(popUpView.frame.width) , height: LABEL_HEIGHT))
        lbl_title.text = title
        lbl_title.textAlignment = .center
        lbl_title.textColor = blueTextColor
        lbl_title.font = UIFont (name: APP_FONT_NAME_MEDIUM, size: TEXTFIELD_FONT_SIZE)
        popUpView.addSubview(lbl_title)
        
          yPosition += Int(lbl_title.frame.height) + 20
        
        let btnNext = CustomButton (frame: CGRect (x: 40, y: yPosition , width:  NEXT_BUTTON_WIDTH + 20, height: NEXT_BUTTON_HEIGHT))
        btnNext.center = CGPoint (x: self.popUpView.center.x, y: btnNext.center.y)
//        btnNext.contentHorizontalAlignment = .center
        print(btnNext.frame)
        btnNext.setTitle(btnTitle, for: .normal)
        btnNext.addTarget(self, action: #selector(onbtnPreviewPressed), for: .touchUpInside)
        popUpView.addSubview(btnNext)
        self.popUpView.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)

    }
    
    @objc func onbtnPreviewPressed() {
        
        if let delegate = self.alertDelegate {
            delegate.onPreviewPressed()
        }
        if let delegate = self.previewAlertDelegate {
            delegate.onPreviewPressed()
        }
        
        
    }
    
    
    

}
