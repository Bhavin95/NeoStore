//
//  SideMenuView.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class SideMenuView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var delegate: HomeViewDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    var sideMenuCell = "SideMenuCell"
    var name = ["My Cart", "Tables", "Chairs", "Sofas", "Cupboards", "My Account", "Store Locator", "My Orders", "Logout"]
    var image = ["shoppingcart_icon", "tables_icon", "chair_icon", "sofa_icon", "cupboard_icon", "username_icon", "storelocator_icon", "myorders_icon", "logout_icon"]

    
    //MARK: Initialize
    
    //MARK: ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: sideMenuCell, bundle: nil), forCellReuseIdentifier: sideMenuCell)
        
    }

}

//MARK: Extensions

extension SideMenuView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCell, for: indexPath) as! SideMenuCell
        cell.imageViewProduct.image = UIImage(named: image[indexPath.row])
        cell.labelName.text = name[indexPath.row]
        cell.labelCount.makeRound()
        if indexPath.row == 0 {
            cell.labelCount.isHidden = false
        } else {
            cell.labelCount.isHidden = true
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.navigate(index: indexPath.row)
    }
}
