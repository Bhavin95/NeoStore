//
//  CartListViewModel.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CartListViewModel: NSObject {
    
    var cartList: [CartModel]?
    var cartListModel: CartListModel!
    
    func getCartList(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.listCart, parameter: parameter, onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                self.cartListModel = try jsonDecoder.decode(CartListModel.self, from: data)
                
                if self.cartListModel.status! == APIConstants.statusCode {
                    guard let data = self.cartListModel.data else  {
                        onFailure(self.cartListModel.user_msg!)
                        return
                    }
                    self.cartList = data
                    onSuccess()
                    return
                } else {
                    onFailure(self.cartListModel.user_msg!)
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
    
    func editCart(parameter:[String:Any], onSuccess: @escaping(String) -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.editCart, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.editCart, data)
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
            onFailure(error)
            return
        }
    }
    
    func deleteCart(parameter:[String:Any], onSuccess: @escaping(String) -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.postData(apiName: APIConstants.deleteCart, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.deleteCart, data)
            let statusCode = resultDict["status"] as! Int
            let userMessage = resultDict["user_msg"] as! String
            if statusCode == APIConstants.statusCode {
                onSuccess(userMessage)
                return
            } else {
                onFailure(userMessage)
                return
            }
        }) { (error) in
            onFailure(error)
            return
        }
    }
    
    func getCartListCount() -> Int {
        if cartList != nil {
            return cartList!.count
        } else {
            return 0
        }
        
    }
    
    func getProductId(index: Int) -> Int {
        return cartList![index].product_id!
    }
    
    func getProductImage(index: Int) -> String {
        return cartList![index].product.product_images!
    }
 
    func getProductName(index: Int) -> String {
        return cartList![index].product.name!
    }
    
    func getProductCategoryName(index: Int) -> String {
        return cartList![index].product.product_category!
    }
    
    func getProductCost(index: Int) -> Int {
        return cartList![index].product.cost!
    }
    
    func getProductQuantity(index: Int) -> Int {
        return cartList![index].quantity!
    }
    
    func deleteProduct(index: Int) {
        cartList!.remove(at: index)
    }
    
    func editProductQuantity(index: Int, quantity: Int) {
        cartList![index].quantity = quantity
    }
}
