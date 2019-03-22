//
//  ProductCell.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProducer: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonStar1: UIButton!
    @IBOutlet weak var buttonStar2: UIButton!
    @IBOutlet weak var buttonStar3: UIButton!
    @IBOutlet weak var buttonStar4: UIButton!
    @IBOutlet weak var buttonStar5: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
