//
//  OrderListViewModel.swift
//  NeoStore
//
//  Created by webwerks on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class OrderListViewModel {
    
    var orderModel = [OrderModel]()
    var orderList: OrderListModel?
    
    func getOrderList(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.orderList, parameter: parameter, onSuccess: { (data) in
            do {
                let jsonDecoder  = JSONDecoder()
                let orderList = try jsonDecoder.decode(OrderListModel.self, from: data)
                
                if orderList.status! == 200 {
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
            onFailure(error.localizedDescription)
            return
        }
    }
}
