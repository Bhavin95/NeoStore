//
//  ProductDetailView.swift
//  NeoStore
//
//  Created by webwerks on 22/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import SystemConfiguration
import UIKit

class ReachabilityChecker {
    
    static let sharedInstance = ReachabilityChecker()
    private  let reachability = Reachability()!
    private var isSyncing = false
    
    private init() {
        startNetworkObservation()
    }
    
    @objc func startNetworkObservation() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
       
        switch reachability.connection {
        case .wifi,.cellular:
            
            break
        case .none:
            print("No Connection")
            Utilities.getCurrentViewController()?.alert(message: "", title: "No Connection")
            break
        }
    }
    
    @objc func isConnectedToNetwork() -> Bool {
        if reachability.connection == .none {
            return false
        }
        return true
    }
    
}

