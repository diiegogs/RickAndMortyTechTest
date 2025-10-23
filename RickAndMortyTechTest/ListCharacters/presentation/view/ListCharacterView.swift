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
            VStack(alignment: .center) {
                if isEmptyCharacter {
                    ContentUnavailableView("Sin personajes", systemImage: "doc")
                } else {
                    Text("Listado de personajes")
                    
                }
            }
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
