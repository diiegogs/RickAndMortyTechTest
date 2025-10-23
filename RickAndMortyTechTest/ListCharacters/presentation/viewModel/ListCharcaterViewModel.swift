//
//  ListCharcaterViewModel.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import Foundation
import Combine

class ListCharcaterViewModel: ObservableObject {
    @Published internal var characters: [Character] = []
    @Published internal var errorMessage: String = ""
    
    private let shared: Utl_ServiceManager = Utl_ServiceManager.shared
    
    internal func getCharacters() async {
        do {
            let response: CharactersResponse = try await shared.callService(queryParam: "character")
            self.characters = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
