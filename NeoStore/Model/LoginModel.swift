//
//  LoginModel.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

struct LoginModel: Codable {
    var status: Int?
    var data: UserModel?
    var message: String?
    var user_msg: String?
}
