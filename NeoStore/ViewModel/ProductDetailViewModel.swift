//
//  ProductDetailViewModel.swift
//  NeoStore
//
//  Created by webwerks on 22/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ProductDetailViewModel {
    
    var productDetail: ProductDetailsModel!
    
    func getProductDetail(parameter:[String:Any], onSuccess: @escaping() -> Void, onFailure: @escaping(String) -> Void) {
        APIManager.sharedInstance.getData(apiName: APIConstants.productDetails, parameter: parameter, onSuccess: { (data) in
            let resultDict = Utilities.getJSON(APIConstants.login, data)
            let statusCode = resultDict["status"] as! Int
            
            if statusCode == 200 {
                do {
                    let jsonDecoder  = JSONDecoder()
                    let productDetail = try jsonDecoder.decode(ProductDetailModel.self, from: data)
                    self.productDetail = productDetail.data
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
    
    func getProductID() -> Int {
        return productDetail.id!
    }
    
    func getProductName() -> String {
        
        return productDetail.name!
    }
    
    func getProducer() -> String {
        
        return productDetail.producer!
    }
    
    func getPrice() -> Int {
        
        return productDetail.cost!
    }
    
    func getRating() -> Int {
        return productDetail.rating!
    }
    
    func getProductDiscription() -> String {
        
        return productDetail.description!
    }
    
    func getProductImageCount() -> Int {
        if let productDetail = productDetail  {
            return productDetail.images!.count
        } else {
            return 0
        }
        
    }
    
    func getProductImageURL(_ index: Int) -> String {
        return productDetail.images![index].image!
    }
    
    func getStarImage(starNumber: Int) -> UIImage {
        if productDetail.rating! >= starNumber {
            return UIImage(named: "star_check")!
        } else {
            return UIImage(named: "star_unchek")!
        }
    }
    
}
