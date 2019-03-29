//
//  ResetPasswordView.swift
//  NeoStore
//
//  Created by webwerks1 on 29/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ResetPasswordView: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var textFieldCurrentPassword: CustomUITextField!
    @IBOutlet weak var textFieldNewPassword: CustomUITextField!
    @IBOutlet weak var textFieldConfirmPassword: CustomUITextField!
    
    //MARK: Constants and Variable
    
    //MARK: Initialize
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = TitleConstants.resetPassword
        
    }

    //MARK: Functions
    
    func resetPassword() {
        
        if !(textFieldCurrentPassword.text!.isValidPassword()) {
            alert(message: "Current Password must contain atleast 6 characters", title: "")
            return
        }
        if !(textFieldNewPassword.text!.isValidPassword()) {
            alert(message: "New password must contain atleast 6 characters ", title: "")
            return
        }
        if !(textFieldConfirmPassword.text!.isValidPassword()) {
            alert(message: "Confirm password must contain atleast 6 characters ", title: "")
            return
        }
        if textFieldNewPassword.text! != textFieldConfirmPassword.text! {
            alert(message: "New password and Confirm password must be same", title: "")
            return
        }
        
        let parameter  = [ "old_password": textFieldCurrentPassword.text!,
                           "password": textFieldNewPassword.text!,
                           "confirm_password": textFieldConfirmPassword.text! ]
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            APIManager.sharedInstance.postData(apiName: APIConstants.changePassword, parameter: parameter, onSuccess: { (data) in
                let resultDict = Utilities.getJSON(APIConstants.changePassword, data)
                if let userMessage = resultDict["user_msg"] as? String {
                    print("SUCCESS")
                    self.removeSpinner()
                    self.alert(message: userMessage, title: "")
                    return
                }
            }) { (error) in
                print("Failure")
                self.removeSpinner()
                self.alert(message: error, title: "")
                return
            }
        }
        
    }
    
    //MARK: Actions
    
    @IBAction func actionResetPassword(_ sender: UIButton) {
        resetPassword()
    }
    
    
}
