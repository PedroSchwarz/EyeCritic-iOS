//
//  Network.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Network

protocol NetworkInfo {
    func isConnected() -> Bool
    
}

struct NetworkInfoImpl: NetworkInfo {
    var monitor: NWPathMonitor
     
    func isConnected() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}
