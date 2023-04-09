//
//  Helper.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 09/04/2023.
//

import Foundation
import Reachability

class NetworkHelper: ObservableObject {
    let reachability = try! Reachability()
    
    @Published var isConnected: Bool = true
    
    init() {
        setupReachability()
    }
    
    func setupReachability() {
        reachability.whenReachable = { [weak self] reachability in
            DispatchQueue.main.async {
                self?.isConnected = true
            }
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            DispatchQueue.main.async {
                self?.isConnected = false
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
