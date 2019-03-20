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
    
    var productID: String?
    let productCell = "ProductCell"
    lazy var productListViewModel = ProductListViewModel()
    
    //MARK: Initialize
    
    func myInit(_ productID: String) {
        
        self.productID = productID
    }
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: productCell, bundle: nil), forCellReuseIdentifier: productCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
        productListViewModel.getProductList(parameter: ["product_category_id": productID!], onSuccess: {
            self.removeSpinner()
            print(self.productListViewModel.productList)
        }) { (error) in
            self.removeSpinner()
            self.alert(message: error, title: "")
        }
    }


}

//MARK: Extension

extension ProductListView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductCell
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
