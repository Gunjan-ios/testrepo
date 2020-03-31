//
//  Layer_MultiMedia.swift
//  TestSpatialite
//
//  Created by Gaurav on 10/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class Layer_MultiMedia {
    
    var id: String?
    var type: String?
    var name: String?
    var layer_id: String?
    var row_id: String?
    
    
    init(pId:String?, pType:String?,pName: String?, pLayer_id:String?, pRow_id:String?){
        self.id = pId
        self.type = pType
        self.name = pName
        self.layer_id = pLayer_id
        self.row_id = pRow_id
    }
    
    //MARK:- database
    class func getImagesOrDocumentsData(pRowId:String, pLayerId:String,pDocumentType:String) -> Array<Layer_MultiMedia> {
        
        var imagesData:Array<Layer_MultiMedia> = []
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return imagesData
        }
        
        do {
            
            let rs = try database.executeQuery("select * from layer_multimedia Where media_type = '\(pDocumentType)' and row_id = \(pRowId) and layer_id = \(pLayerId)", values: nil)
            
            while rs.next() {
                
                let imgObj = Layer_MultiMedia(pId: rs.string(forColumn: "id"), pType:  rs.string(forColumn: "media_type"), pName:  rs.string(forColumn: "media_name"), pLayer_id:  rs.string(forColumn: "layer_id"), pRow_id:  rs.string(forColumn: "row_id"))
                
                imagesData.append(imgObj)
                
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return imagesData
    }
    
    // get data based on image name
    class func checkImagesOrDocumentsDataAvailabe(pImageName:String) -> Bool {
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return false
        }
        
        do {
            
            let rs = try database.executeQuery("select * from layer_multimedia Where media_name = '\(pImageName)'", values: nil)
            
            while rs.next() {
                
                database.close()
                return true

            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return false
    }
    
    // delete document / image
    class func deleteImageOrDocumentData(pImageName:String) {
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        do {
            
            try database.executeUpdate("delete from layer_multimedia Where media_name = '\(pImageName)'", values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()

    }
    
    class func delete_MultiMedias_Record(pLayerId:String) {
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        do {
            print("deleted \(pLayerId)")
            try database.executeUpdate("delete from layer_multimedia Where layer_id=\(pLayerId)", values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        
        database.close()
        
    }
    
    
    
}
