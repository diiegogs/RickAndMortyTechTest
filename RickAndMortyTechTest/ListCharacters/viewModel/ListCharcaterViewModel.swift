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
    @Published internal var episodes: [Episode] = []
    @Published internal var errorMessage: String = ""
    @Published internal var showOverlay: Bool = false
    
    private let shared: UServiceManager = UServiceManager.shared
    internal let sharedAuth: UAuthManager = UAuthManager.shared
    
    internal func getCharacters() async {
        do {
            let response: CharactersResponse = try await shared.callService(queryParam: "character")
            self.characters = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    internal func getEpisodesCharacter(episodes: [String]) async {
        do {
            let ids = episodes.compactMap { $0.split(separator: "/").last }
            
            guard !ids.isEmpty else { return }
            
            let allEpisodes: String = ids.joined(separator: ",")
            let queryParam: String = ids.count == 1 ? "episode/\(allEpisodes)" : "episode/[\(allEpisodes)]"
            let response: [Episode] = try await shared.callService(queryParam: queryParam)
            self.episodes = response
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.showOverlay = true
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
