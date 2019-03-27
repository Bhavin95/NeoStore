//
//  OrderListModel.swift
//  NeoStore
//
//  Created by webwerks on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct OrderModel: Codable {
    var id: Int?
    var cost: Int?
    var created: String?
}

struct OrderListModel: Codable {
    var status: Int?
    var data: [OrderModel]?
    var message: String?
    var user_msg: String?
}
