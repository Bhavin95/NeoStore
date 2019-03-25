//
//  RateProductView.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class RateProductView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var delegate: ProductDetailViewDelegate?
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    //MARK: Constants and Variable
    
    var productName: String?
    var productImage: String?
    var rating: String?
    
    //MARK: Initialize
    
    func myInit(_ productName: String, _ productImage: String, _ rating: String) {
        
        self.productName = productName
        self.productImage = productImage
        self.rating = rating
    }

    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBackground.setBorder(.black, 0, 0, 6, 0, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelProductName.text = productName
        imageViewProduct.loadImageAsync(with: productImage)
        getStarImage(rating: Int(rating!)!)
    }
    
    //MARK: Functions
    
    func getStarImage(rating: Int) {
        for i in 1...5 {
            let button = view.viewWithTag(i) as! UIButton
            if rating >= i {
                button.setImage(UIImage(named: "star_check")!, for: .normal)
            } else {
                button.setImage(UIImage(named: "star_unchek")!, for: .normal)
            }
        }

    }
    

    //MARK: Actions
    
    @IBAction func actionRating(_ sender: UIButton) {
        rating = "\(sender.tag)"
        getStarImage(rating: sender.tag)
       
    }
    
    
    @IBAction func actionRateNow(_ sender: UIButton) {
        print(rating!)
        dismiss(animated: true) {
            self.delegate?.rateNow(self.rating!)
        }
        
    }

}
