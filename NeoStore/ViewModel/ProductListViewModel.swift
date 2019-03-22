//
//  ProductListViewModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ProductListViewModel {

    var productList = [ProductModel]()
    
    func getProductList(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.productList, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.login, data)
            let statusCode = resultDict["status"] as! Int
            
            if statusCode == 200 {
                do {
                    let jsonDecoder  = JSONDecoder()
                    let productListModel = try jsonDecoder.decode(ProductListModel.self, from: data)
                    self.productList = productListModel.data
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
    
    func getProductCount() -> Int {
        return productList.count
    }
    
    func getProductID(index: Int) -> Int {
        return productList[index].id!
    }
    
    func getProductImageURL(index: Int) -> String {
        
        return productList[index].image!
    }
    
    func getProductName(index: Int) -> String {
        
        return productList[index].name!
    }
    
    func getProducer(index: Int) -> String {
        
        return productList[index].producer!
    }
    
    func getPrice(index: Int) -> Int {
        
        return productList[index].cost!
    }
    
    func getRating(index: Int) -> Int {
        return productList[index].rating!
    }
    
    func getStarImage(starNumber: Int, index: Int) -> UIImage {
        if productList[index].rating! >= starNumber {
            return UIImage(named: "star_check")!
        } else {
            return UIImage(named: "star_unchek")!
        }
    }
}


