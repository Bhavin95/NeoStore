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
    
    lazy var loginViewModel = LoginViewModel()
    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldUserName.text = "tejas.mitna@neosofttech.com"
        textFieldPassword.text = "tejasm1234"
    }
    
    //MARK: Functions
    
    func saveCredentials() {
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: loginViewModel.userModel!.email!, accessGroup: KeychainConfiguration.accessGroup)
        
        do {
            // Save the password for the new item.
            try passwordItem.savePassword(loginViewModel.userModel!.access_token!)
            let homeView = HomeView()
            let navController = NavigationController(rootViewController: homeView)
            present(navController, animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func login() {
        
        if !(textFieldUserName.text!.isValidEmail()) {
            alert(message: "Email address is invalid", title: "")
            return
        }
        if !(textFieldPassword.text!.isValidPassword()) {
            alert(message: "Password must contain atleast 6 characters ", title: "")
            return
        }
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            loginViewModel.login(parameter: ["email": self.textFieldUserName.text!, "password": self.textFieldPassword.text!], onSuccess: {
                print("SUCCESS")
                self.removeSpinner()
                self.saveCredentials()
            }, onFailure: { (error) in
                print("FAILURE")
                self.removeSpinner()
                self.alert(message: error, title: "")
            })
        }
        
    }
    
    func forgotPassword(email: String) {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            loginViewModel.forgotPassword(parameter: ["email": email], onSuccess: {(success) in
                print("SUCCESS")
                self.removeSpinner()
                self.alert(message: success, title: "")
            }, onFailure: { (error) in
                print("FAILURE")
                self.removeSpinner()
                self.alert(message: error, title: "")
            })
        }
    }
    
    //MARK: Actions
    
    @IBAction func actionLogin(_ sender: UIButton) {
        login()
    }
    
    @IBAction func actionForgot(_ sender: UIButton) {
        alertWithEmailTextField(title: "Forgot Password", message: "") { (email) in
            self.forgotPassword(email: email)
        }
    }
    
    @IBAction func actionNewAccount(_ sender: UIButton) {
        let registerView = RegisterView()
        let navController = NavigationController(rootViewController: registerView)
        present(navController, animated: true, completion: nil)
        
    }
    
}

