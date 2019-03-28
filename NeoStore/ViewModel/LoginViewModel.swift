//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var userModel: UserModel?
    
    func login(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.login, parameter: parameter , onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let loginModel = try jsonDecoder.decode(LoginModel.self, from: data)
                
                if loginModel.status! == APIConstants.statusCode {
                    self.userModel = loginModel.data!
                    onSuccess()
                    return
                } else {
                    onFailure(loginModel.user_msg!)
                    return
                }
            } catch {
                onFailure(error.localizedDescription)
                return
            }
        }) { (error) in
            onFailure(error.localizedDescription)
            return
        }
    }
    
    func forgotPassword(parameter:[String:Any], onSuccess: @escaping(String) -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.forgotPassword, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.forgotPassword, data)
            let statusCode = resultDict["status"] as! Int
            let userMessage = resultDict["user_msg"] as! String
            if statusCode == APIConstants.statusCode {
                onSuccess(userMessage)
                return
            } else {
                //                let message = resultDict["message"] as! String
                onFailure(userMessage)
                return
            }
        }) { (error) in
            onFailure(error.localizedDescription)
            return
        }
    }
}
