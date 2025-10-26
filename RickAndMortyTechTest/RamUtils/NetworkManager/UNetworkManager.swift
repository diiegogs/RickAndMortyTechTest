//
//  UNetworkManager.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 25/10/25.
//

import Foundation
import Network
import Combine

class NetworkMonitor: ObservableObject {
    @Published var isConnectedInternet: Bool = true
    @Published var connectionType: String = ""
    
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "networkQueue")

    private func startHandlerMonitor() -> Void {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let connectionType: NWPath.Status = path.status
                self?.isConnectedInternet = path.status == .satisfied
                
                switch connectionType {
                    case .satisfied:
                        print("Connected")
                    case .unsatisfied:
                        print("Not connected to internet")
                    case .requiresConnection:
                        print("Connection restringed")
                    @unknown default:
                        print("Unknown")
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    init() {
        startHandlerMonitor()
    }
}
