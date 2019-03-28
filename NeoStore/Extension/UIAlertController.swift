//
//  UIAlertController.swift
//  NeoStore
//
//  Created by webwerks1 on 28/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

extension UIAlertController {

    func isValidEmail(_ email: String) -> Bool {
        return email.count > 0 && NSPredicate(format: "self matches %@", "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}").evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 4 && password.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }
    
    @objc func textDidChangeInLoginAlert() {
        if let email = textFields?[0].text,
            let password = textFields?[1].text,
            let action = actions.last {
            action.isEnabled = isValidEmail(email) && isValidPassword(password)
        }
    }
    
    @objc func textDidChangeInForgotAlert() {
        if let email = textFields?[0].text,
            let action = actions.last {
            action.isEnabled = isValidEmail(email)
        }
    }

}
