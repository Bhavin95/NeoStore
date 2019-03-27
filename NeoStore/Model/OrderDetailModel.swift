//
//  OrderDetailModel.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct OrderDetailModel: Codable {
    var id: Int?
    var product_id: Int?
    var quantity: Int?
    var total: Int?
    var prod_name: String?
    var prod_cat_name: String?
    var prod_image: String?
}

struct OrderDetailsModel: Codable {
    var status: Int?
    var data: OrderModel?
    var message: String?
    var user_msg: String?
}
