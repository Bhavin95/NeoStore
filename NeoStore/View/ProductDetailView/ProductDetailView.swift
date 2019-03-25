//
//  ProductDetailView.swift
//  NeoStore
//
//  Created by webwerks on 22/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

@objc protocol ProductDetailViewDelegate: class {
    
    func buyNow(_ quantity: String)
    func rateNow(_ rating: String)
    func cancel()
    
    
}

class ProductDetailView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    @IBOutlet var cellProductImage: UITableViewCell!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductCatagory: UILabel!
    @IBOutlet weak var labelProducer: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var labelDiscription: UILabel!
    
    @IBOutlet weak var buttonStar1: UIButton!
    @IBOutlet weak var buttonStar2: UIButton!
    @IBOutlet weak var buttonStar3: UIButton!
    @IBOutlet weak var buttonStar4: UIButton!
    @IBOutlet weak var buttonStar5: UIButton!
    
    
    //MARK: Constants and Variable
    
    var navTitle: String?
    var productID: String?
    var productCatagoryName: String?
    var cellSelected = 0
    lazy var productDetailViewModel = ProductDetailViewModel()
    var transperentView = UIView()
    
    //MARK: Initialize
    
    func myInit(_ productID: String, _ productCatagoryName: String , _ title: String) {
        
        self.productID = productID
        self.productCatagoryName = productCatagoryName
        self.navTitle = title
    }
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = navTitle
        backgroundView.setBorder(.lightGray, 0.5, 0.5, 6.0, 0.5, 0.5)
        tableView.tableHeaderView = viewHeader
        tableView.tableFooterView = viewFooter

        collectionViewProduct.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    //MARK: Functions
    
    func getData() {
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            productDetailViewModel.getProductDetail(parameter: ["product_id": productID!], onSuccess: {
                self.removeSpinner()
                print(self.productDetailViewModel.productDetail)
                DispatchQueue.main.async {
                    self.setup()
                }
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }
    
    func setup() {
        labelProductName.text = productDetailViewModel.getProductName()
        labelProductCatagory.text = "Catagory - " +  productCatagoryName!
        labelProducer.text = productDetailViewModel.getProducer()
        labelPrice.text = "Rs. \(productDetailViewModel.getPrice())"
        imageViewProduct.loadImageAsync(with: productDetailViewModel.getProductImageURL(0))
        labelDiscription.text = productDetailViewModel.getProductDiscription()
        buttonStar1.setImage(productDetailViewModel.getStarImage(starNumber: 1), for: .normal)
        buttonStar2.setImage(productDetailViewModel.getStarImage(starNumber: 2), for: .normal)
        buttonStar3.setImage(productDetailViewModel.getStarImage(starNumber: 3), for: .normal)
        buttonStar4.setImage(productDetailViewModel.getStarImage(starNumber: 4), for: .normal)
        buttonStar5.setImage(productDetailViewModel.getStarImage(starNumber: 5), for: .normal)
        collectionViewProduct.reloadData()
        tableView.reloadData()
    }
    
    //MARK: Actions
    
    @IBAction func actionBuyNow(_ sender: UIButton) {
        transperentView =  UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        transperentView.backgroundColor = .lightGray
        transperentView.alpha = 0.5
        self.view.addSubview(transperentView)
        let buyProductView = BuyProductView()
        buyProductView.modalPresentationStyle = .overCurrentContext
        buyProductView.modalTransitionStyle = .crossDissolve
        buyProductView.delegate = self
        buyProductView.myInit(productDetailViewModel.getProductName(), productDetailViewModel.getProductImageURL(0))
        present(buyProductView, animated: true, completion: nil)
    }
    
    @IBAction func actionRate(_ sender: UIButton) {
        transperentView =  UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        transperentView.backgroundColor = .lightGray
        transperentView.alpha = 0.5
        self.view.addSubview(transperentView)
        let rateProductView = RateProductView()
        rateProductView.modalPresentationStyle = .overCurrentContext
        rateProductView.modalTransitionStyle = .crossDissolve
        rateProductView.delegate = self
        rateProductView.myInit(productDetailViewModel.getProductName(), productDetailViewModel.getProductImageURL(0), String(productDetailViewModel.getRating()))
        present(rateProductView, animated: true, completion: nil)
    }
    
}

//MARK: Extension

extension ProductDetailView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return cellProductImage
        } else {
            return UITableViewCell()
        }
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension ProductDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailViewModel.getProductImageCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageViewProduct.loadImageAsync(with: productDetailViewModel.getProductImageURL(indexPath.row))
        
        if indexPath.row == cellSelected {
            cell.imageViewProduct.setBorder(UIColor(rgb: 0xE91B1A), 2, 2, 0, 0, 0)
        } else {
            cell.imageViewProduct.setBorder(UIColor.darkGray, 2, 2, 0, 0, 0)
        }
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        cell.imageViewProduct.setBorder(UIColor(rgb: 0xE91B1A), 2, 2, 0, 0, 0)
        imageViewProduct.image = cell.imageViewProduct.image
        
        collectionView.reloadSections(IndexSet(arrayLiteral: 0))
      
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 20) / 3, height: collectionView.frame.size.height)
    }
}

extension ProductDetailView: ProductDetailViewDelegate {
   
    func cancel() {
        transperentView.removeFromSuperview()
    }
    
    func buyNow(_ quantity: String) {
        transperentView.removeFromSuperview()
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            productDetailViewModel.addToCart(parameter: ["product_id": Int(productID!)!, "quantity": Int(quantity)!], onSuccess: { (success) in
                self.removeSpinner()
                self.alert(message: success, title: "")
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
        
    }
    
    func rateNow(_ rating: String) {
        transperentView.removeFromSuperview()
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            productDetailViewModel.addProductRating(parameter: ["product_id": Int(productID!)!, "rating": Int(rating)!], onSuccess: { (success) in
                self.removeSpinner()
                self.alert(message: success, title: "")
                self.getData()
            }) { (error) in
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
        
    }
    
}
