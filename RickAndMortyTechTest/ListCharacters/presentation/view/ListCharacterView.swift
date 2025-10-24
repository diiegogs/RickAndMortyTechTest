//
//  ContentView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct ListCharacterView: View {
    @StateObject private var viewModel: ListCharcaterViewModel
    
    private var isEmptyCharacter: Bool { viewModel.characters.isEmpty }
    
    init(viewModel: ListCharcaterViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            Color.green.opacity(0.2)
            VStack {
                if isEmptyCharacter {
                    ContentUnavailableView("Sin personajes", systemImage: "doc")
                } else {
                    ScrollView(showsIndicators: false) {
                        
                        Text("Listado de personajes")
                            .font(.system(size: 20.0, weight: .bold, design: .default))
                            .foregroundStyle(.blue.opacity(0.7))
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20.0), count: 2)) {
                            ForEach(viewModel.characters) { character in
                                CardView(name: character.name, state: character.status, photo: character.image, specie: character.species) {
                                    print("clicked")
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .task {
                await viewModel.getCharacters()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    ListCharacterView(viewModel: ListCharcaterViewModel())
}
