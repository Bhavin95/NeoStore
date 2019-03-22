//
//  ProductDetailModel.swift
//  NeoStore
//
//  Created by webwerks on 22/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct ProductImages: Codable {
    var id: Int?
    var productId: Int?
    var image: String?
    var created: String?
    var modified: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case image
        case created
        case modified
    }
}

struct ProductDetailsModel: Codable {
    
    var id: Int?
    var categoryId: Int?
    var name: String?
    var producer: String?
    var description: String?
    var cost: Int?
    var rating: Int?
    var viewCount: Int
    var images: [ProductImages]?
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
        case images = "product_images"
        case created
        case modified
        
    }
    
}

struct ProductDetailModel: Codable {
    var status: Int?
    var data: ProductDetailsModel

}
