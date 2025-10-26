//
//  ListCharacterModel.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import Foundation

// MARK: - Response API
struct CharactersResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var isFavorite: Bool? = false
}

// MARK: - Origin
struct Origin: Codable {
    let name: String
    let url: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
