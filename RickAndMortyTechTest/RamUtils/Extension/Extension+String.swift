//
//  Extension+String.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 25/10/25.
//

import Foundation

extension String {
    var translatedStatus: String {
        switch self.lowercased() {
            case "alive": return "Vivo"
            case "dead": return "Muerto"
            case "unknown": return "Desconocido"
            default: return self
        }
    }

    var translatedSpecie: String {
        switch self.lowercased() {
            case "human": return "Humano"
            case "alien": return "Alienígena"
            case "robot": return "Robot"
            default: return self
        }
    }
}
