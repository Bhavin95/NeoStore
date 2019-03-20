//
//  ProductModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct ProductListModel: Codable {
    var status: Int?
    var data: [ProductModel]
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
