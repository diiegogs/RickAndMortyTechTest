//
//  ContentView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct ListCharacterView: View {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @StateObject private var viewModel: ListCharacterViewModel
    
    @State private var searchText: String = ""
    @State private var showFavoritesOnly: Bool = false
    
    @State private var selectedCharacter: Character? = nil
    
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
    
    init(viewModel: ListCharacterViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { [weak viewModel] _ in
            ZStack {
                Color.green.opacity(0.2)
                    .ignoresSafeArea()
                
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
                                                withAnimation(.spring()) {
                                                    selectedCharacter = character
                                                    Task {
                                                        await viewModel?.getEpisodesCharacter(episodes: selectedCharacter?.episode ?? [])
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        .task {
                            await viewModel?.getCharacters()
                        }
                        .onReceive(networkMonitor.$isConnectedInternet) { connected in
                            if connected {
                                Task { await viewModel?.getCharacters() }
                            }
                        }
                    } else {
                        NetworkView()
                    }
                }
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(
                        displayMode: .always),
                    prompt: ""
                )
                .disabled(viewModel?.showOverlay == true)
                .toolbar { [weak viewModel] in
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel?.sharedAuth.getStatusAuthenticate { success in
                                if success {
                                    withAnimation {
                                        showFavoritesOnly.toggle()
                                    }
                                } else {
                                    print(viewModel?.sharedAuth.errorMessage ?? "Error de autenticación")
                                }
                            }
                        } label: {
                            Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                                .foregroundStyle(showFavoritesOnly ? .red : .black)
                        }
                        .disabled(viewModel?.showOverlay == true)
                    }
                }
                .overlay { [weak viewModel] in
                    if let selectedCharacter = selectedCharacter,
                       viewModel?.showOverlay == true {
                        
                        let episodes: [Episode] = viewModel?.episodes ?? []
                        
                        DetailView(
                            name: selectedCharacter.name,
                            image: selectedCharacter.image,
                            gender: selectedCharacter.gender,
                            specie: selectedCharacter.species.translatedSpecie,
                            episodes: episodes
                        ) {
                            viewModel?.showOverlay = false
                            withAnimation {
                                self.selectedCharacter = nil
                            }
                        }
                    }
                }
                .refreshable { [weak viewModel] in
                    await viewModel?.getCharacters()
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
}

#Preview {
    ListCharacterView(viewModel: ListCharacterViewModel())
}
