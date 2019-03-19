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
   
}
