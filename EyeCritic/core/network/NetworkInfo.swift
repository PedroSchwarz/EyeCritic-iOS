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
    func isConnected() -> Bool {
        return true
//        var monitor = NWPathMonitor()
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied {
//                    return true
//                } else {
//                    return false
//                }
//        }
//        let queue = DispatchQueue(label: "Monitor")
//        monitor.start(queue: queue)
    }
}
