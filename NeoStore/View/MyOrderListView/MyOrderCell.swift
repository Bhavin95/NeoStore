//
//  MyOrderCell.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var labelOrderId: UILabel!
    @IBOutlet weak var labelOrderDate: UILabel!
    @IBOutlet weak var labelOrderCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
