//
//  Utilities.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    //MARK: Alert View
    
    class func alertViewWithOneAction(_ viewController: UIViewController, _ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.present(alertController, animated: true, completion: nil)
    }

    //MARK: JSON Parsing
    
    class func getJSON(_ apiName: String, _ data: Data ) -> [String: Any] {
        // parse the result as JSON, since that's what the API provides
        do {
            guard let resultDict = try JSONSerialization.jsonObject(with: data,
                                                                      options: []) as? [String: Any] else {
                                                                        print("Could not get JSON from responseData as dictionary")
                                                                        return [String: Any]()
            }
            return resultDict
            
        } catch  {
            print("error parsing response from POST on \(apiName)")
            return [String: Any]()
        }
    }
    
    //MARK: Get Current ViewController
    
    // Returns the most recently presented UIViewController (visible)
    class func getCurrentViewController() -> UIViewController? {
        
        // If the root view is a navigation controller, we can just return the visible ViewController
        if let navigationController = getNavigationController() {
            
            return navigationController.visibleViewController
        }
        
        // Otherwise, we must get the root UIViewController and iterate through presented views
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            
            var currentController: UIViewController! = rootController
            
            // Each ViewController keeps track of the view it has presented, so we
            // can move from the head to the tail, which will always be the current view
            while( currentController.presentedViewController != nil ) {
                
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    // Returns the navigation controller if it exists
    class func getNavigationController() -> UINavigationController? {
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController  {
            
            return navigationController as? UINavigationController
        }
        return nil
    }
    
   
}


