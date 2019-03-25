//
//  HomeViewModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class HomeViewModel {

    var homeModel: HomeModel!
    
    init() {
        
        let slider = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
        
        let table = Product(id: "1", name: "Tables", image: "tableicon")
        let chair = Product(id: "2", name: "Sofas", image: "chairsicon")
        let sofa = Product(id: "3", name: "Chairs", image: "sofaicon")
        let cupboard = Product(id: "4", name: "CupBoards", image: "cupboardicon")
        
        homeModel = HomeModel(sliderImage: slider, product: [table, chair, sofa, cupboard])
    }
    
    func getCount(_ slider: Bool) -> Int {
        
        if slider {
            return homeModel.sliderImage.count
        } else {
            return homeModel.product.count
        }
        
    }
    
    func getImage(_ slider: Bool, _ index: Int) -> UIImage {
        if slider {
            return UIImage(named: homeModel.sliderImage[index])!
        } else {
            return UIImage(named: (homeModel.product[index].image!))!
        }
        
    }
    
    func getProductId(_ index: Int) -> String {
        return homeModel.product[index].id!
    }
    
    func getProductCatagoryName(_ index: Int) -> String {
        return homeModel.product[index].name!
    }
    
}
