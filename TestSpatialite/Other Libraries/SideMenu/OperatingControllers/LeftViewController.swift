//
//  LeftViewController.swift
//  LGSideMenuControllerDemo
//
import UIKit
import Alamofire
import ExpyTableView
import SSZipArchive

struct Menu {
    let title: String
    let link:String
}

enum SYNC_LAYER_TYPE {
    case SINGLE_LAYER_SYNC
    case MULTIPLE_LAYER_SYNC
}

enum EXT_LAYER_SECTION_SELECTION {
    case NONE
    case SINGLE
    case MULTIPLE
}

//class LeftViewController: UITableViewController {
class LeftViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var layersArray:Array<String> = ["Back"]
//    private var externalLayersArray:Array<ExternalLayer_Section> = []
//    private var tracksArray:Array<MyTrack> = []
//
    fileprivate var sync_type:SYNC_LAYER_TYPE!
    var layerTableView:UITableView!
    var externalLayerTableView:ExpyTableView!
    var tracksTableView:UITableView!
    
    private var scrollView: UIScrollView!
    private var layerEditingView:UIView!
    
    private let sidePanelPadding_X = 15
    private let sideLayerTablesPadding_X = 30
    
    private let smallIconsSize = 24
    private let sidePanelTextsColor = UIColor.darkGray
    private let sidePanelTextsFont = UIFont(name: APP_FONT_NAME, size: 17)
    private let plsuIcon_Padding = 30
    private let label_Height = 20
    private let testingColor = UIColor.clear
    
    private var layerSelectedRow:Int! = -1
    
    private var global_Y_position = 0
    private var enabledAllLayersButtons = false
    private var isStyleLayerOpened = false
    private var isExternalLayerOpened = false
    
    private let CREATE_LAYER_TAG = 1001
    private let ADD_EXTERNAL_LAYER_TAG = 1002
    private let BASEMAP_TAG = 1003
    private let MY_TRACKS_TAG = 1004
    private let BOTTOM_VIEW_TAG = 1005
    
    fileprivate var allRecordsForSync:[[String: Any]]!
    //fileprivate var attachedDataArrayForSync:[Array<GISDownloadedImage>] = []
    fileprivate var sync_layerIDS:[String] = []
    
    fileprivate var switchTracks:UISwitch!
    fileprivate var btnTrackDelete:UIButton!
    fileprivate var btnTrackSync:UIButton!
    
    fileprivate var importMenuForDocuments:UIDocumentPickerViewController!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isStyleLayerOpened == true {
            self.isStyleLayerOpened = false
            
           // self.showUpdatedLayersOnMap()
            self.layerTableView.reloadData()
        } else if self.isExternalLayerOpened == true {
            self.isExternalLayerOpened = false
          //  self.reloadExternalLayerView(fromTop: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        let isSurveyor = SingletonClassSwift.sharedInstance.getDataForKey(strKey: IS_SURVEYOR_KEY) as? Bool
        SingletonClassSwift.sharedInstance.IS_USER_SURVEYOR = isSurveyor
        
       self.initDesign()
        // self.getLayersList()
        
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    
    
    // MARK:- View
    private func initDesign() {
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width:Int(SIDE_PANEL_WIDTH) , height: SCREEN_HEIGHT))
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        var yPosition = 5
        
        let imgLogo = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: yPosition, width: 160, height: 66))
        imgLogo.image = UIImage(named: "nascentlogo")
        scrollView.addSubview(imgLogo)
        
        yPosition = 75
        
        let imgTopLine = UIImageView(frame: CGRect(x: 0, y: yPosition, width: Int(SIDE_PANEL_WIDTH), height: 1))
        imgTopLine.backgroundColor = LINE_BACKGROUND_COLOUR
        scrollView.addSubview(imgTopLine)
        
        yPosition = 90
        
        global_Y_position = yPosition
        
        self.createLayerview()
        
    }
    
    private func createLayerview() {
        
        var yPosition = self.global_Y_position
        
        let createLayerView = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(SIDE_PANEL_WIDTH), height: 50))
        createLayerView.tag = CREATE_LAYER_TAG
        var internalYPosition = 0
        createLayerView.backgroundColor = .clear
        
      /*  // icon
        let imgLayerIcon = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: internalYPosition, width: smallIconsSize, height: 50))
        imgLayerIcon.image = UIImage(named: "imgLayerIcon")
        imgLayerIcon.contentMode = .center
        createLayerView.addSubview(imgLayerIcon)
        
        // create layer
        let lblTitle = UILabel(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14 , y: internalYPosition, width: 120, height: 50))
        lblTitle.text = "Create Layer"
        lblTitle.backgroundColor = testingColor
        lblTitle.textColor = sidePanelTextsColor
        lblTitle.font = sidePanelTextsFont
        createLayerView.addSubview(lblTitle)
        
        let btnPlus = UIButton(frame: CGRect(x: Int(Int(SIDE_PANEL_WIDTH) - smallIconsSize - plsuIcon_Padding) - 5, y: internalYPosition-5, width: smallIconsSize + 10, height: 50))
        btnPlus.setImage(UIImage(named: "plusIcon"), for: .normal)
        btnPlus.backgroundColor = UIColor.clear
        btnPlus.semanticContentAttribute = .forceLeftToRight
        btnPlus.imageView?.contentMode = .center
        btnPlus.addTarget(self, action: #selector(createLayerPressed(sender:)), for: .touchUpInside)
        createLayerView.addSubview(btnPlus)
        
        if SingletonClassSwift.sharedInstance.IS_USER_SURVEYOR == true {
            btnPlus.isUserInteractionEnabled = false
            btnPlus.alpha = 0.5
            
        }
        
        yPosition += 50
        
        global_Y_position = yPosition
        internalYPosition += 50
        
        let layers = Layer.getLayersListFromDatabase()
        self.layersArray += layers
        */
        var numOfRecords = 0
        
        if layersArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = 10
        }
        
        let tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // layer list
        layerTableView = UITableView(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: 10, width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight), style: .plain)
        layerTableView.delegate = self
        layerTableView.dataSource = self
        layerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        layerTableView.separatorStyle = .none
        layerTableView.showsVerticalScrollIndicator = false
        layerTableView.backgroundColor = .clear
        layerTableView.tag = 9999
        //self.layerTableView.register(SidePanelLayerTableViewCell.self, forCellReuseIdentifier: String(describing: SidePanelLayerTableViewCell.self))
        
        createLayerView.addSubview(layerTableView)
        
        createLayerView.frame =  CGRect(x: 0, y: Int(createLayerView.frame.origin.y), width: Int(SIDE_PANEL_WIDTH), height: 50 + tableViewHeight)
        self.scrollView.addSubview(createLayerView)
        
        global_Y_position += tableViewHeight
        internalYPosition += tableViewHeight
        
        // layer edit section
        let viewHeight = 60
        
    /*    let layerEditView = UIView(frame: CGRect(x: sideLayerTablesPadding_X, y: internalYPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: viewHeight))
        layerEditView.backgroundColor = UIColor.clear
        layerEditView.tag = 12345
        createLayerView.addSubview(layerEditView)
        
        if layersArray.count != 0 {
            
            let layerViewWidth = layerEditView.bounds.size.width
            
            let imgTopLine = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(layerViewWidth), height: 1))
            imgTopLine.backgroundColor = LINE_BACKGROUND_COLOUR
            layerEditView.addSubview(imgTopLine)
            
            var buttonWidth = layerViewWidth / 6
            
            let spacing = 5.0
            buttonWidth = buttonWidth - CGFloat(spacing)
            
            var x_position = 0
            
            let buttonTitles = ["Edit", "Table", "Delete", "Style", "Share", "Sync"]
            let buttonImages = ["sidepanelLayerEditEditLayer", "sidepanelLayerEditTable", "sidepanelLayerEditdelete", "sidepanelLayerEditStyle", "sidepanelLayerEditShare", "sidepanelLayerEditSync"]
            
            var index = 0
            
            for name in buttonTitles {
                
                let btnEdit = UIButton(frame: CGRect(x: CGFloat(x_position), y: 1.0, width: buttonWidth, height: 59))
                btnEdit.backgroundColor = UIColor.clear
                btnEdit.tag = index + 1
                btnEdit.isEnabled = false
                btnEdit.addTarget(self, action: #selector(btnEditLayerPressed(sender:)), for: .touchUpInside)
                layerEditView.addSubview(btnEdit)
                
                let imgIcon = UIImageView(frame: CGRect(x: CGFloat(x_position), y: 2.0, width:CGFloat(smallIconsSize), height:CGFloat( smallIconsSize)))
                imgIcon.image = UIImage(named: buttonImages[index])
                imgIcon.isUserInteractionEnabled = false
                imgIcon.tag = index + 1 + 200
                imgIcon.center = CGPoint(x: btnEdit.center.x, y: btnEdit.center.y - 6)
                layerEditView.addSubview(imgIcon)
                
                let lblTitle = UILabel(frame: CGRect(x: CGFloat(x_position), y: 23, width: buttonWidth, height: buttonWidth))
                lblTitle.text = name
                lblTitle.textColor = sidePanelTextsColor
                lblTitle.textAlignment = .center
                lblTitle.tag = index + 1 + 300
                lblTitle.font = UIFont(name: APP_FONT_NAME, size: 10.0)
                layerEditView.addSubview(lblTitle)
                
                if (name == "Edit" || name == "Delete") && SingletonClassSwift.sharedInstance.IS_USER_SURVEYOR == true {
                    btnEdit.isUserInteractionEnabled = false
                    btnEdit.alpha = 0.5
                    imgIcon.alpha = 0.5
                    lblTitle.alpha = 0.5
                }
                
                
                x_position = Int(Double(CGFloat(x_position) + CGFloat(buttonWidth)) + spacing)
                index += 1
                
            }
            
            let imgBottomLine = UIImageView(frame: CGRect(x: 0, y: 60, width: Int(layerViewWidth), height: 1))
            imgBottomLine.backgroundColor = LINE_BACKGROUND_COLOUR
            layerEditView.addSubview(imgBottomLine)
            
            createLayerView.frame =  CGRect(x: 0, y: Int(createLayerView.frame.origin.y), width: Int(SIDE_PANEL_WIDTH), height: 50 + tableViewHeight + viewHeight)
            global_Y_position += viewHeight
        }*/
        
        // base map
       // self.createBaseMapView()
       // self.createAddExternalLayerView()
        
    }
    
