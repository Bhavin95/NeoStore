//
//  UIVIew.swift
//  NeoStore
//
//  Created by webwerks on 22/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

extension UIView {
    
    func setBorder( _ color: UIColor , _ width: CGFloat, _ height: CGFloat, _ cornerRadius: CGFloat, _ shadowRadius: CGFloat, _ shadowOpacity: Float ) {
        // corner radius
        self.layer.cornerRadius = cornerRadius
        
        // border
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
}
