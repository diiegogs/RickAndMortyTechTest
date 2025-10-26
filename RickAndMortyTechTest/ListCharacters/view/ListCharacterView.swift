//
//  ContentView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct ListCharacterView: View {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @StateObject private var viewModel: ListCharcaterViewModel
    
    @State private var searchText: String = ""
    @State private var showFavoritesOnly: Bool = false
    
    private var filteredCharacters: [Character] {
        viewModel.characters.filter { character in
            (!showFavoritesOnly || character.isFavorite ?? false) &&
            (searchText.isEmpty || character.name.localizedCaseInsensitiveContains(searchText)
             || character.status.translatedStatus.localizedCaseInsensitiveContains(searchText)
             || character.species.translatedSpecie.localizedCaseInsensitiveContains(searchText)
            )
        }
    }
    
    private var isEmptyCharacter: Bool { filteredCharacters.isEmpty }
    
    init(viewModel: ListCharcaterViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            Color.green.opacity(0.2)
            VStack {
                if networkMonitor.isConnectedInternet {
                    VStack {
                        if isEmptyCharacter {
                            ContentUnavailableView("Sin personajes", systemImage: "doc")
                        } else {
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)) {
                                    ForEach(filteredCharacters) { character in
                                        CardView(name: character.name,
                                                 status: character.status.translatedStatus,
                                                 photo: character.image,
                                                 specie: character.species.translatedSpecie) {
                                            print("clicked")
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .task {
                        await viewModel.getCharacters()
                    }
                    .onReceive(networkMonitor.$isConnectedInternet) { connected in
                        if connected {
                            Task { await viewModel.getCharacters() }
                        }
                    }
                } else {
                    NetworkView()
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(
                displayMode: .always),
            prompt: ""
        )
        .toolbarBackground(Color.green.opacity(0.2), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showFavoritesOnly.toggle()
//                    MARK: Implement method to save data with core data and faceid
                } label: {
                    Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                        .foregroundStyle(showFavoritesOnly ? .red : .black)
                }
            }
        }
        .refreshable {
            await viewModel.getCharacters()
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    ListCharacterView(viewModel: ListCharcaterViewModel())
}