/*    private func createAddExternalLayerView() {
        
        var yPosition = self.global_Y_position
        
        let createLayerView = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(SIDE_PANEL_WIDTH), height: 50))
        createLayerView.tag = ADD_EXTERNAL_LAYER_TAG
        var internalYPosition = 0
        
        // icon
        let imgLayerIcon = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: internalYPosition, width: smallIconsSize, height: 50))
        imgLayerIcon.image = UIImage(named: "add_external_layer_icon")
        imgLayerIcon.contentMode = .center
        createLayerView.addSubview(imgLayerIcon)
        
        // create layer
        let lblTitle = UILabel(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14 , y: internalYPosition, width: 220, height: 50))
        lblTitle.text = "Add External Layer"
        lblTitle.backgroundColor = testingColor
        lblTitle.textColor = sidePanelTextsColor
        lblTitle.font = sidePanelTextsFont
        createLayerView.addSubview(lblTitle)
        
        let btnPlus = UIButton(frame: CGRect(x: Int(Int(SIDE_PANEL_WIDTH) - smallIconsSize - plsuIcon_Padding) - 5, y: internalYPosition, width: smallIconsSize + 10, height: 50))
        btnPlus.setImage(UIImage(named: "plusIcon"), for: .normal)
        btnPlus.backgroundColor = UIColor.clear
        btnPlus.semanticContentAttribute = .forceLeftToRight
        btnPlus.imageView?.contentMode = .center
        btnPlus.tag = 12345
        btnPlus.addTarget(self, action: #selector(addLayerFromExternalSourcePressed(sender:)), for: .touchUpInside)
        createLayerView.addSubview(btnPlus)
        
        let btnEdit = UIButton(frame: CGRect(x: Int(Int(SIDE_PANEL_WIDTH) - smallIconsSize - plsuIcon_Padding) - 5 - 34, y: internalYPosition, width: smallIconsSize + 10, height: 50))
        btnEdit.setImage(UIImage(named: "tabEditIconDarkGrey"), for: .normal)
        btnEdit.backgroundColor = UIColor.clear
        btnEdit.semanticContentAttribute = .forceLeftToRight
        btnEdit.imageView?.contentMode = .center
        btnEdit.tag = 11111
        btnEdit.addTarget(self, action: #selector(editLayerFromExternalSourcePressed(sender:)), for: .touchUpInside)
        createLayerView.addSubview(btnEdit)
        btnEdit.isHidden = true
        
        let btnDelete = UIButton(frame: CGRect(x: Int(Int(SIDE_PANEL_WIDTH) - smallIconsSize - plsuIcon_Padding) - 5, y: internalYPosition, width: smallIconsSize + 10, height: 50))
        btnDelete.setImage(UIImage(named: "tabdeleteIconDarkGrey"), for: .normal)
        btnDelete.backgroundColor = UIColor.clear
        btnDelete.semanticContentAttribute = .forceLeftToRight
        btnDelete.imageView?.contentMode = .center
        btnDelete.tag = 22222
        btnDelete.addTarget(self, action: #selector(deleteLayerFromExternalSourcePressed(sender:)), for: .touchUpInside)
        createLayerView.addSubview(btnDelete)
        btnDelete.isHidden = true
        
        
        self.scrollView.addSubview(createLayerView)
        
        yPosition += 50
        
        global_Y_position = yPosition
        internalYPosition += 50
        
        let externalLayers = ExternalLayer.getAddedExternalLayersListFromDatabase()
        
        self.externalLayersArray += externalLayers
        
        var numOfRecords = 0
        
        if externalLayersArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = externalLayersArray.count
        }
        
        let tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // layer list
        self.externalLayerTableView = ExpyTableView(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: internalYPosition, width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight), style: .plain)
        self.externalLayerTableView.delegate = self
        self.externalLayerTableView.dataSource = self
        self.externalLayerTableView.tag = 88888
        self.externalLayerTableView.register(DataTypeTableViewCell.self, forCellReuseIdentifier: "DataTypeTableViewCell")
        self.externalLayerTableView.register(MultipleOptionsListTableViewCell.self, forCellReuseIdentifier: "MultipleOptionsListTableViewCell")
       // self.externalLayerTableView.register(LeftViewCell.self, forCellReuseIdentifier: "cell")
        self.externalLayerTableView.separatorStyle = .none
        self.externalLayerTableView.showsVerticalScrollIndicator = false
        self.externalLayerTableView.backgroundColor = .clear
        
        self.externalLayerTableView.rowHeight = UITableView.automaticDimension
        self.externalLayerTableView.estimatedRowHeight = 44
        //Alter the animations as you want
        self.externalLayerTableView.expandingAnimation = .fade
        self.externalLayerTableView.collapsingAnimation = .fade
        
        createLayerView.addSubview(self.externalLayerTableView)
        
        
        createLayerView.frame =  CGRect(x: 0, y: Int(createLayerView.frame.origin.y), width: Int(SIDE_PANEL_WIDTH), height: 50 + tableViewHeight)
        createLayerView.backgroundColor = UIColor.clear
        self.scrollView.addSubview(createLayerView)
        
        global_Y_position += tableViewHeight
        internalYPosition += tableViewHeight
        
        
        // base map
      //  self.createBaseMapView()
        
    }*/
    /*
    private func createBaseMapView() {
        
        let viewHeight = 160
        
        let baseMapView = UIView(frame: CGRect(x: 0, y: global_Y_position, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: viewHeight))
        baseMapView.backgroundColor = UIColor.clear
        baseMapView.tag = BASEMAP_TAG
        self.scrollView.addSubview(baseMapView)
        
        var yPosition = 0
        
        let xPos = 23 + sideLayerTablesPadding_X
        
        let imgBaseMap = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: yPosition, width: 40, height: 40))
        imgBaseMap.image = UIImage(named: "baseMapIcon")
        imgBaseMap.contentMode = .left
        imgBaseMap.backgroundColor = UIColor.clear
        baseMapView.addSubview(imgBaseMap)
        
        let btnBaseMap = UIButton(frame: CGRect(x: xPos, y: yPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: 40 ))
        btnBaseMap.backgroundColor = UIColor.clear
        btnBaseMap.setTitle("Basemap", for: .normal)
        btnBaseMap.setTitleColor(sidePanelTextsColor, for: .normal)
        btnBaseMap.titleLabel?.font = sidePanelTextsFont
        btnBaseMap.contentHorizontalAlignment = .left
        baseMapView.addSubview(btnBaseMap)
        
        yPosition += 40
        
        // basmap option 1
        let imgViewForBaseMapOption1 = UIImageView(frame: CGRect(x: xPos + 20, y: yPosition, width: 40, height: 40))
        imgViewForBaseMapOption1.image = UIImage(named: "baseMapIcon")
        imgViewForBaseMapOption1.contentMode = .center
        imgViewForBaseMapOption1.backgroundColor = UIColor.clear
        baseMapView.addSubview(imgViewForBaseMapOption1)
        
        let btnMap1 = UIButton(frame: CGRect(x: xPos + 20 + smallIconsSize + 20, y: yPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: 40 ))
        btnMap1.backgroundColor = UIColor.clear
        btnMap1.setTitle("OSM", for: .normal)
        btnMap1.setTitleColor(sidePanelTextsColor, for: .normal)
        btnMap1.titleLabel?.font = sidePanelTextsFont
        btnMap1.contentHorizontalAlignment = .left
        baseMapView.addSubview(btnMap1)
        
      /*  yPosition += 40
        
        // basemap option 2
        let imgViewForBaseMapOption2 = UIImageView(frame: CGRect(x: xPos + 20, y: yPosition, width: 40, height: 40))
        imgViewForBaseMapOption2.image = UIImage(named: "baseMapIcon")
        imgViewForBaseMapOption2.backgroundColor = UIColor.clear
        imgViewForBaseMapOption2.contentMode = .center
        baseMapView.addSubview(imgViewForBaseMapOption2)
        
        let btnMap2 = UIButton(frame: CGRect(x: xPos + 20 + smallIconsSize + 20, y: yPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: 40 ))
        btnMap2.backgroundColor = UIColor.clear
        btnMap2.setTitle("Google", for: .normal)
        btnMap2.setTitleColor(sidePanelTextsColor, for: .normal)
        btnMap2.titleLabel?.font = sidePanelTextsFont
        btnMap2.contentHorizontalAlignment = .left
        baseMapView.addSubview(btnMap2)
        */
 
        yPosition += 40
        
        let imgBackup = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: yPosition, width: 40, height: 40))
        imgBackup.image = UIImage(named: "backUpIcon")
        imgBackup.contentMode = .left
        imgBackup.backgroundColor = UIColor.clear
        baseMapView.addSubview(imgBackup)
        
        let btnBackup = UIButton(frame: CGRect(x: xPos, y: yPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: 40))
        btnBackup.backgroundColor = UIColor.clear
        btnBackup.setTitleColor(sidePanelTextsColor, for: .normal)
        btnBackup.titleLabel?.font = sidePanelTextsFont
        btnBackup.contentHorizontalAlignment = .left
        btnBackup.addTarget(self, action: #selector(backUpPressed(sender:)), for: .touchUpInside)
        btnBackup.setTitle("Backup", for: .normal)
        baseMapView.addSubview(btnBackup)
        
        yPosition += 40
        
        let imgRestore = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: yPosition, width: 40, height: 40))
        imgRestore.image = UIImage(named: "restore_icon")
        imgRestore.contentMode = .left
        imgRestore.backgroundColor = UIColor.clear
        baseMapView.addSubview(imgRestore)
        
        let btnRestore = UIButton(frame: CGRect(x: xPos, y: yPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: 40))
        btnRestore.backgroundColor = UIColor.clear
        btnRestore.setTitleColor(sidePanelTextsColor, for: .normal)
        btnRestore.titleLabel?.font = sidePanelTextsFont
        btnRestore.addTarget(self, action: #selector(restorePressed(sender:)), for: .touchUpInside)
        btnRestore.contentHorizontalAlignment = .left
        btnRestore.setTitle("Restore", for: .normal)
        baseMapView.addSubview(btnRestore)
        
        yPosition += 40
        
        self.global_Y_position += yPosition
        
        self.createMyTracksView()
        
    }
    
    private func createMyTracksView() {
        
        let xPos = 23 + sideLayerTablesPadding_X
        let viewHeight = 50
        var internalYPosition = 0
        
        let myTracksView = UIView(frame: CGRect(x: 0, y: global_Y_position, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: viewHeight))
        myTracksView.backgroundColor = UIColor.clear
        myTracksView.tag = MY_TRACKS_TAG;
        self.scrollView.addSubview(myTracksView)
        
        // My tracks
        let imgLogo = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: internalYPosition, width: 50, height: 50))
        imgLogo.image = UIImage(named: "myTracksIcon")
        imgLogo.contentMode = .left
        imgLogo.backgroundColor = UIColor.clear
        myTracksView.addSubview(imgLogo)
        
        let lblTitle = UILabel(frame: CGRect(x: xPos, y: internalYPosition, width: 100, height: 50))
        lblTitle.text = "My Tracks"
        lblTitle.textColor = sidePanelTextsColor
        lblTitle.font = sidePanelTextsFont
        myTracksView.addSubview(lblTitle)
        
        
        self.btnTrackDelete = UIButton(frame: CGRect(x: Int(layerTableView.frame.size.width) - plsuIcon_Padding - 13, y: internalYPosition, width: smallIconsSize + 10, height: 45))
        btnTrackDelete.backgroundColor = UIColor.clear
        btnTrackDelete.setImage(UIImage(named: "tabdeleteIconDarkGrey"), for: .normal)
        btnTrackDelete.addTarget(self, action: #selector(btnTrackDeletePressed(sender:)), for: .touchUpInside)
        self.btnTrackDelete.isHidden = true
        myTracksView.addSubview(btnTrackDelete)
        
        self.btnTrackSync = UIButton(frame: CGRect(x: Int(layerTableView.frame.size.width) - 8, y: internalYPosition, width: smallIconsSize + 10, height: 45))
        btnTrackSync.backgroundColor = UIColor.clear
        btnTrackSync.setImage(UIImage(named: "syncIconDarkGrey"), for: .normal)
        btnTrackSync.addTarget(self, action: #selector(btnTrackSyncPressed(sender:)), for: .touchUpInside)
        self.btnTrackSync.isHidden = true
        myTracksView.addSubview(btnTrackSync)
        
        self.switchTracks = UISwitch(frame:CGRect(x:  Int(Int(layerTableView.frame.size.width) - plsuIcon_Padding), y: internalYPosition + 5, width: 0, height: 0))
        self.switchTracks.setOn(false, animated: false)
        self.switchTracks.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        myTracksView.addSubview(self.switchTracks)
        
        internalYPosition += 50
        global_Y_position += internalYPosition
        
        let tracks = MyTrack.getTrackListFromDatabase()
        self.tracksArray += tracks
        
        var numOfRecords = 0
        
        if tracksArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = tracksArray.count
        }
        
        let tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // layer list
        self.tracksTableView = UITableView(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: internalYPosition, width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight), style: .plain)
        self.tracksTableView.delegate = self
        self.tracksTableView.dataSource = self
        self.tracksTableView.register(LeftViewCell.self, forCellReuseIdentifier: "cell")
        self.tracksTableView.separatorStyle = .none
        self.tracksTableView.showsVerticalScrollIndicator = false
        self.tracksTableView.tag = 9999
        self.tracksTableView.backgroundColor = .clear
        self.tracksTableView.register(SidePanelLayerTableViewCell.self, forCellReuseIdentifier: String(describing: SidePanelLayerTableViewCell.self))
        
        myTracksView.addSubview(self.tracksTableView)
        
        myTracksView.frame = CGRect(x: myTracksView.frame.origin.x, y: myTracksView.frame.origin.y, width: myTracksView.frame.size.width, height: CGFloat(tableViewHeight + 50))
        
        global_Y_position += (tableViewHeight)
        
        self.createBottomViews()
        
        
    }
    
    private func createBottomViews() {
        
        var internalYPosition = 0
       // let viewHeight = 100
         let viewHeight = 140
        
        let bottomView = UIView(frame: CGRect(x: 0, y: global_Y_position, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: viewHeight))
        bottomView.backgroundColor = UIColor.clear
        bottomView.tag = BOTTOM_VIEW_TAG
        self.scrollView.addSubview(bottomView)
        
        internalYPosition += 7
        
        let imgLine = UIImageView(frame: CGRect(x: 0, y: internalYPosition, width: Int(SIDE_PANEL_WIDTH), height: 1))
        imgLine.backgroundColor = LINE_BACKGROUND_COLOUR
        bottomView.addSubview(imgLine)
        
        internalYPosition += 15
        
        let imgSettingsIcon = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: internalYPosition, width: smallIconsSize, height: smallIconsSize))
        imgSettingsIcon.image = UIImage(named: "sidePanelLayerSetting")
        bottomView.addSubview(imgSettingsIcon)
        
        let btnSettings = UIButton(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: internalYPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: smallIconsSize ))
        btnSettings.backgroundColor = UIColor.clear
        btnSettings.setTitle("Settings", for: .normal)
        btnSettings.setTitleColor(sidePanelTextsColor, for: .normal)
        btnSettings.addTarget(self, action: #selector(btnSettingPressed(sender:)), for: .touchUpInside)
        btnSettings.titleLabel?.font = sidePanelTextsFont
        btnSettings.contentHorizontalAlignment = .left
        bottomView.addSubview(btnSettings)
        
        internalYPosition += 40
        
        let imgHelpIcon = UIImageView(frame: CGRect(x: sidePanelPadding_X, y: internalYPosition, width: smallIconsSize, height: smallIconsSize))
        imgHelpIcon.image = UIImage(named: "sidepanelLayerHelp")
        bottomView.addSubview(imgHelpIcon)
        
        let btnHelp = UIButton(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: internalYPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: smallIconsSize ))
        btnHelp.backgroundColor = UIColor.clear
        btnHelp.setTitle("Help & feedback", for: .normal)
        btnHelp.setTitleColor(sidePanelTextsColor, for: .normal)
        btnHelp.titleLabel?.font = sidePanelTextsFont
        btnHelp.contentHorizontalAlignment = .left
        bottomView.addSubview(btnHelp)
        
        internalYPosition += 40
        
        let btnSignIn = UIButton(frame: CGRect(x: sidePanelPadding_X + smallIconsSize + 14, y: internalYPosition, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: smallIconsSize ))
        btnSignIn.backgroundColor = UIColor.clear
        btnSignIn.setTitle("Log Out", for: .normal)
        btnSignIn.setTitleColor(sidePanelTextsColor, for: .normal)
        btnSignIn.addTarget(self, action: #selector(btnLogOutPressed(sender:)), for: .touchUpInside)
        btnSignIn.titleLabel?.font = sidePanelTextsFont
        btnSignIn.contentHorizontalAlignment = .left
        bottomView.addSubview(btnSignIn)
        
        
        
        print(global_Y_position)
        print(SCREEN_HEIGHT)
        
        //self.scrollView.contentSize = CGSize(width: Int(SIDE_PANEL_WIDTH), height: global_Y_position + 130)
        self.scrollView.contentSize = CGSize(width: Int(SIDE_PANEL_WIDTH), height: global_Y_position + 170)
        
    }
    
    // MARK:- Control Reload
    private func reloadLayerView() {
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        let createLayerView = self.scrollView.view(withId: "\(CREATE_LAYER_TAG)")
        
        var internalYPosition = createLayerView?.frame.origin.y
        
        global_Y_position = Int(internalYPosition! + 50) // view height
        
        self.layersArray = Layer.getLayersListFromDatabase()
        
        var numOfRecords = 0
        
        if layersArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = layersArray.count
        }
        
        let tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // layer list
        let tableview = createLayerView?.view(withId: "9999") as! UITableView
        tableview.frame = CGRect(x: Int(tableview.frame.origin.x), y: Int(tableview.frame.origin.y), width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight)
        self.layerTableView.reloadData()
        
        createLayerView!.frame = CGRect(x: createLayerView!.frame.origin.x, y: createLayerView!.frame.origin.y, width: createLayerView!.frame.size.width, height: CGFloat(tableViewHeight + 50 + 60))
        
        internalYPosition = CGFloat(tableViewHeight + 50)
        let layerEditView = createLayerView?.view(withId: "12345")
       
        layerEditView!.frame = CGRect(x: layerEditView!.frame.origin.x, y:internalYPosition! , width: layerEditView!.frame.size.width, height: layerEditView!.frame.size.height)
        
        global_Y_position = global_Y_position + tableViewHeight + Int(layerEditView!.frame.size.height)
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        self.reloadExternalLayerView(fromTop: true)
        
    }
    
    private func reloadExternalLayerView(fromTop:Bool) {
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        let externalLayerView = self.scrollView.view(withId: "\(ADD_EXTERNAL_LAYER_TAG)")
        
        var internalYPosition:CGFloat!
        
        if fromTop == true {
            internalYPosition = CGFloat(self.global_Y_position)
            global_Y_position = Int(internalYPosition! + 50) // view height
        } else {
            internalYPosition = externalLayerView?.frame.origin.y
            global_Y_position = Int(internalYPosition! + 50) // view height
        }
        

        self.externalLayersArray = ExternalLayer.getAddedExternalLayersListFromDatabase()
        
        var numOfRecords = 0
        
        if externalLayersArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = externalLayersArray.count
        }
        
        var tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // max height
        if (Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * 5) < Int(self.externalLayerTableView.contentSize.height) {
            tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * 5
        } else if tableViewHeight < Int(self.externalLayerTableView.contentSize.height) {
            //global_Y_position = Int(internalYPosition!)
            tableViewHeight = Int(self.externalLayerTableView.contentSize.height)
        }
        
        
        // layer list
        let tableview = externalLayerView?.view(withId: "88888") as! ExpyTableView
        tableview.frame = CGRect(x: Int(tableview.frame.origin.x), y: Int(tableview.frame.origin.y), width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight)
        self.externalLayerTableView.reloadData()
        
        if fromTop == true {
            externalLayerView!.frame = CGRect(x: externalLayerView!.frame.origin.x, y: CGFloat(internalYPosition), width: externalLayerView!.frame.size.width, height: CGFloat(tableViewHeight + 50))
        } else {
            externalLayerView!.frame = CGRect(x: externalLayerView!.frame.origin.x, y: externalLayerView!.frame.origin.y, width: externalLayerView!.frame.size.width, height: CGFloat(tableViewHeight + 50))
        }
        
        // check +, edit, delete icon dispplay, hide
        let isSelected = self.checkAnyExtLayerSectionSelected()
        
        let btnPlus = externalLayerView?.view(withId: "12345")
        let btnEdit = externalLayerView?.view(withId: "11111")
        let btnAdd = externalLayerView?.view(withId: "22222")
        
        switch isSelected {
            case .NONE:
                btnPlus?.isHidden = false
                btnEdit?.isHidden = true
                btnAdd?.isHidden = true
            case .SINGLE:
                btnPlus?.isHidden = true
                btnEdit?.isHidden = false
                btnAdd?.isHidden = false
            case .MULTIPLE:
                btnPlus?.isHidden = true
                btnEdit?.isHidden = true
                btnAdd?.isHidden = false
            default:
                print("nothing")
        }
        
        global_Y_position += (tableViewHeight)
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        self.reloadBaseMapView()
        
    }
    
    private func reloadBaseMapView() {
        
        let myBaseMapView = self.scrollView.view(withId: "\(BASEMAP_TAG)")
        
        myBaseMapView?.frame = CGRect(x: 0, y: global_Y_position, width: Int(self.scrollView.bounds.size.width) - sideLayerTablesPadding_X, height: Int((myBaseMapView?.frame.size.height)!))
        
        global_Y_position += Int((myBaseMapView?.frame.size.height)!)
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        self.reloadMyTrackView(reloadedFromTop: true)
        
    }
    
    
    private func reloadMyTrackView(reloadedFromTop:Bool) {
        
        let myTracksView = self.scrollView.view(withId: "\(MY_TRACKS_TAG)")
        var internalYPosition: Int?
        
        if reloadedFromTop == true {
             internalYPosition = Int(global_Y_position)
           
        } else {
            internalYPosition = Int((myTracksView?.frame.origin.y)!)
           
        }
        
        global_Y_position = Int(internalYPosition! + 50) // view height
        
        let tracks = MyTrack.getTrackListFromDatabase()
        self.tracksArray.removeAll()
        
        self.tracksArray += tracks
        
        var numOfRecords = 0
        
        if tracksArray.count > 5 {
            numOfRecords = 5
        } else {
            numOfRecords = tracksArray.count
        }
        
        let tableViewHeight = Int(SIDE_PANEL_LABEL_CELL_HEIGHT) * numOfRecords
        
        // layer list
        let tableview = myTracksView?.view(withId: "9999") as! UITableView
        tableview.frame = CGRect(x: Int(tableview.frame.origin.x), y: Int(tableview.frame.origin.y), width: Int(SIDE_PANEL_WIDTH) - (sidePanelPadding_X + smallIconsSize + 14), height: tableViewHeight)
        self.tracksTableView.reloadData()
        
        //myTracksView!.frame = CGRect(x: myTracksView!.frame.origin.x, y: myTracksView!.frame.origin.y, width: myTracksView!.frame.size.width, height: CGFloat(tableViewHeight + 50))
        myTracksView!.frame = CGRect(x: myTracksView!.frame.origin.x, y: CGFloat(internalYPosition!), width: myTracksView!.frame.size.width, height: CGFloat(tableViewHeight + 50))
        
        global_Y_position += (tableViewHeight)
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: global_Y_position)
        
        self.reloadBottomView()
        
    }
    
    private func reloadBottomView() {
        
        let myTracksView = self.scrollView.view(withId: "\(BOTTOM_VIEW_TAG)")
        
        myTracksView?.frame = CGRect(x: (myTracksView?.frame.origin.x)!, y: CGFloat(global_Y_position), width: (myTracksView?.frame.size.width)!, height: (myTracksView?.frame.size.height)!)
        
        //self.scrollView.contentSize = CGSize(width: Int(SIDE_PANEL_WIDTH), height: global_Y_position + 130)
        self.scrollView.contentSize = CGSize(width: Int(SIDE_PANEL_WIDTH), height: global_Y_position + 170)
        
    }
    
    private func reloadExternalLayerButtons() {
        
        let externalLayerView = self.scrollView.view(withId: "\(ADD_EXTERNAL_LAYER_TAG)")
        
        // check +, edit, delete icon dispplay, hide
        let isSelected = self.checkAnyExtLayerSectionSelected()
        
        let btnPlus = externalLayerView?.view(withId: "12345")
        let btnEdit = externalLayerView?.view(withId: "11111")
        let btnAdd = externalLayerView?.view(withId: "22222")
        
        switch isSelected {
        case .NONE:
            btnPlus?.isHidden = false
            btnEdit?.isHidden = true
            btnAdd?.isHidden = true
        case .SINGLE:
            btnPlus?.isHidden = true
            btnEdit?.isHidden = false
            btnAdd?.isHidden = false
        case .MULTIPLE:
            btnPlus?.isHidden = true
            btnEdit?.isHidden = true
            btnAdd?.isHidden = false
        default:
            print("nothing")
        }
        
    }
    
    // MARK: actions
    @objc private func backUpPressed(sender:UIButton) {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let temppath = self.tempZipPath()
        
        let success = SSZipArchive.createZipFile(atPath: temppath,
                                                 withContentsOfDirectory: documentsDir!.path,
                                                 keepParentDirectory: false,
                                                 compressionLevel: -1,
                                                 password: nil,
                                                 aes: true,
                                                 progressHandler: nil)
        if success {
            print("Success zip")
            
        } else {
            print("No success zip")
            
        }
        
        let zpath = URL(fileURLWithPath: temppath, isDirectory: false)
        
        let activity = UIActivityViewController(
            activityItems: [zpath],
            applicationActivities: []
        )
        
        activity.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            
            
            if completed {
                print("exported")
            }
            // User completed activity
            do {
                try fileManager.removeItem(atPath: zpath.path)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            print("deleted file \(zpath.path)")
            
        }
        
        self.present(activity, animated: true, completion: nil)
        
    }
    
    @objc private func restorePressed(sender:UIButton) {
        
        self.importMenuForDocuments = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        // let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        self.importMenuForDocuments.delegate = self as? UIDocumentPickerDelegate
        self.importMenuForDocuments.modalPresentationStyle = .formSheet
        self.importMenuForDocuments.view.tag = sender.tag
        self.present(self.importMenuForDocuments, animated: true, completion: nil)
    }
    
    @objc private func createLayerPressed(sender: UIButton) {
        
        let alert = UIAlertController(title: "Create New Layer", message: "Name your Layer", preferredStyle:
            .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler:{ (UIAlertAction)in
            
            let layerNameTextField = alert.textFields![0] as UITextField
            
            let mainViewController = self.sideMenuController!
            mainViewController.hideLeftView(animated: true, completionHandler: nil)
            
            var myNavigationController:NavigationController
            
            let vc = GISGeometryTypesViewController()
            vc.layerName = layerNameTextField.text
            
            myNavigationController = NavigationController(rootViewController: vc)
            myNavigationController.navigationBar.isHidden = true
            myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
            
            let myMainViewController = MainViewController()
            myMainViewController.rootViewController = myNavigationController
            myMainViewController.myVTVNavigarionController = myNavigationController
            myMainViewController.setup(type: UInt(1))
            myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = myMainViewController
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
            
        }))
        
        self.present(alert, animated: true, completion:nil)
        
    }
    
    @objc private func editLayerFromExternalSourcePressed(sender: UIButton) {
        
    }
    
    @objc private func deleteLayerFromExternalSourcePressed(sender: UIButton) {
        
        let alert = UIAlertController(title: "Message", message: "Are You Sure?", preferredStyle:
            .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ (UIAlertAction)in
            // delete all data
            let selLayersArray = self.getExtLayerSectionsSelected()
        
            for object in selLayersArray {
                ExternalLayer.deleteLayerFieldsData(pExtenalLayerArray: object.extLayersArray)
                ExternalLayer.deleteMainLayerSourceData(pObject: object)
            }
            
            self.externalLayersArray = ExternalLayer.getAddedExternalLayersListFromDatabase()
            self.externalLayerTableView.reloadData()
            
            self.reloadExternalLayerView(fromTop: false)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        
        self.present(alert, animated: true, completion:nil)
    }
    
    @objc private func addLayerFromExternalSourcePressed(sender: UIButton) {
        
        let mainViewController = self.sideMenuController!
        mainViewController.hideLeftView(animated: true, completionHandler: nil)
        
        var myNavigationController:NavigationController
        
        let vc = GISAddExternalLayerViewController()
        
        myNavigationController = NavigationController(rootViewController: vc)
        myNavigationController.navigationBar.isHidden = true
        myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        let myMainViewController = MainViewController()
        myMainViewController.rootViewController = myNavigationController
        myMainViewController.myVTVNavigarionController = myNavigationController
        myMainViewController.setup(type: UInt(1))
        myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
        
        let window = UIApplication.shared.delegate!.window!!
        window.rootViewController = myMainViewController
        
        
        self.isExternalLayerOpened = true
        
    }
    
    func configurationTextField(textField: UITextField!) {
        if (textField) != nil {
            
            textField?.placeholder = "Layer Name";
        }
    }
    
    @objc func btnEditLayerPressed(sender:UIButton) {
        
        if (self.layerSelectedRow == -1) {
            return
        }
        
        if sender.tag == 1 {
            // edit
            let mainViewController = self.sideMenuController!
            mainViewController.hideLeftView(animated: true, completionHandler: nil)
            
            var myNavigationController:NavigationController
            
            let vc = GISAddLayerViewController()
            
            vc.screenType = .EDIT
            vc.currentLayer = self.layersArray[self.layerSelectedRow]
            vc.layerName = vc.currentLayer.layer_name
            
            myNavigationController = NavigationController(rootViewController: vc)
            myNavigationController.navigationBar.isHidden = true
            myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
            
            let myMainViewController = MainViewController()
            myMainViewController.rootViewController = myNavigationController
            myMainViewController.myVTVNavigarionController = myNavigationController
            myMainViewController.setup(type: UInt(1))
            myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = myMainViewController
        
        } else if sender.tag == 2 {
            // table
            SingletonClassSwift.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeLeft, andRotateTo: UIInterfaceOrientation.landscapeLeft)
            
            var myNavigationController:NavigationController
            
            let vc = GISLayerDataViewController()
            
            vc.currentLayer = self.layersArray[self.layerSelectedRow]
            print("selected layer id \(String(describing: vc.currentLayer.id))")
            myNavigationController = NavigationController(rootViewController: vc)
            myNavigationController.navigationBar.isHidden = true
            myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
            
            let myMainViewController = MainViewController()
            myMainViewController.rootViewController = myNavigationController
            myMainViewController.myVTVNavigarionController = myNavigationController
            myMainViewController.setup(type: UInt(1))
            myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = myMainViewController
        } else if sender.tag == 3 {
            // delete
            let alert = UIAlertController(title: "Message", message: "Please Select Option", preferredStyle:.actionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler:{ (UIAlertAction)in
                
                self.deleteDataForLayer()
                self.reloadLayerView()
                
            }))
            
            alert.addAction(UIAlertAction(title: "Sync & Delete", style: .default, handler:{ (UIAlertAction)in
                
                self.sync_type = SYNC_LAYER_TYPE.SINGLE_LAYER_SYNC
                let currentLayer = self.layersArray[self.layerSelectedRow]
                self.syncDataForLayer(pLayerId: currentLayer.id!)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                
                
            }))
            
            self.present(alert, animated: true, completion:nil)
        } else if sender.tag == 4 {
            
            // styles
            //let vc = GISLayerStyleViewController()
            let mainViewController = self.sideMenuController!
            mainViewController.hideLeftView(animated: true, completionHandler: nil)
            
            var myNavigationController:NavigationController
            
            let vc = GISStyleTypesViewController()
            vc.currentLayer = self.layersArray[self.layerSelectedRow]

            myNavigationController = NavigationController(rootViewController: vc)
            myNavigationController.navigationBar.isHidden = true
            myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
            
            let myMainViewController = MainViewController()
            myMainViewController.rootViewController = myNavigationController
            myMainViewController.myVTVNavigarionController = myNavigationController
            myMainViewController.setup(type: UInt(1))
            myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = myMainViewController
            
            
        } else if sender.tag == 6 {
            // sync
            SingletonClassSwift.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeLeft, andRotateTo: UIInterfaceOrientation.landscapeLeft)
            
            var myNavigationController:NavigationController
            
            let vc = GISSyncLayerDataViewController()
            
            vc.currentLayer = self.layersArray[self.layerSelectedRow]
            print("selected layer id \(String(describing: vc.currentLayer.id))")
            myNavigationController = NavigationController(rootViewController: vc)
            myNavigationController.navigationBar.isHidden = true
            myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
            
            let myMainViewController = MainViewController()
            myMainViewController.sideMenuController
            myMainViewController.rootViewController = myNavigationController
            myMainViewController.myVTVNavigarionController = myNavigationController
            myMainViewController.setup(type: UInt(1))
            myMainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
            
            let window = UIApplication.shared.delegate!.window!!
            window.rootViewController = myMainViewController
            
        }
        
    }
    
    @objc func btnTrackDeletePressed(sender:UIButton) {

        var selectedTracks:[MyTrack]! = []
        
        for track in self.tracksArray {
            if track.isSelected == true {
                selectedTracks.append(track)
            }
        }
        
        
        let alert = UIAlertController(title: "Delete Track", message: "Deleting this track will also delete its data.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sync & Delete", style: .default , handler:{ (UIAlertAction)in
            print("User click sync button")
            for track in selectedTracks {
                print(track.track_name,track.trackGeom,track.trackGeomInString)
            }
            
             self.checkTrackSelected()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction)in
            for track in selectedTracks {
                MyTrack.deleteTrackFromDatabase(pTrackId: track.id!)
            }
            
            self.reloadMyTrackView(reloadedFromTop: false)
            
            self.checkTrackSelected()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            print("User click cancel button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
        
    }
    
    @objc func btnTrackSyncPressed(sender:UIButton) {
        
        var selectedTracks:[MyTrack]!
        
        for track in self.tracksArray {
            if track.isSelected == true {
                selectedTracks.append(track)
                break
            }
        }
        
    }
    
    @objc func btnExtLayerEditPressed(sender:UIButton) {
        
        
    }
    
    @objc func btnExtLayerDeletePressed(sender:UIButton) {
        
        
        let alert = UIAlertController(title: "Message", message: "Are You Sure?", preferredStyle:
            .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ (UIAlertAction)in
            
            let selLayer = self.externalLayersArray[sender.tag]
            
            var selectedExtLayers:[ExternalLayer]! = []
            
            for object in selLayer.extLayersArray {
                if object.isSelected == true {
                    selectedExtLayers.append(object)
                }
            }
            
            ExternalLayer.deleteLayerFieldsData(pExtenalLayerArray: selectedExtLayers)
            self.externalLayersArray = ExternalLayer.getAddedExternalLayersListFromDatabase()
            self.externalLayerTableView.reloadData()
            
            self.reloadExternalLayerView(fromTop: false)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
    
        
        self.present(alert, animated: true, completion:nil)
        
       
        
    }
    
    //MARK:- delete & sync data on server
    private func syncDataForLayer(pLayerId:String) {
        
        allRecordsForSync = Layer.getLoadFeaturesData(pLayerId: pLayerId)
        
        if allRecordsForSync.count == 0 {
            // no records for sync for this layer id
            self.checkDataForSync()
            return
        }
        
        SingletonClassSwift.sharedInstance.printOnConsole(pMessage: allRecordsForSync)
        
        self.attachedDataArrayForSync.removeAll()
        
        for layerObject in allRecordsForSync {
            
            var attachedDataForSync:Array<GISDownloadedImage> = []
            
            attachedDataForSync = self.getDataForAll(pLayerId:pLayerId,pObject: layerObject,pType: "Image")
            attachedDataForSync += self.getDataForAll(pLayerId:pLayerId,pObject: layerObject, pType: "Document")
            attachedDataForSync += self.getDataForAll(pLayerId:pLayerId,pObject: layerObject, pType: "Audio")
            attachedDataForSync += self.getDataForAll(pLayerId:pLayerId,pObject: layerObject, pType: "Video")
            attachedDataArrayForSync.append(attachedDataForSync)
        }
        
        let layerObject = allRecordsForSync[0]
        let dic = ["layerId":pLayerId,"features":[layerObject]] as [String : Any]
        self.syncLayersOnServer(pObject: dic,pImagesObject:attachedDataArrayForSync[0] )
    }
    
    func syncLayersOnServer(pObject:[String : Any],pImagesObject:[GISDownloadedImage]) {
        
        GISWebServicesManager.syncLayersRecordsOnServer(imageData: pImagesObject, parameters: pObject, onCompletion: { response in
            
            // remove sync array
            self.setSyncInauditLog(pObject: self.allRecordsForSync[0],pLayerID: pObject["layerId"]! as! String)
            self.allRecordsForSync.remove(at: 0)
            self.attachedDataArrayForSync.remove(at: 0)
            
            if self.allRecordsForSync.count > 0 {
                let layerObject = self.allRecordsForSync[0]
                let dic = ["layerId":pObject["layerId"]!,"features":[layerObject]] as [String : Any]
                self.syncLayersOnServer(pObject: dic,pImagesObject: self.attachedDataArrayForSync[0])
            } else {
                 SingletonClassSwift.sharedInstance.printOnConsole(pMessage: "all sync")
                // now delete and reload data
                self.deleteDataForLayer()
                self.reloadLayerView()
                
                let alert = UIAlertController(title: "Message", message: "Data uploaded successfully", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                if self.sync_type == SYNC_LAYER_TYPE.MULTIPLE_LAYER_SYNC {
                    
                    self.sync_layerIDS.remove(at: 0)
                    
                   self.checkDataForSync()
                    
                }
                
            }
            
        }, onError:{ error in
            print(error!.localizedDescription)
            
            let alert = UIAlertController(title: "Message", message: error?.localizedDescription, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            self.allRecordsForSync.remove(at: 0)
            self.attachedDataArrayForSync.remove(at: 0)
            
            if self.allRecordsForSync.count > 0 {
                let layerObject = self.allRecordsForSync[0]
                let dic = ["layerId":pObject["layerId"]!,"features":[layerObject]] as [String : Any]
                self.syncLayersOnServer(pObject: dic,pImagesObject: self.attachedDataArrayForSync[0])
            }
        })
        
    }
    
    private func checkDataForSync() {
        
        if self.sync_layerIDS.count > 0 {
            let layerID = self.sync_layerIDS[0]
            self.syncDataForLayer(pLayerId: layerID)
        } else {
            SingletonClassSwift.sharedInstance.printOnConsole(pMessage: "All sync")
            self.goToSignInScreen()
        }
        
    }
    
    private func setSyncInauditLog(pObject: [String: Any],pLayerID:String) {
        
        let database = FMDatabase(url: SingletonClassSwift.sharedInstance.getDBPath())
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        
        do {
            
            print("UPDATE audit_log SET sync_status = 1 where layer_id = '\(pLayerID)' and row_id = '\(pObject["id"]!)'")
            
            try database.executeUpdate("UPDATE audit_log SET sync_status = 1 where layer_id = '\(pLayerID)' and row_id = '\(pObject["id"]!)'", values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
    }
    
    private func getDataForAll(pLayerId:String,pObject: [String: Any],pType:String) -> Array<GISDownloadedImage> {
        
        var attachedImagesForSync:Array<GISDownloadedImage> = []
        
        var layerPath:URL!
        var imageFolderPath:URL!
        var imagePath:URL!
        var imageSize:String!
        
        let imagesData = Layer_MultiMedia.getImagesOrDocumentsData(pRowId: "\(pObject["id"]!)", pLayerId: "\(pLayerId)",pDocumentType:pType)
        
        for object in imagesData {
            
            if let documentDirectory = SingletonClassSwift.sharedInstance.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                layerPath =  documentDirectory.appendingPathComponent("\(pLayerId)")
                
                if pType == "Image" {
                    
                    imageFolderPath =  layerPath.appendingPathComponent(IMAGES_FOLDER_NAME)
                    imagePath =  imageFolderPath.appendingPathComponent("\(object.name!)")
                    imageSize = imagePath.fileSizeString
                    
                    let objectImage = GISDownloadedImage(pName: object.name, pSize: imageSize, pPath: imagePath.path)
                    objectImage.type = "image"
                    
                    if let img = UIImage(contentsOfFile: imagePath.path) {
                        
                        if object.name?.fileExtension() == "jpg" || object.name?.fileExtension() == "jpeg" {
                            
                            
                            if let data:Data = img.jpegData(compressionQuality: IMAGE_COMPRESS_QUALITY) {
                                // Handle operations with data here...
                                objectImage.imageData = data
                            }
                            
                            
                        } else  if object.name?.fileExtension() == "png" {
                            
                            if let data:Data = img.pngData() {
                                // Handle operations with data here...
                                objectImage.imageData = data
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    attachedImagesForSync.append(objectImage)
                    
                } else if pType == "Document" {
                    
                    imageFolderPath =  layerPath.appendingPathComponent(DOCUMENTS_FOLDER_NAME)
                    imagePath =  imageFolderPath.appendingPathComponent("\(object.name!)")
                    imageSize = imagePath.fileSizeString
                    
                    let objectImage = GISDownloadedImage(pName: object.name, pSize: imageSize, pPath: imagePath.path)
                    objectImage.type = "document"
                    
                    do {
                        let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath!.path))
                        objectImage.imageData = fileData
                    } catch {
                        print("failed: \(error.localizedDescription)")
                    }
                    
                    
                    attachedImagesForSync.append(objectImage)
                    
                } else if pType == "Audio" {
                    
                    imageFolderPath =  layerPath.appendingPathComponent(AUDIO_FOLDER_NAME)
                    imagePath =  imageFolderPath.appendingPathComponent("\(object.name!)")
                    imageSize = imagePath.fileSizeString
                    
                    let objectImage = GISDownloadedImage(pName: object.name, pSize: imageSize, pPath: imagePath.path)
                    objectImage.type = "audio"
                    
                    do {
                        let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath!.path))
                        objectImage.imageData = fileData
                    } catch {
                        print("failed: \(error.localizedDescription)")
                    }
                    
                    
                    attachedImagesForSync.append(objectImage)
                    
                } else if pType == "Video" {
                    
                    imageFolderPath =  layerPath.appendingPathComponent(VIDEO_FOLDER_NAME)
                    imagePath =  imageFolderPath.appendingPathComponent("\(object.name!)")
                    imageSize = imagePath.fileSizeString
                    
                    let objectImage = GISDownloadedImage(pName: object.name, pSize: imageSize, pPath: imagePath.path)
                    objectImage.type = "video"
                    
                    do {
                        let fileData = try Data.init(contentsOf: URL(fileURLWithPath:imagePath!.path))
                        objectImage.imageData = fileData
                    } catch {
                        print("failed: \(error.localizedDescription)")
                    }
                    
                    
                    attachedImagesForSync.append(objectImage)
                    
                }
                
                
                
                
            }
            
        }
        
        if imagesData.count == 0 {
            // no image
            let objectImage = GISDownloadedImage(pName: "No Data", pSize: "", pPath: "")
            attachedImagesForSync.append(objectImage)
        }
        
        return attachedImagesForSync
        
    }
    
    private func deleteDataForLayer() {
        
        let currentLayer = self.layersArray[self.layerSelectedRow]
        
        // remove layer folder from directory includes images, audio, docs and videos
        let filemanager = FileManager.default
        
        do {
            
            let fileManager = FileManager.default
            if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let layerFolderPath =  tDocumentDirectory.appendingPathComponent("\(currentLayer.id!)")
                print("deleted \(layerFolderPath)")
                try filemanager.removeItem(atPath: layerFolderPath.path)
                
            }
        } catch {
            NSLog("Couldn't delete layer folder")
        }
        
        // delete data_ layer table
        Layer.deleteLayerTable(pLayerId: currentLayer.id!)
        
        // delete style data
        Layer_Style.delete_Style_Record(pLayerId: currentLayer.id!)
        
        // delete multimedia data
        Layer_MultiMedia.delete_MultiMedias_Record(pLayerId: currentLayer.id!)
        
        // delete entry from layer field data
        Layer_Field.deleteLayerFieldsData(pLayerID: currentLayer.id!)
        
        // delete entry from layer table
        Layer.deleteLayer_Table_Record(pLayerId: currentLayer.id!)
        
        print("all things deleted for layer \(currentLayer.id!)")
        
    }
    
    @objc func btnSettingPressed(sender:UIButton) {
        
        let vc = GISSettingsViewController()
        
        let navCtrl = UINavigationController(rootViewController: vc)
        navCtrl.navigationBar.backgroundColor = UIColor.white
        navCtrl.isNavigationBarHidden = true
        navCtrl.navigationBar.isTranslucent = false
        navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        navCtrl.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
        navCtrl.popoverPresentationController?.sourceView = sender
        navCtrl.popoverPresentationController?.sourceRect = sender.bounds
        
        self.present(navCtrl, animated: true, completion: nil)
        
    }
    
    @objc func btnLogOutPressed(sender:UIButton) {
        
        let alert = UIAlertController(title: "Message", message: "Select Option", preferredStyle:
            .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler:{ (UIAlertAction)in
            
            self.goToSignInScreen()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Logout & Exit", style: .default, handler:{ (UIAlertAction)in
            
            self.sync_layerIDS = Layer.getLayersIdsOfUnsynchRecords()
            
            SingletonClassSwift.sharedInstance.printOnConsole(pMessage: self.sync_layerIDS)
            
            if self.sync_layerIDS.count > 0 {
                let layerID = self.sync_layerIDS[0]
                self.syncDataForLayer(pLayerId: layerID)
            } else {
                self.goToSignInScreen()
            }
            
            
            
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
            
        }))
        
        self.present(alert, animated: true, completion:nil)
 
        
    }
    
    // my tracks
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn == true){
            print("on")
            
            let alert = UIAlertController(title: "Enter your track name", message: "", preferredStyle:
                .alert)
            
            alert.addTextField(configurationHandler: configurationTextField)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler:{ (UIAlertAction)in
                
                let trackNameTextField = alert.textFields![0] as UITextField
                
                
                SingletonClassSwift.sharedInstance.locationTrackStarted = true
                
                SingletonClassSwift.sharedInstance.locationManager.startUpdatingLocation()
                SingletonClassSwift.sharedInstance.currentTrack = nil
                SingletonClassSwift.sharedInstance.currentTrack = MyTrack(pId: "", pTrack_name: trackNameTextField.text!, pTrack_GeomInString:"",pTrackVisibility:"0")
                
                
                // add 1st location
                SingletonClassSwift.sharedInstance.currentTrack.trackGeom.append(SingletonClassSwift.sharedInstance.locationManager.location!)
                // start timer for 30 seconds
                SingletonViewControllerClassSwift.shared.timer = Timer.scheduledTimer(timeInterval: TimeInterval(TIMER_INTERVAL_FOR_TRACK_LOCARIONS), target: SingletonViewControllerClassSwift.shared, selector: #selector(SingletonViewControllerClassSwift.shared.getLocationsInIntervals), userInfo: nil, repeats: true)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                sender.setOn(false, animated: true)
                
            }))
            
            self.present(alert, animated: true, completion:nil)
        }
        else{
            print("off")
            
            if SingletonClassSwift.sharedInstance.locationTrackStarted == true {
                
                SingletonClassSwift.sharedInstance.locationTrackStarted = false
                SingletonClassSwift.sharedInstance.locationManager.stopUpdatingLocation()
                
                print("all locations \(SingletonClassSwift.sharedInstance.currentTrack.trackGeom)")
                
                MyTrack.insertTrackInDatabase()
                
                self.reloadMyTrackView(reloadedFromTop: false)
                
            }
        }
    }*/
    
  /*  @objc func btnShowHideLayerPressed(sender:UIButton) {
        
        let mainViewController = sideMenuController!
        let nav = mainViewController.rootViewController as! NavigationController
        let vc = nav.visibleViewController as! GISViewController
        
        if sender.imageView?.image == UIImage(named: "btnShowLayer") {
            // hide layer on map
            let allFeaturesData = Layer.getLoadFeaturesData(pLayerId: String(sender.tag))
            print(allFeaturesData)
            
            // if data then call on map
            if allFeaturesData.count > 0 {
                vc.executeShowHideLayersFunction(pType: JS_PARAMETER_TYPE_LAYER, pShow: false, pLayerId: String(sender.tag))
                Layer.updateLayerVisibilityInDatabase(pLayerId: String(sender.tag), pVisibility: 0)
            }
            
            sender.setImage(UIImage(named: "hideLayerIcon"), for: .normal)
            
            let layerObject = self.layersArray.filter{ $0.id == String(sender.tag) }.first
            layerObject?.layer_visibility = "0"
            
            
        } else {
            // show layer on map
            let allFeaturesData = Layer.getLoadFeaturesData(pLayerId: String(sender.tag))
            print(allFeaturesData)
            
            // if data then call on map
            if allFeaturesData.count > 0 {
                vc.executeShowHideLayersFunction(pType: JS_PARAMETER_TYPE_LAYER, pShow: true, pLayerId: String(sender.tag))
                Layer.updateLayerVisibilityInDatabase(pLayerId: String(sender.tag), pVisibility: 1)
            }
            
            sender.setImage(UIImage(named: "btnShowLayer"), for: .normal)
            
            let layerObject = self.layersArray.filter{ $0.id == String(sender.tag) }.first
            layerObject?.layer_visibility = "1"
        }
        
        
    }*/
    
    /*
    @objc func btnShowHideExternalLayerPressed(sender:UIButton) {
        
        let mainViewController = sideMenuController!
        let nav = mainViewController.rootViewController as! NavigationController
        let vc = nav.visibleViewController as! GISViewController
        
        if sender.imageView?.image == UIImage(named: "btnShowLayer") {
            // hide layer on map

            let object = ExternalLayer.getExternalLayerWithID(pLayerId: String(sender.tag))
            vc.executeShowHideExternalLayersFunction(pShow: false, pName: object!.name!, pTitle: object!.title!, pUrl: object!.url!)
            ExternalLayer.updateLayerVisibilityInDatabase(pLayerId: String(sender.tag), pVisibility: 0)
            
            sender.setImage(UIImage(named: "hideLayerIcon"), for: .normal)
            object?.layer_visibility = "0"
            
            
        } else {
            // show layer on map

            let object = ExternalLayer.getExternalLayerWithID(pLayerId: String(sender.tag))
            vc.executeShowHideExternalLayersFunction(pShow: true, pName: object!.name!, pTitle: object!.title!, pUrl: object!.url!)
            ExternalLayer.updateLayerVisibilityInDatabase(pLayerId: String(sender.tag), pVisibility: 1)

            sender.setImage(UIImage(named: "btnShowLayer"), for: .normal)
            
            object?.layer_visibility = "1"
        }
        
        
    }
    
    @objc func btnShowHideTrackPressed(sender:UIButton) {
        
        let mainViewController = sideMenuController!
        let nav = mainViewController.rootViewController as! NavigationController
        let vc = nav.visibleViewController as! GISViewController
        
        if sender.imageView?.image == UIImage(named: "btnShowLayer") {
            // hide track on map
            let selectedTrack = MyTrack.getSelectedTrackFromDatabase(pTrackId: String(sender.tag))
            vc.executeShowHideMyTracksFunction(pTrack: selectedTrack, pType: JS_PARAMETER_TYPE_TRACK, pShow: false)
            
            MyTrack.updateTrackVisibilityInDatabase(pTrackId: String(sender.tag), pVisibility: 0)
            
            sender.setImage(UIImage(named: "hideLayerIcon"), for: .normal)
            
            let trackObject = self.tracksArray.filter{ $0.id == String(sender.tag) }.first
            trackObject?.visibility = "0"
        } else {
            // show track on map
            let selectedTrack = MyTrack.getSelectedTrackFromDatabase(pTrackId: String(sender.tag))
            vc.executeShowHideMyTracksFunction(pTrack: selectedTrack, pType: JS_PARAMETER_TYPE_TRACK, pShow: true)
            
            MyTrack.updateTrackVisibilityInDatabase(pTrackId: String(sender.tag), pVisibility: 1)
            
            sender.setImage(UIImage(named: "btnShowLayer"), for: .normal)
            
            let trackObject = self.tracksArray.filter{ $0.id == String(sender.tag) }.first
            trackObject?.visibility = "1"
        }
    }
    
    private func showUpdatedLayersOnMap() {
        
        var currentLayersArray = SingletonClassSwift.sharedInstance.getDataForKey(strKey: LAYERS__STYLE_UPDATED_KEY) as? [String]
        
        if currentLayersArray != nil {
            
            let mainViewController = sideMenuController!
            let nav = mainViewController.rootViewController as! NavigationController
            let vc = nav.visibleViewController as! GISViewController
            
            for id in currentLayersArray! {
                vc.executeAddLayerFunction(pType: JS_PARAMETER_TYPE_LAYER, pLayerId: id)
            }
           
            currentLayersArray?.removeAll()
            SingletonClassSwift.sharedInstance.setData(strData: currentLayersArray, strKey: LAYERS__STYLE_UPDATED_KEY)
        }
        
    }
    
    private func enableLayersButtons() {
        
        if self.enabledAllLayersButtons == false {
            
            let layerView = self.scrollView.view(withId: "\(CREATE_LAYER_TAG)")
            let settingView = layerView?.view(withId: "12345")
            
            let buttonImages = ["sidepanelLayerEditEditLayerBlue", "sidepanelLayerEditTableBlue", "sidepanelLayerEditdeleteBlue", "sidepanelLayerEditStyleBlue", "sidepanelLayerEditShareBlue", "sidepanelLayerEditSyncBlue"]
            
            for index in 1...6 {
                
                let btn = settingView!.view(withId: "\(index)") as! UIButton
                btn.isEnabled = true
                
                let img = settingView!.view(withId: "\(200 + index)") as! UIImageView
                img.image = UIImage(named: buttonImages[index-1])
                
                let label = settingView!.view(withId: "\(300 + index)") as! UILabel
                label.textColor = blueTextColor
                
            }
            
            self.enabledAllLayersButtons = true
        }
        
    }
    
    private func goToSignInScreen() {
        
        let vc = GISSignInViewController()
        vc.screenEntry = .APP_START
        
        let navCtrl = UINavigationController(rootViewController: vc)
        navCtrl.navigationBar.backgroundColor = UIColor.white
        navCtrl.isNavigationBarHidden = true
        navCtrl.navigationBar.isTranslucent = false
        //navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        navCtrl.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
        navCtrl.modalPresentationStyle = .fullScreen
//        navCtrl.popoverPresentationController?.sourceView = sender
//        navCtrl.popoverPresentationController?.sourceRect = sender.bounds
        
        self.present(navCtrl, animated: true, completion: nil)
        
    }
 
    */
    
    // MARK: - UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return self.layersArray.count
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return SIDE_PANEL_LABEL_CELL_HEIGHT
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
            // layers
        let cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: "cell")) as? UITableViewCell)!
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none

        cell.textLabel?.text = self.layersArray[0]
        
