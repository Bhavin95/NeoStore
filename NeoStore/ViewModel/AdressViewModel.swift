//
//  AdressViewModel.swift
//  NeoStore
//
//  Created by webwerks1 on 28/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class AddressViewModel {
    
    func placeOrder(parameter:[String:Any], onSuccess: @escaping(String) -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.order, parameter: parameter , onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let addressModel = try jsonDecoder.decode(AddressModel.self, from: data)
                
                if addressModel.status! == APIConstants.statusCode {
                    onSuccess(addressModel.user_msg!)
                    return
                } else {
                    onFailure(addressModel.user_msg!)
                    return
                }
            } catch {
                onFailure(error.localizedDescription)
                return
            }
        }) { (error) in
            onFailure(error)
            return
        }
    }
}
