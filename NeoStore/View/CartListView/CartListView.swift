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
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    lazy var cartListViewModel = CartListViewModel()
    let cartListCell = "CartListCell"
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = TitleConstants.myCart
        tableView.isHidden = true
//        tableView.tableFooterView = viewFooter
        tableView.register(UINib(nibName: "CartListFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CartListFooterView")
        tableView.register(UINib(nibName: cartListCell, bundle: nil), forCellReuseIdentifier: cartListCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCartList()
        
    }

    //MARK: Functions
    
    func getCartList() {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            cartListViewModel.getCartList(parameter: [String : Any](), onSuccess: {
                self.removeSpinner()
                
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }) { (error) in
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                }
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }
    
    func editProductQuantity(_ productId: Int, _ Quantity: Int, _ index: Int) {
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            cartListViewModel.editCart(parameter: ["product_id": productId, "quantity": Quantity], onSuccess: { (success) in
                self.removeSpinner()
                self.alert(message: success, title: "")
                self.cartListViewModel.editProductQuantity(index: index, quantity: Quantity)
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
        
        
    }
    
    func deleteProduct(_ productId: Int, _ index: Int) {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            cartListViewModel.deleteCart(parameter: ["product_id": productId], onSuccess: { (success) in
                self.removeSpinner()
                self.alert(message: success, title: "")
                self.cartListViewModel.deleteProduct(index: index)
                DispatchQueue.main.async {
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }
    
    //MARK: Actions
    
    @objc func actionQuantity(_ sender: UIButton) {
        
    }
    
     @objc func actionOrderNow(_ sender: UIButton) {
        let addressView = AddressView()
        navigationController?.pushViewController(addressView, animated: true)
    }
    

}

//MARK: Extenseions

extension CartListView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartListViewModel.getCartListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartListCell, for: indexPath) as! CartListCell
        cell.imageViewProduct.loadImageAsync(with: cartListViewModel.getProductImage(index: indexPath.row))
        cell.labelProductName.text = cartListViewModel.getProductName(index: indexPath.row)
        cell.labelProductCatagory.text = "( " + cartListViewModel.getProductCategoryName(index: indexPath.row) + " )"
        cell.buttonQuantity.tag = indexPath.row
        cell.buttonQuantity.setTitle("   " + String(cartListViewModel.getProductQuantity(index: indexPath.row)), for: .normal)
        cell.buttonQuantity.addTarget(self, action: #selector(actionQuantity(_:)), for: .touchUpInside)
        cell.labelPrice.text =  "₹" + String(cartListViewModel.getProductCost(index: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cartListFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CartListFooterView") as! CartListFooterView
        if let total = cartListViewModel.cartListModel?.total {
            cartListFooterView.labelPrice.text = String(total)
        }
        cartListFooterView.viewTotal.setBorder(.lightGray, 1, 1, 0, 0, 0)
        cartListFooterView.buttonOrderNow.addTarget(self, action: #selector(actionOrderNow(_:)), for: .touchUpInside)
        return cartListFooterView
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "") { (action, indexPath) in
            self.deleteProduct(self.cartListViewModel.getProductId(index: indexPath.row), indexPath.row)
        }
        delete.backgroundColor = UIColor(patternImage: UIImage(named: "delete")!)
        return [delete]

    }
}
