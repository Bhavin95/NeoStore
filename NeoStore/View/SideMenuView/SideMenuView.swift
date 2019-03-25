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
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants and Variable
    
    var sideMenuCell = "SideMenuCell"
    var menu = ["My Cart": "shoppingcart_icon", "Tables": "tables_icon", "Chairs": "chair_icon", "Sofas": "sofa_icon", "Cupboards": "cupboard_icon", "My Account": "username_icon", "Store Locator": "storelocator_icon", "My Orders": "myorders_icon", "Logout": "logout_icon"]
    
    var menuDictKeyCopy: [String]? = []
    var menuDictValueCopy: [String]? = []
    
    //MARK: Initialize
    
    //MARK: ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: sideMenuCell, bundle: nil), forCellReuseIdentifier: sideMenuCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuDictKeyCopy = Array(self.menu.keys)
        menuDictValueCopy = Array(self.menu.values)
    }


}

//MARK: Extensions

extension SideMenuView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCell, for: indexPath) as! SideMenuCell
        cell.imageViewProduct.image = UIImage(named: menuDictKeyCopy![indexPath.row])
        cell.labelName.text = menuDictValueCopy![indexPath.row]
        if indexPath.row == 0 {
            cell.labelCount.isHidden = false
        } else {
            cell.labelCount.isHidden = true
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let cartListView = CartListView()
            navigationController?.pushViewController(cartListView, animated: true)
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        default:
            break
        }
    }
}
