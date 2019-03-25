//
//  HomeModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct Product {
    var id: String?
    var name: String?
    var image: String?
}

struct HomeModel {

    var sliderImage: [String]
    var product: [Product]
}
