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
    
    private let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let build: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GeometryReader { geo in
                    ZStack {
                        AquaMarkView(text: "v.\(version ?? "") | \(build ?? "")")
                        ListCharacterView(viewModel: ListCharcaterViewModel())
                    }
                }
            }
        }
    }
}
