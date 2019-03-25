//
//  CartListViewModel.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CartListViewModel: NSObject {
    
    var cartList = [CartModel]()
    
    func getCartList(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.listCart, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.listCart, data)
            let statusCode = resultDict["status"] as! Int
            
            if statusCode == 200 {
                do {
                    let jsonDecoder  = JSONDecoder()
                    let cartListModel = try jsonDecoder.decode(CartListModel.self, from: data)
                    self.cartList = cartListModel.data
                    onSuccess()
                    return
                    
                } catch {
                    onFailure(error.localizedDescription)
                }
                
            } else {
                //                let message = resultDict["message"] as! String
                let userMessage = resultDict["user_msg"] as! String
                onFailure(userMessage)
                return
            }
        }) { (error) in
            onFailure(error.localizedDescription)
            return
        }
    }
}
