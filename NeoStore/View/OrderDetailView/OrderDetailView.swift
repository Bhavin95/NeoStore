//
//  OrderDetailView.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class OrderDetailView: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    var orderId: Int?
    lazy var orderDetailViewModel = OrderDetailViewModel()
    let cartListCell = "CartListCell"
    let cartListFooterView = "CartListFooterView"
    
    //MARK: Initialize
    
    func myInit(_ orderId: Int) {
        
        self.orderId = orderId
    }
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Order ID : " + "\(orderId!)"
        tableView.register(UINib(nibName: cartListFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: cartListFooterView)
        tableView.register(UINib(nibName: cartListCell, bundle: nil), forCellReuseIdentifier: cartListCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       getData()
    }
    
    //MARK: Functions
    
    func getData() {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            orderDetailViewModel.getOrderDetail(parameter: ["order_id" : orderId!], onSuccess: {
                self.removeSpinner()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }

}

//MARK: Extenseions

extension OrderDetailView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailViewModel.getOrderListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartListCell, for: indexPath) as! CartListCell
        cell.imageViewProduct.loadImageAsync(with: orderDetailViewModel.getProductImage(index: indexPath.row))
        cell.labelProductName.text = orderDetailViewModel.getProductName(index: indexPath.row)
        cell.labelProductCatagory.text = "( " + orderDetailViewModel.getProductCategoryName(index: indexPath.row) + " )"
        cell.buttonQuantity.setBackgroundImage(nil, for: .normal)
        cell.buttonQuantity.setTitle("QTY : " + String(orderDetailViewModel.getProductQuantity(index: indexPath.row)), for: .normal)
        cell.labelPrice.text =  "₹" + String(orderDetailViewModel.getProductCost(index: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cartListFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CartListFooterView") as! CartListFooterView
        if let total = orderDetailViewModel.orderDetailsModel?.cost {
            cartListFooterView.labelPrice.text = String(total)
        }
        if cartListFooterView.buttonOrderNow != nil {
            cartListFooterView.buttonOrderNow.removeFromSuperview()
        }
        cartListFooterView.viewTotal.setBorder(.lightGray, 1, 1, 0, 0, 0)
        return cartListFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 82
    }
    
    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
