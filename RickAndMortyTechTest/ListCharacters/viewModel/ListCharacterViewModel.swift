//
//  ListCharacterViewModel.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import Foundation
import Combine

class ListCharacterViewModel: ObservableObject {
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
        
        await MainActor.run {
            self.showOverlay = false
            self.episodes = []
        }

        do {
            if episodes.count == 1 {
                let episode: Episode = try await UServiceManager.shared.callService(queryParam: episodes[0])
                
                await MainActor.run {
                    self.episodes = [episode]
                    self.showOverlay = true
                }
            } else {
                let allEpisodes: [Episode] = try await UServiceManager.shared.callService(queryParam: "episode/\(episodes.map { $0.split(separator: "/").last! })")
                await MainActor.run {
                    self.episodes = allEpisodes
                    self.showOverlay = true
                }
            }
        } catch {
            await MainActor.run {
                self.showOverlay = false
            }
        }
    }
}
