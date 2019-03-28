//
//  AddressView.swift
//  NeoStore
//
//  Created by webwerks1 on 27/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class AddressView: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var textViewAddress: UITextView!
    @IBOutlet weak var textFieldLandmark: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldZipCode: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    
    //MARK: Constants and Variable
    
    lazy var addressViewModel = AddressViewModel()
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = TitleConstants.placeOrder
        
    }
    
    //MARK: Functions
    
    //MARK: Actions
    
    @IBAction func actionPlaceOrder(_ sender: UIButton) {
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            addressViewModel.placeOrder(parameter: ["address" : "The Ruby, 29-Senapati Bapat Marg, Dadar (West)"], onSuccess: { (success) in
                print("SUCCESS")
                self.removeSpinner()
                self.alert(message: success, title: "")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }) { (error) in
                print("FAILURE")
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
       
        }
       
        
//        navigationController?.popToRootViewController(animated: true)
    }
    

}

//MARK: Extenseions