//            let menuObj = self.layersArray[indexPath.row]
//            cell.lblName.text = menuObj.layer_name
//
//            self.setLayerIcons(cell: cell, pLayer: menuObj)
//
//            if indexPath.row == self.layerSelectedRow {
//                cell.lblName.font = UIFont(name: HEADER_LABEL_FONT_NAME, size: 20)
//            } else {
//                cell.lblName.font = sidePanelTextsFont
//            }
//
//            // visibility
//            if menuObj.layer_visibility == "1" {
//                cell.buttonShowLayer.setImage(UIImage(named: "btnShowLayer"), for: .normal)
//            } else {
//                cell.buttonShowLayer.setImage(UIImage(named: "hideLayerIcon"), for: .normal)
//            }
//
//            cell.buttonShowLayer.tag = Int(menuObj.id!)!
//            cell.buttonShowLayer.frame = CGRect(x: Int(Int(layerTableView.frame.size.width) - smallIconsSize - plsuIcon_Padding) - 10, y: -10, width: smallIconsSize + 20, height: smallIconsSize + 15)
//            cell.buttonShowLayer.addTarget(self, action: #selector(btnShowHideLayerPressed(sender:)), for: .touchUpInside)
            
            return cell
            
      
        
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vcSplash = GISSplashScreenViewControllerSwift()
        let myNavigationController = NavigationController(rootViewController: vcSplash)
        myNavigationController.navigationBar.isHidden = true
        myNavigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        let window = UIApplication.shared.delegate!.window!!
        window.rootViewController = myNavigationController
        
       
    }
    
    //MARK:- Others
   
    
}

