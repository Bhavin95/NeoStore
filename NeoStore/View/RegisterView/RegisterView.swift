//
//  RegisterView.swift
//  NeoStore
//
//  Created by webwerks on 18/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class RegisterView: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    
    
    @IBOutlet var cellFirstName: UITableViewCell!
    @IBOutlet weak var textFieldFirstName: CustomUITextField!
    
    @IBOutlet var cellLastName: UITableViewCell!
    @IBOutlet weak var textFieldLastName: CustomUITextField!
    
    @IBOutlet var cellEmail: UITableViewCell!
    @IBOutlet weak var textFieldEmail: CustomUITextField!
    
    @IBOutlet var cellPassword: UITableViewCell!
    @IBOutlet weak var textFieldPassword: CustomUITextField!
    
    @IBOutlet var cellConfirmPassword: UITableViewCell!
    @IBOutlet weak var textFieldConfirmPassword: CustomUITextField!
    
    @IBOutlet var cellGender: UITableViewCell!
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var buttonFemale: UIButton!
    
    @IBOutlet var cellPhoneNumber: UITableViewCell!
    @IBOutlet weak var textFieldPhoneNumber: CustomUITextField!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Constants and Variables
    
    lazy var registerViewModel = RegisterViewModel()
    
    var isMaleSelected = true
    var isAgreeSelected = true
    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        title = TitleConstants.register
        
        KeyboardManager.sharedInstance.delegate = self
        
        tableView.tableHeaderView = viewHeader
        tableView.tableFooterView = viewFooter
        
        
    }
    
    //MARK: Functions
    

    //MARK: Actions
    
    @IBAction func actionSelectGender(_ sender: UIButton) {
        
        switch sender.tag {
        case 1 :
            buttonMale.setImage(UIImage(named: "chkn"), for: .normal)
            buttonFemale.setImage(UIImage(named: "chky"), for: .normal)
            
        default:
            buttonMale.setImage(UIImage(named: "chky"), for: .normal)
            buttonFemale.setImage(UIImage(named: "chkn"), for: .normal)
        }

    }
    
    
    @IBAction func actionAgree(_ sender: UIButton) {
        isAgreeSelected = !isAgreeSelected
        if isAgreeSelected {
            sender.setImage(UIImage(named: "checked_icon"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "uncheck_icon"), for: .normal)
        }
    }
    
    @IBAction func actionRegister(_ sender: UIButton) {
        print(registerViewModel.registerModel)
        
        
            
    }
    
}

//MARK: Extensions

extension RegisterView: KeyboardManagerDelegate {
    func keyboardWillChangeFrame(endFrame: CGRect?, duration: TimeInterval, animationCurve: UIView.AnimationOptions) {
        
        guard let endFrame = endFrame else { return }
        
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
             UIView.animate(withDuration: duration) {
                self.tableViewBottomConstraint.constant = 0
            }
        } else {
            UIView.animate(withDuration: duration) {
                self.tableViewBottomConstraint.constant = endFrame.size.height
            }
        }
    }
}

extension RegisterView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        switch textField {
        case textFieldFirstName:
            registerViewModel.registerModel.firstName = textField.text!
        case textFieldLastName:
            registerViewModel.registerModel.lastName = textField.text!
        case textFieldEmail:
            registerViewModel.registerModel.email = textField.text!
        case textFieldPassword:
            registerViewModel.registerModel.password = textField.text!
        case textFieldConfirmPassword:
            registerViewModel.registerModel.confirmPassword = textField.text!
        case textFieldPhoneNumber:
            registerViewModel.registerModel.phoneNo = textField.text!
        default:
            break
        }
        
    }
}

extension RegisterView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellFirstName
        case 1:
            return cellLastName
        case 2:
            return cellEmail
        case 3:
            return cellPassword
        case 4:
            return cellConfirmPassword
        case 5:
            return cellGender
        case 6:
            return cellPhoneNumber
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        self.view.endEditing(true)
    }
    
}

