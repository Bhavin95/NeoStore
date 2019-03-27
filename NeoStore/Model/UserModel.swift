//
//  UserModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct UserModel: Codable {

    var id: Int?
    var role_id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var username: String?
    var profile_pic: String?
    var country_id: Int?
    var gender: String?
    var phone_no: String?
    var dob: String?
    var is_active: Bool?
    var created: String?
    var modified: String?
    var access_token: String?
    
}
