//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class CustomLabel : UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textAlignment = .left
        // title color
        self.textColor = grayTextColor
        // font
        self.font = UIFont (name: APP_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)

    }
    
}
class DynamicLabel : UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textAlignment = .right
        // title color
        self.textColor = blueTextColor
        // font
        self.font = UIFont (name: APP_FONT_NAME, size: SUB_HEADER_LABEL_FONT_SIZE)
        
    }
    
}
class RightsideLabel : UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textAlignment = .right
        // title color
        self.textColor = UIColor.lightGray
        // font
        self.font = UIFont (name: TAB_FONT, size: 12)
        
    }
    
}
class tabLabel : UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textAlignment = .center
        // title color
        self.textColor = UIColor.white
        // font
        self.font = UIFont (name: APP_FONT_NAME, size: TAB_HEADER_LABEL_FONT_SIZE)
        
    }
    
}
