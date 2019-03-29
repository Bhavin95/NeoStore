//
//  OrderListViewModel.swift
//  NeoStore
//
//  Created by webwerks on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class OrderListViewModel {
    
    var orderModel: [OrderModel]?
    
    func getOrderList(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.orderList, parameter: parameter, onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let orderList = try jsonDecoder.decode(OrderListModel.self, from: data)
                
                if orderList.status! == APIConstants.statusCode {
                    self.orderModel = orderList.data!
                    onSuccess()
                    return
                } else {
                    onFailure(orderList.user_msg!)
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
    
    func getOrderListCount() -> Int {
        if orderModel != nil {
            return (orderModel?.count)!
        } else {
            return 0
        }
    }
    
    func getOrderId(index: Int) -> Int {
        return orderModel![index].id!
    }
    
    func getOrderDate(index: Int) -> String {
        return orderModel![index].created!
    }
    
    func getOrderCost(index: Int) -> Int {
        return orderModel![index].cost!
    }
}
