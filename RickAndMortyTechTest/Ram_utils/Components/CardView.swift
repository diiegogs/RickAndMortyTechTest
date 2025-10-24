//
//  CardView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

enum StateCharacterEnum: String {
    case ALIVE
    case DEAD
    case UNKNOWN
}

enum SpecieCharacterEnum: String {
    case HUMAN
    case ALIEN
}

struct CardView: View {
    private var name: String
    private var state: String
    private var photo: String
    private var specie: String
    private var actionCard: (() -> Void)?
    
    private func getNameCharacter(specie: String) -> String {
        guard let specieCharacter = SpecieCharacterEnum(rawValue: specie.uppercased()) else { return "" }
        
        switch(specieCharacter) {
            case .ALIEN:
                return "Alien"
            case .HUMAN:
                return "Humano"
            default:
                return ""
        }
    }
    
    init(name: String,
         state: String,
         photo: String,
         specie: String,
         actionCard: (() -> Void)? = nil) {
        self.name = name
        self.state = state
        self.photo = photo
        self.specie = specie
        self.actionCard = actionCard
    }
    
    var body: some View {
        Button {
            self.actionCard?()
        } label: {
            ZStack {
                Color.green.opacity(0.3)
                    .cornerRadius(10.0)
                
                VStack {
                    AsyncImage(url: URL(string: photo)) { phase in
                        if let img = phase.image {
                            img
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100.0, height: 100.0)
                        } else if let _ = phase.error {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80.0, height: 100.0)
                                .foregroundStyle(.gray.opacity(0.8))
                                .padding()
                        } else {
                            ProgressView()
                                .scaledToFit()
                                .frame(width: 100.0, height: 100.0)
                        }
                    }
                    
                    Text(name)
                        .foregroundStyle(.black)
                        .font(.system(size: 16, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        
                        Text(getNameCharacter(specie: specie))
                            .foregroundStyle(.black.opacity(0.7))
                            .font(.system(size: 14, weight: .regular))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Divider()
                        
                        stateCharacterView(state: state)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(10.0)
            }
        }
    }
}

@ViewBuilder
func stateCharacterView(state: String) -> some View {
    if let states: StateCharacterEnum = StateCharacterEnum(rawValue: state.uppercased()) {
        let (symbol, color): (String, Color) = {
            switch states {
                case .ALIVE:
                    return ("checkmark.circle.fill", .green)
                case .DEAD:
                    return ("xmark.octagon.fill", .red)
                case .UNKNOWN:
                    return ("questionmark.circle.fill", .gray)
            }
        }()
        
        Image(systemName: symbol)
            .foregroundStyle(color)
            .imageScale(.large)
    } else {
        Image(systemName: "exclamationmark.circle")
    }
}

#Preview {
    CardView(
        name: "",
        state: "",
        photo: "",
        specie: "")
}
