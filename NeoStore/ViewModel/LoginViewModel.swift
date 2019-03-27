//
//  LoginViewModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var userModel: UserModel!
    
    func Login(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.login, parameter: parameter , onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let loginModel = try jsonDecoder.decode(LoginModel.self, from: data)
                
                if loginModel.status! == 200 {
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
}
