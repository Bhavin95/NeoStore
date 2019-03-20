//
//  HomeViewModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class HomeViewModel {

    var homeModel = HomeModel()
    
    func getCount(_ slider: Bool) -> Int {
        
        if slider {
            return homeModel.sliderImage.count
        } else {
            return homeModel.productImage.count
        }
        
    }
    
    func getImage(_ slider: Bool, _ index: Int) -> UIImage {
        if slider {
            return UIImage(named: homeModel.sliderImage[index])!
        } else {
            return UIImage(named: homeModel.productImage[index])!
        }
        
    }
    
}
