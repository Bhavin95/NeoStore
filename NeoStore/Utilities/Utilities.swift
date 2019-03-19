//
//  Utilities.swift
//  NeoStore
//
//  Created by webwerks on 19/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    //MARK: JSON Parsing
    
    class func getJSON(_ apiName: String, _ data: Data ) {
        // parse the result as JSON, since that's what the API provides
        do {
            guard let receivedJSON = try JSONSerialization.jsonObject(with: data,
                                                                      options: []) as? [String: Any] else {
                                                                        print("Could not get JSON from responseData as dictionary")
                                                                        return
            }
            print("The resonse json is: ")
            print(receivedJSON)
            
        } catch  {
            print("error parsing response from POST on \(apiName)")
            return
        }
    }
   
}
