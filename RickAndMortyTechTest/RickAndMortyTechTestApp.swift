//
//  RickAndMortyTechTestApp.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

@main
struct RickAndMortyTechTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ListCharacterView(viewModel: ListCharcaterViewModel())
        }
    }
}
