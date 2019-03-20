//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var loginModel = LoginModel()
    
    func Login(onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        
        if loginModel.userName == "" {
            onFailure("Username is empty")
            return
        } else if loginModel.password == "" {
            onFailure("Password is empty")
            return
        } else {
            let parameter = ["email": loginModel.userName, "password": loginModel.password]
            APIManager.sharedInstance.postData(apiName: APIConstants.login, parameter: parameter , onSuccess: { (data) in
                
                let resultDict = Utilities.getJSON(APIConstants.login, data)
                let statusCode = resultDict["status"] as! Int
//                let message = resultDict["message"] as! String
                let userMessage = resultDict["user_msg"] as! String
                
                if statusCode == 200 {
                    
                    let data = resultDict["data"] as! [String: Any]
                    let accessToken = data["access_token"] as! String
                    let email = data["email"] as! String
                    print(data)
                    
                    
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: email, accessGroup: KeychainConfiguration.accessGroup)

                    do {
                        // Save the password for the new item.
                        try passwordItem.savePassword(accessToken)
                    } catch {
                        print(error.localizedDescription)
                    }
                    onSuccess()
                    
                } else {
                    onFailure(userMessage)
                    return
                }
                
            }) { (error) in
                onFailure(error.localizedDescription)
                return
            }
        }
        
        
    }
    
    
    
}
