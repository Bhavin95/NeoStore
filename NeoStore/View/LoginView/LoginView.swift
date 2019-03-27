//
//  LoginView.swift
//  NeoStore
//
//  Created by webwerks on 18/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var textFieldUserName: CustomUITextField!
    @IBOutlet weak var textFieldPassword: CustomUITextField!
    
    //MARK: Constants and Variable
    
    private var loginViewModel = LoginViewModel()
    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: Functions
    
    func saveCredentials() {
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: loginViewModel.userModel.email!, accessGroup: KeychainConfiguration.accessGroup)
        
        do {
            // Save the password for the new item.
            try passwordItem.savePassword(loginViewModel.userModel.access_token!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Actions
    
    @IBAction func actionLogin(_ sender: UIButton) {
        textFieldUserName.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            loginViewModel.Login(parameter: ["email": self.textFieldUserName.text!, "password": self.textFieldPassword.text!], onSuccess: {
                print("SUCCESS")
                self.removeSpinner()
//                self.saveCredentials()
            }, onFailure: { (error) in
                print("FAILURE")
                self.removeSpinner()
                self.alert(message: error, title: "")
            })
        }
    }
    
    @IBAction func actionForgot(_ sender: UIButton) {
        
    }
    
    @IBAction func actionNewAccount(_ sender: UIButton) {
        let registerView = RegisterView()
        navigationController?.pushViewController(registerView, animated: true)
        
    }
    
}

