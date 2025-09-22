//
//  NetworkViewModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import Network
import SwiftUI

// MARK: - Network Monitor
// monitors the network status of the device to ensure the app can handle connectivity issues.

class NetworkMonitor: ObservableObject {
   
    private var monitor: NWPathMonitor  // Monitors the network path and checks for connectivity changes
    private let queue = DispatchQueue.global()  // global queue to run the network monitoring tasks
    
    @Published var isConnected: Bool = true  // Indicates whether the device is connected to the internet.

    init() {
        // Create a network monitor instance
        monitor = NWPathMonitor()
        
        // Define a handler to respond to network path changes
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                
                self.isConnected = path.status == .satisfied  // `true` if the network is reachable, otherwise `false`
            }
        }
        
        // Start the network monitor on the specified queue
        monitor.start(queue: queue)
    }
}
