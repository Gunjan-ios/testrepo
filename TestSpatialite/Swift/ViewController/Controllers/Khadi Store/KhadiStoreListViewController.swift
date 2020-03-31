//
//  KhadiStoreListViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 05/02/20.
//  Copyright © 2020 Gaurav. All rights reserved.
//

import UIKit
import SwiftyJSON

class KhadiStoreListViewController: SegmentedViewController, UIGestureRecognizerDelegate,SegmentedViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    let tags: [String] = ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7"]
    var arrayStoreLists:[JSON]!
    var VerificationDetailVC:VerificationDetailViewController!
    var arrayPendingStoreLists:[JSON]! = [JSON]()
    var arrayVisitedStoreLists:[JSON]! = [JSON]()
    var arrayNottrceableStoreLists:[JSON]! = [JSON]()
    var emailId:String!
    var password:String!
    
    var pendingVC:PendingKhadiStoresListTableViewController!
    var visitedVC:PendingKhadiStoresListTableViewController!
    var notTracebleVC:PendingKhadiStoresListTableViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SingletonClassSwift.sharedInstance.is_preview_done == true {
            self.reloadData()
            SingletonClassSwift.sharedInstance.is_preview_done = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        // Do any additional setup after loading the view.
        self.delegate = self
        self.separatingStores()
        
        var test: [(title: SegmentedControl.SegmentedItem, controller: UIViewController)] = []
        pendingVC = PendingKhadiStoresListTableViewController(style: .plain)
        pendingVC.arrayStoreLists = self.arrayPendingStoreLists
        pendingVC.view.tag = 1
        pendingVC.vcDelegate = self
        pendingVC.type = "Pending"
        pendingVC.tableView.showsVerticalScrollIndicator = false
        
        visitedVC = PendingKhadiStoresListTableViewController(style: .plain)
        visitedVC.arrayStoreLists = self.arrayVisitedStoreLists
        visitedVC.vcDelegate = self
        visitedVC.type = "Visited"
        visitedVC.view.tag = 1
        
        notTracebleVC = PendingKhadiStoresListTableViewController(style: .plain)
        notTracebleVC.arrayStoreLists = self.arrayNottrceableStoreLists
        notTracebleVC.vcDelegate = self
        notTracebleVC.type = "NotTraceable"
        notTracebleVC.view.tag = 1
        
        let pendingTab = SegmentedControl.SegmentedItem(value: "Pending(\(self.arrayPendingStoreLists.count))")
        
        self.segmentedControl.segmentNormalColor = UIColor.lightGray
        self.segmentedControl.segmentSelectedColor = UIColor.white
        self.segmentedControl.segmentDisabledColor = UIColor.red
    
        
        self.segmentedControl.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        
        test.append((pendingTab, pendingVC))
        test.append((.init(value: "Visited(\(self.arrayVisitedStoreLists.count))"), visitedVC))
        test.append((.init(value: "Not Traceable(\(self.arrayNottrceableStoreLists.count))"), notTracebleVC))
        setControllersForSegments(contents: test)
        
    }
    
    private func separatingStores() {
        
        self.arrayPendingStoreLists.removeAll()
        self.arrayVisitedStoreLists.removeAll()
        self.arrayNottrceableStoreLists.removeAll()
        
        for object in self.arrayStoreLists {
                   
                   if object["inspection_status"].stringValue == "Pending" {
                       self.arrayPendingStoreLists.append(object)
                   } else if object["inspection_status"].stringValue == "Visited" {
                       self.arrayVisitedStoreLists.append(object)
                   } else if object["inspection_status"].stringValue == "Non-Traceable" {
                       self.arrayNottrceableStoreLists.append(object)
                   }
               }
    }
    
    
    private func reloadData() {
        
          SingletonClassSwift.showLoading(title: LOADING_TITLE)
        
          GISWebServicesManager.getStoresData(onCompletion: { response in
            
            self.printOn(pMessage: response!["success"])
            
            if response!["success"] == true {
                    self.arrayStoreLists = response!["data"].array

                    self.printOn(pMessage: self.arrayStoreLists)
                
                    self.separatingStores()
                    
                    self.pendingVC.arrayStoreLists = self.arrayPendingStoreLists
                    self.pendingVC.tableView.reloadData()
                    
                    self.visitedVC.arrayStoreLists = self.arrayVisitedStoreLists
                    self.visitedVC.tableView.reloadData()
                    
                    self.notTracebleVC.arrayStoreLists = self.arrayNottrceableStoreLists
                    self.notTracebleVC.tableView.reloadData()
                    
                    let tab1 = SegmentedControl.SegmentedItem(value: "Pending(\(self.arrayPendingStoreLists.count))")
                    let tab2 = SegmentedControl.SegmentedItem(value:  "Visited(\(self.arrayVisitedStoreLists.count))")
                    let tab3 = SegmentedControl.SegmentedItem(value: "Not Traceable(\(self.arrayNottrceableStoreLists.count))")
        
                    self.segmentedControl.items = [tab1,tab2,tab3]
                    
                       
                   } else {
                       self.displayAlertMessage(pMessage: response!["message"].string!)
                       self.printOn(pMessage: response!["message"])
                   }

               },onError:{ error in
                   
                   if error != nil {
                       self.displayAlertMessage(pMessage: "Something went wrong. ")
                   }
                   
               })
    }
    

    func didScrollToPageAtIndex(_ index: Int) {
        
//        if index == 2 {
//
//            let tags: [String] = ["tag1", "new2", "tag3", "tag4", "tag5", "tag6", "tag7"]
//            let tab1 = SegmentedControl.SegmentedItem(value: "ne234w")
//            let tab2 = SegmentedControl.SegmentedItem(value: "ol34d")
//            let tab3 = SegmentedControl.SegmentedItem(value: "n234ew")
//            let tab4 = SegmentedControl.SegmentedItem(value: "w")
//            let tab5 = SegmentedControl.SegmentedItem(value: "nweeew")
//            let tab6 = SegmentedControl.SegmentedItem(value: "qq")
//            let tab7 = SegmentedControl.SegmentedItem(value: "rr")
//
//
//            self.segmentedControl.items = [tab1,tab2,tab3,tab4,tab5,tab6,tab7]
//        }
    }
    
    override func addHeaderView() {
        let sampleHeaderView = StretchableHeaderView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: 300, height: 70))
        sampleHeaderView.backgroundColor = SUBHEADER_BACKGROUND_COLOUR
        
        var yPos : Int! = 0
        
        if IS_IPHONE_X_XR_XMAX == true{
                yPos = 35
        }else{
                yPos = 25
        }
        let profileView = UIImageView(image: UIImage(named: "userIcon"))
        profileView.frame = CGRect(x: 15, y: yPos, width: 30, height: 30)
        profileView.contentMode = .center
        profileView.backgroundColor = UIColor.white
        profileView.tag = 12345
        profileView.layer.cornerRadius = 15
        sampleHeaderView.addSubview(profileView)
        
        let labelName = UILabel(frame: CGRect(x: 55, y: yPos, width: SCREEN_WIDTH - 84, height: 30))
        labelName.font = UIFont(name: APP_FONT_NAME_BOLD, size: 17.0)
        labelName.textColor = UIColor.white
        labelName.text = self.emailId
        sampleHeaderView.addSubview(labelName)
        
        let btnLogout = UIButton(frame: CGRect(x: SCREEN_WIDTH - 100, y: yPos, width: 100, height: 30))
        btnLogout.setTitle("Log Out", for: .normal)
        btnLogout.setTitleColor(UIColor.white, for: .normal)
        btnLogout.titleLabel?.textAlignment = .right
        btnLogout.addTarget(self, action: #selector(btnLogoutPressed(sender:)), for: .touchUpInside)
        sampleHeaderView.addSubview(btnLogout)
        
        headerView = sampleHeaderView
        view.addSubview(sampleHeaderView)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        pan.delegate = self
        sampleHeaderView.addGestureRecognizer(pan)
    }
    
    @objc func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        let selectedViewController = segmentedViewController[selectedIndex]
        guard let currentScrollView = scrollViewWithSubViewController(viewController: selectedViewController) else { return }
        let point = pan.translation(in: headerView!)
        let contentOffset = currentScrollView.contentOffset
        let border = -headerView!.maximumOfHeight - segmentedControlHeight
        let offsety = contentOffset.y - point.y * (1/contentOffset.y * border * 0.8)
        currentScrollView.contentOffset = CGPoint(x: contentOffset.x, y: offsety)
        
        if (pan.state == .ended || pan.state == .failed) {
            if contentOffset.y <= border {
                UIView.animate(withDuration: 0.35, animations: {
                    currentScrollView.contentOffset = CGPoint(x: contentOffset.x, y: border)
                    self.view.layoutIfNeeded()
                })
                
            }
        }
        pan.setTranslation(CGPoint.zero, in: headerView)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let point = pan.translation(in: headerView!)
            if fabs(point.y) <= fabs(point.x) {
                return false
            }
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK:- actions
    @objc func btnLogoutPressed(sender:UIButton) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to Logout?", preferredStyle:
            .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ (UIAlertAction)in
            self.navigationController?.popToRootViewController(animated: true)

        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alert, animated: true, completion:nil)
        
        
    }
  
    // delegate
    func didSelectForm(pDic:JSON) {
        
        SingletonClassSwift.sharedInstance.setData(strData: false, strKey: INSPECTION_EDIT_MODE)
        SingletonClassSwift.sharedInstance.is_address_changed = false
        SingletonClassSwift.sharedInstance.is_location_changed = false
        SingletonClassSwift.sharedInstance.changed_location_latitude = 0.0
        SingletonClassSwift.sharedInstance.changed_location_longitude = 0.0
        let vc = InspectionFormViewController()
        vc.storeViewData = pDic
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    func markasNotTracebleAddressPressed(pTag:Int,pSelectedRow:Int,pDic:JSON) {
        
        self.VerificationDetailVC = VerificationDetailViewController()
        self.VerificationDetailVC.pTag = pTag
        self.VerificationDetailVC.isFromVerification = false
        self.VerificationDetailVC.app_Id = pDic["app_id"].stringValue
        self.navigationController?.pushViewController(self.VerificationDetailVC, animated: true)

//       let transparentView = UIView(frame: self.view.frame)
//
//       let markView = MarkAsnottracebleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 100, height: 290))
//       markView.center = self.view.center
//       markView.tag = pSelectedRow
//       markView.delegate = self
//       markView.initDesign()
//       transparentView.addSubview(markView)
//       self.view.addSubview(transparentView)
        
    }
    
    // markview delegate
    func markViewOkayPressed(sender:Any,pView:MarkAsnottracebleView, reason : String, agancyName : String) {
        pView.superview?.removeFromSuperview()
        pView.removeFromSuperview()
        
        let dic = self.arrayStoreLists[pView.tag]
        GISWebServicesManager.getMarkAsNonTracebleWS(appId: dic["app_id"].stringValue, verificationStatus: "NonTraceable", agencyName: agancyName, remarks: reason,onCompletion: { response in
            
            let message = response!["data"].stringValue
            
            self.displayAlertMessage(pMessage:message )
            
        },onError:{ error in
            
            if error != nil {
                self.displayAlertMessage(pMessage: "Something went wrong. ")
            }
        })
    }
    
    func markViewCancelPressed(sender:Any,pView:MarkAsnottracebleView) {
        pView.superview?.removeFromSuperview()
        pView.removeFromSuperview()
    }
    
}

