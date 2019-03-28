//
//  OrderDetailViewModel.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class OrderDetailViewModel {

    var orderDetailsModel: OrderModel?
    
    func getOrderDetail(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.orderDetail, parameter: parameter, onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let orderDetailsModel = try jsonDecoder.decode(OrderDetailsModel.self, from: data)
                
                if orderDetailsModel.status! == APIConstants.statusCode {
                    self.orderDetailsModel = orderDetailsModel.data
                    onSuccess()
                    return
                } else {
                    onFailure(orderDetailsModel.user_msg!)
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
    
    func getOrderListCount() -> Int {
        if orderDetailsModel != nil {
            return orderDetailsModel!.order_details!.count
        } else {
            return 0
        }
        
    }
    
    func getProductImage(index: Int) -> String {
        return orderDetailsModel!.order_details![index].prod_image!
    }
    
    func getProductName(index: Int) -> String {
        return orderDetailsModel!.order_details![index].prod_name!
    }
    
    func getProductCategoryName(index: Int) -> String {
        return orderDetailsModel!.order_details![index].prod_cat_name!
    }
    
    func getProductCost(index: Int) -> Int {
        return orderDetailsModel!.order_details![index].total!
    }
    
    func getProductQuantity(index: Int) -> Int {
        return orderDetailsModel!.order_details![index].quantity!
    }
    
}
