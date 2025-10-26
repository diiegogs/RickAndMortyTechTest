//
//  UAuthManager.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 25/10/25.
//

import Foundation

import Combine
import LocalAuthentication

class UAuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    static let shared: UAuthManager = UAuthManager()
    
    func getStatusAuthenticate(completionHandler: @escaping (Bool) -> Void) -> Void {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Usa Face ID para acceder a tus favoritos"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authError in
                    DispatchQueue.main.async {
                        if success {
                            self?.isAuthenticated = true
                            self?.errorMessage = nil
                            completionHandler(true)
                        } else {
                            self?.isAuthenticated = false
                            self?.errorMessage = authError?.localizedDescription ?? "Autenticación fallida"
                            completionHandler(false)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Face ID o Touch ID no están configurados"
                    self.isAuthenticated = false
                    completionHandler(false)
                }
            }
    }
}
