//
//  ProductListView.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ProductListView: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    var productCatagoryID: String?
    var productCatagoryName: String?
    let productCell = "ProductCell"
    lazy var productListViewModel = ProductListViewModel()
    
    //MARK: Initialize
    
    func myInit(_ productCatagoryID: String, _ productCatagoryName: String) {
        
        self.productCatagoryID = productCatagoryID
        self.productCatagoryName = productCatagoryName
    }
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: productCell, bundle: nil), forCellReuseIdentifier: productCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            productListViewModel.getProductList(parameter: ["product_category_id": productCatagoryID!], onSuccess: {
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
    
    //MARK: Functions


}

//MARK: Extension

extension ProductListView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductCell
        cell.imageViewProduct.loadImageAsync(with: productListViewModel.getProductImageURL(index: indexPath.row))
        cell.labelProductName.text = productListViewModel.getProductName(index: indexPath.row)
        cell.labelProducer.text = productListViewModel.getProducer(index: indexPath.row)
        cell.labelPrice.text = "Rs. \(productListViewModel.getPrice(index: indexPath.row))"
        cell.buttonStar1.setImage(productListViewModel.getStarImage(starNumber: 1, index: indexPath.row), for: .normal)
        cell.buttonStar2.setImage(productListViewModel.getStarImage(starNumber: 2, index: indexPath.row), for: .normal)
        cell.buttonStar3.setImage(productListViewModel.getStarImage(starNumber: 3, index: indexPath.row), for: .normal)
        cell.buttonStar4.setImage(productListViewModel.getStarImage(starNumber: 4, index: indexPath.row), for: .normal)
        cell.buttonStar5.setImage(productListViewModel.getStarImage(starNumber: 5, index: indexPath.row), for: .normal)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailView = ProductDetailView()
        productDetailView.myInit(String(productListViewModel.getProductID(index: indexPath.row)), productListViewModel.getProductName(index: indexPath.row), productCatagoryName!)
        navigationController?.pushViewController(productDetailView, animated: true)
    }
    
}
