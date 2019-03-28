//
//  MyAccountViewModel.swift
//  NeoStore
//
//  Created by webwerks1 on 28/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class MyAccountViewModel {

    var userDataModel: UserDataModel?
    
    func getUserData(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.fetchAccount, parameter: parameter , onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let userDetailModel = try jsonDecoder.decode(UserDetailModel.self, from: data)
                
                if userDetailModel.status! == APIConstants.statusCode {
                    self.userDataModel = userDetailModel.data!
                    onSuccess()
                    return
                } else {
                    onFailure(userDetailModel.user_msg!)
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
    
    func updateAccountDetails(parameter:[String:Any], onSuccess: @escaping(String) -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.updateAccount, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.updateAccount, data)
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
    
    func getFirstName() -> String {
        return userDataModel!.user_data!.first_name!
    }
    
    func getLastName() -> String {
        return userDataModel!.user_data!.last_name!
    }
    
    func getEmail() -> String {
        return userDataModel!.user_data!.email!
    }
    
    func getPhoneNo() -> String {
        return userDataModel!.user_data!.phone_no!
    }
    
    func getDateOfBirth() -> String {
        if let dob = userDataModel!.user_data!.dob {
            return dob
        }
        return ""
    }
    
}
