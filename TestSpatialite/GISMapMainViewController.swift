//
//  GISMapMainViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 31/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class GISMapMainViewController: UIViewController {

    private var database:FMDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        database = FMDatabase(url: self.getDBPath())
        
        //  void *spatialite_conn;
        
        
        
        //let handle = initGEOS_r(notice, log_and_exit);
        
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        spatialite_init_geos();
        var spatialite_conn = spatialite_alloc_connection();
        spatialite_init_ex(database.getMySwiftDB(), spatialite_conn, 1);
        
          
        do {
          
            let rs = try database.executeQuery("select AsWKT(geom) from data_4", values: nil)
            while rs.next() {
                
                print(rs.resultDictionary)
                
                
            }
            
            let sqlQuery = "INSERT INTO data_4 (geometry, position, geom ,ggg) VALUES(\("'Point new'"), \("'-135789.862744 6833532.539844'"), \("GeomFromText('Point(-135789.862772297 6833532.539886988)', 3857)"), \("'dd'"))"
            
            print(sqlQuery)
            try database.executeUpdate(sqlQuery, values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
    }
    

    func getDBPath() -> URL {
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir: String = paths[0] as! String
        return URL(fileURLWithPath: documentsDir).appendingPathComponent("GISdb.sqlite")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
