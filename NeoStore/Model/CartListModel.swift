//
//  CartModel.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct CartProductModel: Codable {
    var id: Int?
    var name: String?
    var product_category: String?
    var cost: Int?
    var product_images: String?
    var sub_total: Int?
}

struct CartModel: Codable {
    
    var id: Int?
    var product_id: Int?
    var quantity: Int?
    var product: CartProductModel

}

struct CartListModel: Codable {
    var status: Int?
    var data: [CartModel]
    var count: Int?
    var total: Int?
}
