//
//  PendingKhadiStoresListTableViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 06/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import SwiftyJSON

class PendingKhadiStoresListTableViewController: UITableViewController {
    
    var inspctionForm:InspectionFormViewController!
    var arrayStoreLists:[JSON]!
    var vcDelegate:KhadiStoreListViewController!
    var arrAddressChanged:[String]?
    var arrNotTraceble:[String]?

    var type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrAddressChanged = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORE_ADDRESS_CHANGED_ARRAY) as? [String]
          self.arrNotTraceble = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORE_NOT_TRACEBLE_ARRAY) as? [String]
        
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.frame = CGRect (x: 0, y: CGFloat(SingletonClassSwift.sharedInstance.iPhone_X_Bottom_Padding) , width: self.tableView.frame.width, height: self.tableView.frame.height)
        
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(CustomStoreTableViewCell.self, forCellReuseIdentifier: "CustomStoreTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.arrNotTraceble = SingletonClassSwift.sharedInstance.getDataForKey(strKey: STORE_NOT_TRACEBLE_ARRAY) as? [String]
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    if self.type == "Visited" || self.type == "NotTraceable" {
        return 125
        }
        return 165
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayStoreLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomStoreTableViewCell.self)) as! CustomStoreTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        
        if self.type == "Visited" || self.type == "NotTraceable" {
            cell.isUserInteractionEnabled = false
            cell.viewCart.frame = CGRect(x: 5, y: 5, width: SCREEN_WIDTH - 10, height: 115)
            cell.btnMarkAsNottraceble.isHidden  = true
            cell.btnCall.isHidden  = true
            cell.btnDirection.isHidden  = true
            cell.btnVeriFyAddress.isHidden  = true
        }else{
            cell.viewCart.frame = CGRect(x: 5, y: 5, width: SCREEN_WIDTH - 10, height: 155)
            cell.btnMarkAsNottraceble.isHidden  = false
            cell.btnCall.isHidden  = false
            cell.btnDirection.isHidden  = false
            cell.btnVeriFyAddress.isHidden  = false
        }
        
        let dic = self.arrayStoreLists[indexPath.row]
        
        cell.lblStoreName.text = dic["app_name"].string
        cell.lblStoreAddress.text = dic["unit_address"].string
        
        cell.btnVeriFyAddress.tag = indexPath.row
        cell.btnCall.tag = indexPath.row
        cell.btnDirection.tag = indexPath.row
        cell.btnMarkAsNottraceble.tag = indexPath.row
        cell.btnForm.tag = indexPath.row
        
        self.printOn(pMessage: self.arrAddressChanged as Any)
        
        if self.arrAddressChanged != nil {
            self.printOn(pMessage: dic["app_id"].stringValue)
            
            if (self.arrAddressChanged?.contains(dic["app_id"].stringValue))! {
                cell.btnVeriFyAddress.isUserInteractionEnabled = false
                cell.btnVeriFyAddress.setImage(UIImage(named: "addressChnageGreen"), for: .normal)
            } else {
                cell.btnVeriFyAddress.isUserInteractionEnabled = true
                cell.btnVeriFyAddress.setImage(UIImage(named: "addressChnageBlue"), for: .normal)
            }
        }
        if self.type == "NotTraceable" {
            cell.btnMarkAsNottraceble.setImage(UIImage(named: "markannottracebleRed"), for: .normal)
        if self.arrNotTraceble != nil {

            self.printOn(pMessage: dic["app_id"].stringValue)
            if (self.arrNotTraceble?.contains(dic["app_id"].stringValue))! {
                cell.btnMarkAsNottraceble.isUserInteractionEnabled = false
                cell.btnMarkAsNottraceble.setImage(UIImage(named: "markannottracebleRed"), for: .normal)
            } else {
                cell.btnMarkAsNottraceble.isUserInteractionEnabled = true
                cell.btnMarkAsNottraceble.setImage(UIImage(named: "markannottracebleBlue"), for: .normal)
            }
        }
        }
        
        cell.btnVeriFyAddress.addTarget(self, action: #selector(didVerifyAddressPressed(sender:)), for: .touchUpInside)
        cell.btnCall.addTarget(self, action: #selector(callBtnPressed(id:)), for: .touchUpInside)
        cell.btnDirection.addTarget(self, action: #selector(directionBtnPressed(id:)), for: .touchUpInside)
        cell.btnMarkAsNottraceble.addTarget(self, action: #selector(markasNotTracebleAddressPressed(id:)), for: .touchUpInside)
//        cell.btnForm.addTarget(self, action: #selector(formBtnPressed(id:)), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SingletonClassSwift.sharedInstance.setData(strData: false, strKey: INSPECTION_EDIT_MODE)
        SingletonClassSwift.sharedInstance.is_address_changed = false
        SingletonClassSwift.sharedInstance.is_location_changed = false
        SingletonClassSwift.sharedInstance.changed_location_latitude = 0.0
        SingletonClassSwift.sharedInstance.changed_location_longitude = 0.0
        let vc = InspectionFormViewController()
        vc.storeViewData = self.arrayStoreLists[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @objc func didVerifyAddressPressed(sender:UIButton) {
        
        let alert = UIAlertController(title: "Message", message: "Is store address changed ?", preferredStyle:
                  .alert)
              
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler:{ (UIAlertAction)in
                 
            let dic = self.arrayStoreLists[sender.tag]
                   let appId = dic["app_id"]
                   if self.arrAddressChanged == nil {
                       var arrAppIds = [String]()
                       arrAppIds.append(appId.stringValue)
                       SingletonClassSwift.sharedInstance.setData(strData: arrAppIds, strKey: STORE_ADDRESS_CHANGED_ARRAY)
                       self.arrAddressChanged = arrAppIds
                   } else {
                       self.arrAddressChanged?.append(appId.stringValue)
                       SingletonClassSwift.sharedInstance.setData(strData: self.arrAddressChanged!, strKey: STORE_ADDRESS_CHANGED_ARRAY)
                   }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
              
        self.present(alert, animated: true, completion:nil)

    }
    
    @objc func markasNotTracebleAddressPressed(id:UIButton) {
        let dic = self.arrayStoreLists[id.tag]
        self.vcDelegate.markasNotTracebleAddressPressed(pTag: self.view.tag,pSelectedRow: id.tag,pDic:dic)
    }
    
    @objc func callBtnPressed(id:UIButton) {
        
        let dic = self.arrayStoreLists[id.tag]
        
         if let url = NSURL(string: "tel://\(dic["mob_no"])"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func directionBtnPressed(id:UIButton) {
        
        let location = SingletonClassSwift.sharedInstance.locationManager.location
        
        var googleMapsURLString:String!
        
        let dic = self.arrayStoreLists[id.tag]

        googleMapsURLString = "http://maps.google.com/?saddr=\(location?.coordinate.latitude ?? 0),\(location!.coordinate.longitude)&daddr=\(dic["latitude"]),\(dic["longitude"])"
        UIApplication.shared.open(URL(string: googleMapsURLString)!, options:  [:], completionHandler: nil)
        
    }
    
    @objc func formBtnPressed(id:UIButton) {
        let dic = self.arrayStoreLists[id.tag]
        self.vcDelegate.didSelectForm(pDic: dic)           
       }

   
}
