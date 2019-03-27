//
//  UILabel.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

extension UILabel {

    func makeRound() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
    }
}
