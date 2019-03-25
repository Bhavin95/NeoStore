//
//  CartListView.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CartListView: UIViewController {

    //MARK: Outlets
    
    
    //MARK: Constants and Variable
    
    lazy var cartListViewModel = CartListViewModel()
    
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            cartListViewModel.getCartList(parameter: [String : Any](), onSuccess: {
                self.removeSpinner()
                print(self.cartListViewModel.cartList)
                DispatchQueue.main.async {
//                    self.tableView.reloadData()
                }
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
        
        
    }


}
