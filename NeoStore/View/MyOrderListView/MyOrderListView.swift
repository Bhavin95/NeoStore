//
//  MyOrderListView.swift
//  NeoStore
//
//  Created by webwerks on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class MyOrderListView: UIViewController {
    
    //MARK: Outlets

    //MARK: Constants and Variable
    
    lazy var orderListViewModel = OrderListViewModel()
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderListViewModel.getOrderList(parameter: [String : Any](), onSuccess: {
            print(self.orderListViewModel.orderModel)
        }) { (error) in
            self.alert(message: error, title: "")
        }
    }

}
