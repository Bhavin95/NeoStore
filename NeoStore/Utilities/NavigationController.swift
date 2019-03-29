//
//  NavigationController.swift
//  NeoStore
//
//  Created by webwerks on 18/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(rgb: 0xE91B1A)
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.backItem?.backBarButtonItem?.tintColor = .white
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    func back() {
        self.popViewController(animated: true)
    }
}
