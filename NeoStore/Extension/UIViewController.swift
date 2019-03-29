//
//  UIViewController.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit


var vSpinner : UIView?

extension UIViewController {
    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBackbutton(title: String) {
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: title, style: .plain, target: self, action:
                #selector(self.backButtonAction))
        } else {
            if let nav = self.navigationController,
                let _ = nav.navigationBar.backItem {
                self.navigationController!.navigationBar.backItem!.title = title
            }
        }
    }
    
    func alert(message: String, title: String ) {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertWithEmailTextField(title: String, message: String, onSuccess: @escaping(String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
            alert.addTextField {
                $0.placeholder = "Please enter a email"
                $0.addTarget(alert, action: #selector(alert.textDidChangeInForgotAlert), for: .editingChanged)
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            let loginAction = UIAlertAction(title: "Submit", style: .default) { Void in
                guard let email = alert.textFields?[0].text
                    else { return }
                onSuccess(email)
                // Perform login action
            }
            
            loginAction.isEnabled = false
            alert.addAction(loginAction)
            self.present(alert, animated: true)
        }
        
    }
    
    func showSpinner(onView : UIView) {
        DispatchQueue.main.async {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
        
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}
