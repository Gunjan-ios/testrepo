//
//  GISSignInViewController.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//



import UIKit

enum ENTER_CRITERIA {
    case APP_START
    case APP_LEFT_PANEL
}

class GISSignInViewController: UIViewController, UITextFieldDelegate {
    
    private var stackView:UIView!
    
    private var emailTextField:InputTextField!
    private var passwordTextField:InputTextField!
    
    private var signInButton:UIButton!
    private var rememberMeButton:UIButton!
    private var forgotPasswordButton:UIButton!
   // private var signUpButton:UIButton!
    private var showHidePasswordButton:UIButton!
    
    private var imgCheckbox:UIImageView!
    private var isRememberMe = false
    private var isShowPassword = false
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    
    var screenEntry:ENTER_CRITERIA!
    var myNavigationController:NavigationController?
    var vcKhadiStore:KhadiStoreListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        if self.screenEntry == ENTER_CRITERIA.APP_LEFT_PANEL {
//            self.loadHeaderView()
//        }
        // Do any additional setup after loading the view.
        self.loadHeaderView()

        
//        New chnages For testing 
       

    }
    
    func loadHeaderView() {
        
        headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + SingletonClassSwift.sharedInstance.iPhone_X_Top_Padding), width: Int(UIScreen.main.bounds.width), height: 60));
        headerview.backgroundColor = UIColor.white
        self.view.addSubview(headerview)
        
        self.buttonBack = UIButton(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        self.buttonBack.setTitle("Back", for: .normal)
        self.buttonBack.setTitleColor(blueTextColor, for: .normal)
        self.buttonBack.contentHorizontalAlignment = .left
        self.buttonBack.backgroundColor = UIColor.clear
        self.buttonBack.addTarget(self, action: #selector(btnBackPressed(sender:)), for: .touchUpInside)
        headerview.addSubview(self.buttonBack)
        self.initDesign()
    }
    
    private func initDesign() {
        
        let imgLogo = UIImageView(frame: CGRect(x: 0, y: headerview.frame.maxY , width: 229, height: 94))
        imgLogo.backgroundColor = UIColor.gray
        imgLogo.image = UIImage(named: "khadiIndiaLogo")
        imgLogo.center = CGPoint(x: self.view.center.x, y: imgLogo.frame.origin.y + (imgLogo.frame.size.height/2))
        self.view.addSubview(imgLogo)
        
        var yPosition = Int(headerview.frame.maxY)
        
        printOn(pMessage: yPosition)
//        if self.screenEntry == ENTER_CRITERIA.APP_LEFT_PANEL {
//            yPosition = 60
//        }
        
        self.view.backgroundColor = UIColor.white
        
        stackView = UIView(frame: CGRect(x: X_PADDING, y: yPosition, width: SCREEN_WIDTH - (X_PADDING*2), height: 300))
        stackView.backgroundColor = UIColor.clear
        self.view.addSubview(stackView)
        
//        yPosition = 0
        
        self.emailTextField = InputTextField(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_TEXTFIELD_HEIGHT))
        self.emailTextField.placeholder = "Email"
        self.emailTextField.text = "inspector1"
        self.emailTextField.delegate = self as UITextFieldDelegate
        self.emailTextField.returnKeyType = .done
        self.emailTextField.keyboardType = .emailAddress
        stackView.addSubview(self.emailTextField)
        
        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20
        
        self.passwordTextField = InputTextField(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_TEXTFIELD_HEIGHT))
        self.passwordTextField.placeholder = "Password"
        self.passwordTextField.text = "kvic"
        self.passwordTextField.delegate = self as UITextFieldDelegate
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.returnKeyType = .done
        stackView.addSubview(self.passwordTextField)
        
        self.showHidePasswordButton = UIButton(frame: CGRect(x: Int(stackView.frame.size.width) - 40, y: yPosition - 5, width: 40, height: 40))
        self.showHidePasswordButton.backgroundColor = UIColor.clear
        self.showHidePasswordButton.contentHorizontalAlignment = .center
        self.showHidePasswordButton.setImage(UIImage(named: "hidePasswordIcon"), for: .normal)
        self.showHidePasswordButton.addTarget(self, action: #selector(showHidePassword(sender:)), for: .touchUpInside)
        stackView.addSubview(self.showHidePasswordButton)
        
        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20
        
        imgCheckbox = UIImageView(frame: CGRect(x: 0, y: yPosition + 4, width: 24, height: 24))
        imgCheckbox.image = UIImage(named: "deselectedCheckbox")
        stackView.addSubview(imgCheckbox)
        
        self.rememberMeButton = UIButton(frame: CGRect(x: 0, y: yPosition, width: 120, height: CUSTOM_TEXTFIELD_HEIGHT))
        self.rememberMeButton.backgroundColor = UIColor.clear
        self.rememberMeButton.setTitleColor(labelTextColor, for: .normal)
        self.rememberMeButton.contentHorizontalAlignment = .right
        self.rememberMeButton.titleLabel?.font = UIFont(name: APP_FONT_NAME, size: SMALL_BUTTON_FONT_SIZE)
        self.rememberMeButton.setTitle("Remember Me", for: .normal)
        self.rememberMeButton.addTarget(self, action: #selector(rememberMePressed(sender:)), for: .touchUpInside)
        stackView.addSubview(self.rememberMeButton)
        
        self.forgotPasswordButton = UIButton(frame: CGRect(x: Int(stackView.frame.size.width) - 130, y: yPosition, width: 130, height: CUSTOM_TEXTFIELD_HEIGHT))
        self.forgotPasswordButton.backgroundColor = UIColor.clear
        self.forgotPasswordButton.setTitleColor(labelTextColor, for: .normal)
        self.forgotPasswordButton.contentHorizontalAlignment = .right
        self.forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        self.forgotPasswordButton.titleLabel?.font = UIFont(name:APP_FONT_NAME, size: SMALL_BUTTON_FONT_SIZE)
        self.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordPressed(sender:)), for: .touchUpInside)
        stackView.addSubview(self.forgotPasswordButton)
        self.forgotPasswordButton.isHidden = true
        
        yPosition += CUSTOM_TEXTFIELD_HEIGHT + 20
        
        self.signInButton = CustomButton(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_BUTTON_HEIGHT))
        self.signInButton.backgroundColor = UIColor.clear
        self.signInButton.setTitle("SIGN IN", for: .normal)
        self.signInButton.addTarget(self, action: #selector(signInPressed(sender:)), for: .touchUpInside)
        stackView.addSubview(self.signInButton)
        
        yPosition += (CUSTOM_BUTTON_HEIGHT + 20)
        
//        self.signUpButton = UIButton(frame: CGRect(x: 0, y: yPosition, width: Int(stackView.frame.size.width), height: CUSTOM_TEXTFIELD_HEIGHT))
//        self.signUpButton.backgroundColor = UIColor.clear
//        self.signUpButton.setTitleColor(labelTextColor, for: .normal)
//        self.signUpButton.setTitle("Don't have an account? Sign up", for: .normal)
//        self.signUpButton.titleLabel?.font = UIFont(name:APP_FONT_NAME, size: SMALL_BUTTON_FONT_SIZE)
//        self.signUpButton.addTarget(self, action: #selector(signUpPressed(sender:)), for: .touchUpInside)
//        stackView.addSubview(self.signUpButton)
        
        stackView.frame.size.height = CGFloat(yPosition + CUSTOM_TEXTFIELD_HEIGHT)
        stackView.center = self.view.center
        
    }
    
    //MARK: action
    @objc func signInPressed(sender:UIButton) {
        
        if (self.emailTextField.text == "") {
            self.displayAlertMessage(pMessage: "Please Enter Email")
            return
        } else if (self.passwordTextField.text == "") {
            self.displayAlertMessage(pMessage: "Please Enter Password")
            return
        }
//        } else if (!(self.isValidEmail(emailStr: self.emailTextField.text!))) {
//            self.displayAlertMessage(pMessage: "Please Enter Valid Email")
//            return
//        }
        
        
//        if self.emailTextField.text! == "Admin@gmail.com" && self.passwordTextField.text! == "admin" {
//            // admin
//            SingletonClassSwift.sharedInstance.setData(strData: false, strKey: IS_SURVEYOR_KEY)
//        } else {
//            // surveyor
//            SingletonClassSwift.sharedInstance.setData(strData: true, strKey: IS_SURVEYOR_KEY)
//        }
        GISWebServicesManager.signInWS(userName: self.emailTextField.text!, password: self.passwordTextField.text!, appType: "survey_app",onCompletion: { response in
            

            self.printOn(pMessage: response!["success"])
            
            if response!["success"] == true {
                
                GISWebServicesManager.getStoresData(onCompletion: { response in
                            SingletonClassSwift.hideLoading()
                               if response!["success"] == true {
                                   
                                   let data = response!["data"].array

                                               self.printOn(pMessage: data)
                                               
                                               self.vcKhadiStore = KhadiStoreListViewController()
                                               self.vcKhadiStore?.arrayStoreLists = data
                                               self.vcKhadiStore?.emailId = self.emailTextField.text!
                                               self.vcKhadiStore?.password = self.passwordTextField.text!
                                               self.navigationController?.pushViewController(self.vcKhadiStore!, animated: true)
                                   
                               } else {
                       
                               }

                           },onError:{ error in
                               if error != nil {
                               }
                           })
            } else {
                self.displayAlertMessage(pMessage: response!["message"].string!)
//                self.printOn(pMessage: response!["message"])
            }

        },onError:{ error in
            
            if error != nil {
                self.displayAlertMessage(pMessage: "Something went wrong. ")
            }
            
        })
        
    
        
//        let oldUserName = SingletonClassSwift.sharedInstance.getDataForKey(strKey: USERNAME_KEY) as? String
//
//        if oldUserName == nil {
//            // first time
//            self.saveUserData()
//            self.goToNextScreen()
//            return
//        }
    
     //   self.goToNextScreen()
        
    }
    
    @objc func forgotPasswordPressed(sender:UIButton) {
        
    }
        
    @objc func rememberMePressed(sender:UIButton) {
        
        if (self.isRememberMe == true) {
            self.imgCheckbox.image = UIImage(named: "deselectedCheckbox")
            self.isRememberMe = false
            SingletonClassSwift.sharedInstance.setData(strData: false, strKey: REMEMBER_ME_KEY)
        } else {
            self.imgCheckbox.image = UIImage(named: "selectedCheckbox")
            self.isRememberMe = true
        }
    }
    
     @objc func showHidePassword(sender:UIButton) {
        
        if (self.isShowPassword == true) {
            self.showHidePasswordButton.setImage(UIImage(named: "hidePasswordIcon"), for: .normal)
            self.passwordTextField.isSecureTextEntry = true
            self.isShowPassword = false
        } else {
            self.showHidePasswordButton.setImage(UIImage(named: "showPasswordIcon"), for: .normal)
            self.passwordTextField.isSecureTextEntry = false
            self.isShowPassword = true
        }
        
    }
    
    @objc func btnBackPressed(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func saveUserData() {
        
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        
        SingletonClassSwift.sharedInstance.setData(strData: self.isRememberMe, strKey: REMEMBER_ME_KEY)
        SingletonClassSwift.sharedInstance.setData(strData: self.emailTextField.text!, strKey: USERNAME_KEY)
        SingletonClassSwift.sharedInstance.setData(strData: self.passwordTextField.text!, strKey: PASSWORD_KEY)
        
        
        let isSurveyor = SingletonClassSwift.sharedInstance.getDataForKey(strKey: IS_SURVEYOR_KEY) as? Bool
        SingletonClassSwift.sharedInstance.IS_USER_SURVEYOR = isSurveyor
    }
    
    private func goToNextScreen() {

        self.vcKhadiStore = KhadiStoreListViewController()

        self.navigationController?.pushViewController(self.vcKhadiStore!, animated: true)
        
//        self.myNavigationController = NavigationController(rootViewController: self.vcKhadiStore!)
//        self.myNavigationController?.navigationBar.isHidden = true
//        self.myNavigationController?.interactivePopGestureRecognizer?.isEnabled = false
//
//        let mainViewController = MainViewController()
//        mainViewController.isLeftViewStatusBarHidden = false
//        mainViewController.rootViewController = myNavigationController
//        mainViewController.myVTVNavigarionController = myNavigationController
//        mainViewController.setup(type: UInt(1))
//        // mainViewController.setup(type: UInt(9))
//        mainViewController.sideMenuController?.isLeftViewSwipeGestureEnabled = false;
//
//        let window = UIApplication.shared.delegate!.window!!
//        window.rootViewController = mainViewController
        
    }
    
}

extension UIViewController {
    
    // MARK:- Common
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func displayAlertMessage(pMessage:String) {
        
       
        let alert = UIAlertController(title: "Message", message: pMessage, preferredStyle: .alert)
  
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion:nil)
        
    }
}

