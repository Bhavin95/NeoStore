//
//  CartListCell.swift
//  NeoStore
//
//  Created by webwerks on 26/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CartListCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductCatagory: UILabel!
    @IBOutlet weak var buttonQuantity: UIButton!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