/*
extension LeftViewController: ExpyTableViewDelegate {
    
    // MARK: tableview delegate
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
        if state.rawValue == ExpyState.didExpand.rawValue {
            print("expanded")
            let tableViewContentHeight = self.externalLayerTableView.contentSize.height;
            print(tableViewContentHeight)
            self.reloadExternalLayerView(fromTop: false)
        } else if state.rawValue == ExpyState.didCollapse.rawValue {
            print("collapsed")
            let tableViewContentHeight =  self.externalLayerTableView.contentSize.height;
            print(tableViewContentHeight)
            self.reloadExternalLayerView(fromTop: false)
        }
        
    }
    
    
    
    
}

class SidePanelLayerTableViewCell: UITableViewCell {
    
    private let smallIconsSize = 24
    private let label_Height = 22
    private let sidePanelPadding_X = 15
    
    let imgLayerIcon : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imgView.image = UIImage(named: "imgLayerIcon")
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .center
        return imgView
    }()
    
    
    
    var lblName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: APP_FONT_NAME, size: 17)
        label.textColor = labelTextColor
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        
        return label
        
    }()
    
    var buttonShowLayer : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "hideLayerIcon"), for: .normal)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.imgLayerIcon.frame = CGRect(x: 0, y: 0, width: smallIconsSize, height: smallIconsSize)
        
        
        self.lblName.frame = CGRect(x: CGFloat(15 + smallIconsSize), y: 0.0, width: self.frame.size.width - 80.0 - CGFloat((sidePanelPadding_X + smallIconsSize + 20)), height: CGFloat(label_Height))
        
        addSubview(imgLayerIcon)
        addSubview(lblName)
        addSubview(buttonShowLayer)
        
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

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    
}

extension UIImage {
    func imageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
*/
