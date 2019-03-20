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
    
    //MARK: Actions
    
    @IBAction func actionLogin(_ sender: UIButton) {
        textFieldUserName.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        self.showSpinner(onView: self.view)
        loginViewModel.Login(onSuccess: {
            self.removeSpinner()
            print("SUCCESS")
        }, onFailure: { (error) in
            print("FAILURE")
            self.removeSpinner()
            self.alert(message: error, title: "")
        })
        
    }
    
    @IBAction func actionForgot(_ sender: UIButton) {
        
    }
    
    @IBAction func actionNewAccount(_ sender: UIButton) {
        let registerView = RegisterView()
        navigationController?.pushViewController(registerView, animated: true)
        
    }
    
}

//MARK: Extension

extension LoginView: UITextFieldDelegate {
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case textFieldUserName:
            loginViewModel.loginModel.userName = textField.text!
        case textFieldPassword:
            loginViewModel.loginModel.password = textField.text!
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
