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
        loginViewModel.Login(self, onSuccess: {
            print("SUCCESS")
        }) {
            print("FAILURE")
        }
        
    }
    
    @IBAction func actionForgot(_ sender: UIButton) {
        
    }
    
    @IBAction func actionNewAccount(_ sender: UIButton) {
        
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
