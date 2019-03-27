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
        layer.cornerRadius = cornerRadius
        
        // border
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}
