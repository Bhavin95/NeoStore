//
//  HomeView.swift
//  NeoStore
//
//  Created by webwerks on 20/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionViewBanner: UICollectionView!
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK: Constants and Variable
    
    var homeViewModel = HomeViewModel()
    var count = 0
    weak var timer: Timer?
    
    //MARK: View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NeoSTORE"
        homeViewModel.homeModel.product = ["Tabels", "Sofa", "Chair", "CupBoard"]
        homeViewModel.homeModel.sliderImage = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
        homeViewModel.homeModel.productImage = ["tableicon", "sofaicon", "chairsicon", "cupboardicon"]
        pageControl.numberOfPages = homeViewModel.homeModel.sliderImage.count
        pageControl.hidesForSinglePage = true
        collectionViewBanner.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionViewProduct.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    //MARK: Functions
    
    @objc func timerHandler(_ timer: Timer) {
        if count < 4 {
            collectionViewBanner.scrollToItem(at: IndexPath(row: count, section: 0), at: .left, animated: true)
            print(count)
            pageControl.currentPage = count
        } else {
            count = 0
            collectionViewBanner.scrollToItem(at: IndexPath(row: count, section: 0), at: .left, animated: true)
            print(count)
            pageControl.currentPage = count
        }
        count += 1
        
        
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerHandler(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}

//MARK: Extension

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewBanner {
            return homeViewModel.getCount(true)
        } else {
            return homeViewModel.getCount(false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            cell.imageViewProduct.image = homeViewModel.getImage(true, indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            cell.imageViewProduct.image = homeViewModel.getImage(false, indexPath.row)
            return cell
        }
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewBanner {
            
        } else {
            let productListView = ProductListView()
            productListView.myInit(String(indexPath.row + 1), homeViewModel.getProductCatagoryName(indexPath.row))
            navigationController?.pushViewController(productListView, animated: true)
        }
        
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewBanner {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: (collectionView.frame.size.width / 2) - 18, height: (collectionView.frame.size.width / 2) - 18)
        }
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        count = pageControl.currentPage
        startTimer()
    }

}
