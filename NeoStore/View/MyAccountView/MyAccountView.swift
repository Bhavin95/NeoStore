//
//  MyAccountView.swift
//  NeoStore
//
//  Created by webwerks1 on 28/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class MyAccountView: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    
    @IBOutlet var cellFirstName: UITableViewCell!
    @IBOutlet var cellLastName: UITableViewCell!
    @IBOutlet var cellEmail: UITableViewCell!
    @IBOutlet var cellPhoneNo: UITableViewCell!
    @IBOutlet var cellDateOfBirth: UITableViewCell!
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textFieldFirstName: CustomUITextField!
    @IBOutlet weak var textFieldLastName: CustomUITextField!
    @IBOutlet weak var textFieldEmail: CustomUITextField!
    @IBOutlet weak var textFieldPhoneNo: CustomUITextField!
    @IBOutlet weak var textFieldDateOfBirth: CustomUITextField!
    
    @IBOutlet weak var buttonEditProfile: UIButton!
    @IBOutlet weak var buttonResetPassword: UIButton!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Constants and Variable
    
    var navTitle: String?
    lazy var myAccountViewModel = MyAccountViewModel()
    
    //MARK: Initialization
    
    func myInit(title: String) {
        self.navTitle = title
    }
    
    //MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = navTitle
        
        KeyboardManager.sharedInstance.delegate = self
        
        tableView.tableHeaderView = viewHeader
        tableView.tableFooterView = viewFooter
        
        if TitleConstants.myAccount == navTitle {
            textFieldFirstName.isUserInteractionEnabled = false
            textFieldLastName.isUserInteractionEnabled = false
            textFieldEmail.isUserInteractionEnabled = false
            textFieldPhoneNo.isUserInteractionEnabled = false
            textFieldDateOfBirth.isUserInteractionEnabled = false
        } else {
            buttonEditProfile.setTitle("SUBMIT", for: .normal)
            buttonResetPassword.removeFromSuperview()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         if TitleConstants.myAccount == navTitle {
            getUserData()
        }
        
    }

    //MARK: Functions
    
    func getUserData() {
        
        if ReachabilityChecker.sharedInstance.isConnectedToNetwork() {
            self.showSpinner(onView: self.view)
            myAccountViewModel.getUserData(parameter: [String : Any](), onSuccess: {
                print("SUCCESS")
                self.removeSpinner()
                DispatchQueue.main.async {
                    self.setup()
                }
            }) { (error) in
                print("SUCCESS")
                self.removeSpinner()
                self.alert(message: error, title: "")
            }
        }
    }
    
    func setup() {
        textFieldFirstName.text = myAccountViewModel.getFirstName()
        textFieldLastName.text = myAccountViewModel.getLastName()
        textFieldEmail.text = myAccountViewModel.getEmail()
        textFieldPhoneNo.text = myAccountViewModel.getPhoneNo()
        textFieldDateOfBirth.text = myAccountViewModel.getDateOfBirth()
    }
    
    //MARK: Actions
    
    @IBAction func actionEditProfile(_ sender: UIButton) {
        if TitleConstants.myAccount == navTitle {
            let myAccountView = MyAccountView()
            myAccountView.myInit(title: TitleConstants.editProfile)
            navigationController?.pushViewController(myAccountView, animated: true)
        } else {
            
        }
        
    }
    
    
}

//MARK: Extenseions

extension MyAccountView: KeyboardManagerDelegate {
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


extension MyAccountView: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            return cellPhoneNo
        case 4:
            return cellDateOfBirth
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



