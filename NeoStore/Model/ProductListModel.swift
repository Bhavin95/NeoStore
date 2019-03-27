//
//  ProductModel.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct ProductModel: Codable {
    
    var id: Int?
    var categoryId: Int?
    var name: String?
    var producer: String?
    var description: String?
    var cost: Int?
    var rating: Int?
    var viewCount: Int
    var image: String?
    var created: String?
    var modified: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "product_category_id"
        case name
        case producer
        case description
        case cost
        case rating
        case viewCount = "view_count"
        case image = "product_images"
        case created
        case modified
        
    }
    
}

struct ProductListModel: Codable {
    var status: Int?
    var data: [ProductModel]?
    var message: String?
    var user_msg: String?
}
