//
//  LayerInfoCollectionViewCell.swift
//  TestSpatialite
//
//  Created by Gaurav on 16/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class KhadiUnitCollectionViewCell: UICollectionViewCell {
    
    var cardView:UIView!

    var delegate:GISViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(dic: [String: String]) {
        
        var yPosition = 0
        
        let bcColor = UIColor.clear
        
        self.cardView = UIView(frame: CGRect(x: 5, y: yPosition, width: Int(self.frame.size.width) - 10, height: Int(self.frame.size.height) - 2))
        print(cardView.frame)
        self.cardView.backgroundColor = UIColor.white
        self.addSubview(cardView)
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: yPosition, width: Int(self.cardView.frame.size.width), height: 110))
        imgView.image = UIImage(named: dic["imageLink"]!)
        self.cardView.addSubview(imgView)
        
        yPosition += 110 + 15
        
        let labelTitle = UILabel(frame: CGRect(x: 20, y: yPosition, width: Int(self.cardView.frame.size.width) - 40, height: 20))
        labelTitle.font = UIFont(name: APP_FONT_NAME, size: 16)
        labelTitle.textAlignment = .left
        labelTitle.textColor = UIColor.black
        labelTitle.backgroundColor = bcColor
        labelTitle.text = "\(dic["title"]!)"
        self.cardView.addSubview(labelTitle)
        
        yPosition += 20
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: yPosition, width: Int(self.cardView.frame.size.width) - 40, height: 20))
        subTitle.font = UIFont(name: APP_FONT_NAME, size: 14)
        subTitle.textAlignment = .left
        subTitle.textColor = UIColor.lightGray
        subTitle.text = "\(dic["subTitle"]!)"
        self.cardView.addSubview(subTitle)
        
        yPosition += 20
        
        let isOpenLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: 50, height: 20))
        isOpenLabel.font = UIFont(name: APP_FONT_NAME, size: 14)
        isOpenLabel.textAlignment = .left
        isOpenLabel.backgroundColor = bcColor
        isOpenLabel.textColor = UIColor(red: 33.0/255.0, green: 186.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        isOpenLabel.text = "\(dic["openStatus"]!) |"
        self.cardView.addSubview(isOpenLabel)
        
        let isClosingTimeLabel = UILabel(frame: CGRect(x: 20 + 40 + 20, y: yPosition, width: 100, height: 20))
        isClosingTimeLabel.font = UIFont(name: APP_FONT_NAME, size: 14)
        isClosingTimeLabel.textAlignment = .left
        isClosingTimeLabel.textColor = UIColor.lightGray
        isClosingTimeLabel.backgroundColor = bcColor
        isClosingTimeLabel.text = "\(dic["closingTime"]!)"
        self.cardView.addSubview(isClosingTimeLabel)
        
        let btnCall = CustomButtonData(frame: CGRect(x: Int(self.cardView.frame.size.width) - 95, y: yPosition - 15, width: 45, height: 45))
        btnCall.setImage(UIImage(named: "phoneIconBlue"), for: .normal)
        btnCall.backgroundColor = bcColor
        btnCall.addTarget(self, action: #selector(btnCallPressed), for: .touchUpInside)
        self.cardView.addSubview(btnCall)
        
        let btnDirection = CustomButtonData(frame: CGRect(x: Int(self.cardView.frame.size.width) - 45, y: yPosition - 15, width: 45, height: 45))
        btnDirection.setImage(UIImage(named: "directionIconBlue"), for: .normal)
        btnDirection.backgroundColor = bcColor
        btnDirection.addTarget(self, action: #selector(btnDirectionPressed), for: .touchUpInside)
        self.cardView.addSubview(btnDirection)

        
    }
    
    @objc func btnCallPressed(sender:CustomButtonData) {
        
        print(sender.userData)
        
      //  self.delegate.clickedOnImage(sender: sender)
    }
    
    @objc func btnDirectionPressed(sender:CustomButtonData) {
        
        print(sender.userData)
        
       // self.delegate.clickedOnDocument(sender: sender)
    }
    
   
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
    }
    
}
