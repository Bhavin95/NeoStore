//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct LoginViewModel {
    
    var loginModel = LoginModel()
    
    func Login(_ viewController: UIViewController ,onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        
        if loginModel.userName == "" {
            DispatchQueue.main.async {
                viewController.alert(message: "Username is empty", title: "")
            }
            return
        } else if loginModel.password == "" {
            DispatchQueue.main.async {
                viewController.alert(message: "Password is empty", title: "")
            }
            return
        } else {
            let parameter = ["email": loginModel.userName, "password": loginModel.password]
            APIManager.sharedInstance.postData(apiName: APIConstants.login, parameter: parameter , onSuccess: { (data) in
//                onSuccess(data)
                let resultDict = Utilities.getJSON(APIConstants.login, data)
                let statusCode = resultDict["status"] as! Int
//                let message = resultDict["message"] as! String
                let userMessage = resultDict["user_msg"] as! String
                
                if statusCode == 200 {
                    
                    let data = resultDict["data"] as! [String: Any]
                    let accessToken = data["access_token"] as! String
                    let email = data["email"] as! String
                    print(data)
                    
//                    let accessToken = data["access_token"]
                    
//                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: newAccountName, accessGroup: KeychainConfiguration.accessGroup)
//
//                    do {
//                        // Save the password for the new item.
//                        try passwordItem.savePassword(newPassword)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                    
                } else {
                    DispatchQueue.main.async {
                        viewController.alert(message: userMessage, title: "")
                    }
                    return
                }
                
            }) { (error) in
//                onFailure(error)
            }
        }
        
        
    }
    
    
    
}
