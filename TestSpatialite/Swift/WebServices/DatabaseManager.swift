//
//  GISWebServicesManager.swift
//  TestSpatialite
//
//  Created by Gaurav on 20/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class DatabaseManager {
    
    class func insertPhoto(pPhotoName:String,pType:String) {
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        do {
            
            // insert rec
            let sqlLayerInsertQuery = "INSERT INTO Photos (name, type) VALUES(?,?)"
            print(sqlLayerInsertQuery)
            try database.executeUpdate(sqlLayerInsertQuery, values: [pPhotoName, pType])
            
            // insert rec
            let lastInsertedRowId = database.lastInsertRowId
            print("last inserted \(lastInsertedRowId)")
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()

    }
    
    
}

