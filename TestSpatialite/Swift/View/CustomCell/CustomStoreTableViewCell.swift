//
//  DataTypeTableViewCell.swift
//  TestSpatialite
//
//  Created by Gaurav on 21/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomStoreTableViewCell: UITableViewCell {
   
    var viewCart : UIView = {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            view.backgroundColor = UIColor.white
           return view
           
       }()
    
    var lblStoreName : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont(name: APP_FONT_NAME_MEDIUM, size: 15)
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        label.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return label
        
    }()

    var btnCall : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "phoneIconBlue"), for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor =  UIColor.lightGray.cgColor
        return btn
    }()
    
    var btnVeriFyAddress : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Address Changed", for: .normal)
        btn.backgroundColor =  UIColor.white
        btn.contentHorizontalAlignment = .center
        btn.setImage(UIImage(named: "addressChnageBlue"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10);
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        btn.titleLabel?.font = UIFont(name: APP_FONT_NAME_BOLD, size: 10)
        btn.setTitleColor(blueTextColor, for: .normal)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    var btnDirection : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "directionIconBlue"), for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    var lblStoreAddress : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont(name: APP_FONT_NAME, size: 15)
        label.textAlignment = .left
        label.textColor = UIColor(red: 25.0/255.0, green: 118/255.0, blue: 210.0/255.0, alpha: 1.0)
        label.numberOfLines = 3
        return label
        
    }()

    var btnMarkAsNottraceble : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Not Traceable", for: .normal)
        btn.setImage(UIImage(named: "markannottracebleBlue"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10);
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        btn.titleLabel?.font = UIFont(name: APP_FONT_NAME_BOLD, size: 10)
        btn.setTitleColor(blueTextColor, for: .normal)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    var btnForm : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "formIconBlue"), for: .normal)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white

        self.viewCart = UIView(frame: CGRect(x: 5, y: 5, width: SCREEN_WIDTH - 10, height: 155))
        self.viewCart.backgroundColor = UIColor.white
        self.addSubview(self.viewCart)

        let btnSize = 40
        let btnbottomSpace =  Int(self.viewCart.frame.size.height) - btnSize
        let btnwidth = Int(self.viewCart.frame.size.width) - (btnSize*2)
        let eqaulSpace =  btnwidth/2
        
        self.lblStoreName.frame = CGRect(x: 0, y: 0, width: self.viewCart.frame.size.width , height: 30)
        self.lblStoreAddress.frame = CGRect(x: 10, y: 40, width:self.viewCart.frame.size.width - 20, height:60)
        self.btnCall.frame = CGRect(x: Int(self.viewCart.frame.size.width) - (btnSize*2), y: btnbottomSpace, width: btnSize, height: btnSize)
        self.btnDirection.frame = CGRect(x: Int(self.viewCart.frame.size.width) - btnSize, y:btnbottomSpace , width: btnSize, height: btnSize)
        self.btnVeriFyAddress.frame = CGRect(x: 0, y: btnbottomSpace, width:eqaulSpace, height:btnSize)
        self.btnMarkAsNottraceble.frame = CGRect(x: Int(self.btnVeriFyAddress.frame.maxX), y: btnbottomSpace, width:eqaulSpace + 1, height:btnSize)
        
//        self.btnForm.frame = CGRect(x: 5, y: Int(self.viewCart.frame.size.height) - btnSize, width:btnSize, height:btnSize)
        
        self.viewCart.addSubview(lblStoreName)
        self.viewCart.addSubview(btnCall)
        self.viewCart.addSubview(btnDirection)
        self.viewCart.addSubview(lblStoreAddress)
        self.viewCart.addSubview(btnVeriFyAddress)
        self.viewCart.addSubview(btnMarkAsNottraceble)
        self.viewCart.addSubview(btnForm)
        
        self.addSubview(self.viewCart)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       self.viewCart.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
       //self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       self.viewCart.layer.shadowOffset = .zero
       self.viewCart.layer.shadowOpacity = 1.0
       self.viewCart.layer.shadowRadius = 4.0
       self.viewCart.layer.masksToBounds = false
       self.viewCart.layer.cornerRadius = 4.0
        
       self.viewCart.layer.borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor
       self.viewCart.layer.borderWidth = 0.5

        
        let radius = 5
               let corner:UIRectCorner = [.topLeft, .topRight]
        let path = UIBezierPath(roundedRect: self.lblStoreName.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.lblStoreName.layer.mask = mask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}
