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
    
    func placeOrder() {
        if textViewAddress.text.count == 0 {
            alert(message: "Enter address", title: "")
            return
        }
        if textFieldLandmark.text!.count == 0 {
            alert(message: "Enter landmark", title: "")
            return
        }
        if textFieldCity.text!.count == 0 {
            alert(message: "Enter city", title: "")
            return
        }
        if textFieldState.text!.count == 0 {
            alert(message: "Enter State", title: "")
            return
        }
        
        if !(textFieldZipCode.text!.isValidPostalCode()) {
            alert(message: "Enter a valid zipcode", title: "")
            return
        }
        if textFieldCountry.text!.count == 0 {
            alert(message: "Enter country", title: "")
            return
        }
        
        let address = textViewAddress.text! + ", " + textFieldLandmark.text! + ", " + textFieldCity.text! + ", " + textFieldZipCode.text! + ", " + textFieldCountry.text! + "."
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            addressViewModel.placeOrder(parameter: ["address" : address], onSuccess: { (success) in
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
    }
    
    //MARK: Actions
    
    @IBAction func actionPlaceOrder(_ sender: UIButton) {
        placeOrder()
//        navigationController?.popToRootViewController(animated: true)
    }
    

}

//MARK: Extenseions
