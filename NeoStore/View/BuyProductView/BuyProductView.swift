//
//  BuyProductView.swift
//  NeoStore
//
//  Created by webwerks on 25/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class BuyProductView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var delegate: ProductDetailViewDelegate?
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var textFieldQuantity: UITextField!
    
    //MARK: Constants and Variable
    
    var productName: String?
    var productImage: String?
    
    //MARK: Initialize
    
    func myInit(_ productName: String, _ productImage: String) {
        
        self.productName = productName
        self.productImage = productImage
    }
    
    //MARK: ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        KeyboardManager.sharedInstance.delegate = self
        
        viewBackground.setBorder(.black, 0, 0, 6, 0, 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelProductName.text = productName
        imageViewProduct.loadImageAsync(with: productImage)
        
    }
    
    
    //MARK: Actions
    
    @IBAction func actionSubmit(_ sender: UIButton) {
        dismiss(animated: true) {
            if self.textFieldQuantity.text != "" {
                self.delegate?.buyNow(self.textFieldQuantity.text!)
            } else {
                self.delegate?.cancel()
            }
        }
        
    }
    

}

//MARK: Extensions

extension BuyProductView: KeyboardManagerDelegate {
    
    func keyboardWillChangeFrame(endFrame: CGRect?, duration: TimeInterval, animationCurve: UIView.AnimationOptions) {
        
        guard let endFrame = endFrame else { return }
        
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            UIView.animate(withDuration: duration) {
                self.view.frame.origin.y = 0
//                self.tableViewBottomConstraint.constant = 0
            }
        } else {
            UIView.animate(withDuration: duration) {
                self.view.frame.origin.y -= (endFrame.size.height / 3)
//                self.tableViewBottomConstraint.constant = endFrame.size.height
            }
            
        }
        
    }
    
    
}

