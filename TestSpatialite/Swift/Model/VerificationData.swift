//
//  VerificationData.swift
//  TestSpatialite
//
//  Created by Gunjan Raval on 19/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit

class imageData: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(appID, forKey: "appId")
        aCoder.encode(imageTag, forKey: "imageTag")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(img_videoData, forKey: "img_videoData")
        aCoder.encode(name, forKey: "attachment_name")
        aCoder.encode(uploadedID, forKey: "uploadedID")
        aCoder.encode(isUploaded, forKey: "isUploaded")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let attachment_name = aDecoder.decodeObject(forKey: "attachment_name") as! String
        let uploadedID = aDecoder.decodeObject(forKey: "uploadedID") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let imageTag = aDecoder.decodeObject(forKey: "imageTag") as! Int
        let latitude = aDecoder.decodeObject(forKey: "latitude") as! String
        let longitude = aDecoder.decodeObject(forKey: "longitude") as! String
        let img_videoData = aDecoder.decodeObject(forKey: "img_videoData") as! Data
        let appID = aDecoder.decodeObject(forKey: "appId") as! String
        let isUploaded = aDecoder.decodeObject(forKey: "isUploaded") as! Bool
        
        print(appID)
        
        self.init(name: name, type: type, imageTag: imageTag,latitude : latitude ,longitude:longitude ,img_videoData:img_videoData,attachment_name:attachment_name,appID:appID,uploadedID:uploadedID,isUploaded:isUploaded)
    }

    init(name: String?, type: String?, imageTag: Int?,latitude : String?,longitude:String?, img_videoData : Data?,attachment_name:String? , appID:String?, uploadedID:String?, isUploaded: Bool?) {
        self.name = name
        self.type = type
        self.appID = appID
        self.imageTag = imageTag
        self.latitude = latitude
        self.longitude = longitude
        self.img_videoData = img_videoData
        self.attachment_name = attachment_name
        self.uploadedID = uploadedID
        self.isUploaded = isUploaded
    }
    
    var name : String!
    var type : String!
    var imageTag : Int!
    var latitude : String!
    var longitude : String!
    var img_videoData:Data?
    var attachment_name : String!
    var appID : String!
    var uploadedID : String!
    var isUploaded : Bool!

    
}
