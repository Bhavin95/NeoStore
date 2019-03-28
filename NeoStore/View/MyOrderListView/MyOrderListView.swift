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
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    lazy var orderListViewModel = OrderListViewModel()
    var myOrderCell = "MyOrderCell"
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = TitleConstants.myOrders
        
        self.tableView.isHidden = true
        tableView.register(UINib(nibName: myOrderCell, bundle: nil), forCellReuseIdentifier: myOrderCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       getOrderList()
    }
    
    //MARK: Functions
    
    func getOrderList() {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            orderListViewModel.getOrderList(parameter: [String : Any](), onSuccess: {
                self.removeSpinner()
                
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }

}

//MARK: Extension

extension MyOrderListView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.getOrderListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myOrderCell, for: indexPath) as! MyOrderCell
        cell.labelOrderId.text = "Order Id : " + String(orderListViewModel.getOrderId(index: indexPath.row))
        cell.labelOrderDate.text = "Ordered Date : " + orderListViewModel.getOrderDate(index: indexPath.row)
        cell.labelOrderCost.text = "₹" + String(orderListViewModel.getOrderCost(index: indexPath.row))
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailView = OrderDetailView()
        orderDetailView.myInit(orderListViewModel.getOrderId(index: indexPath.row))
        navigationController?.pushViewController(orderDetailView, animated: true)
    }
}
