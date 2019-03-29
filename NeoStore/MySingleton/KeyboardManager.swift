//
//  KeyboardManager.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

protocol KeyboardManagerDelegate: class {
    func keyboardWillChangeFrame(endFrame: CGRect?, duration: TimeInterval, animationCurve: UIView.AnimationOptions)
}

class KeyboardManager {
    
    static let sharedInstance = KeyboardManager()
    
    weak var delegate: KeyboardManagerDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrameNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
  
    
    @objc func keyboardWillChangeFrameNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        delegate?.keyboardWillChangeFrame(endFrame: endFrame, duration: duration, animationCurve: animationCurve)
    }
}
