//
//  UCardView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct UCardView: View {
    private var name: String
    private var status: String
    private var photo: String
    private var specie: String
    private var actionCard: (() -> Void)?
    
    init(name: String,
         status: String,
         photo: String,
         specie: String,
         actionCard: (() -> Void)? = nil) {
        self.name = name
        self.status = status
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
                        Text(specie)
                            .foregroundStyle(.black.opacity(0.7))
                            .font(.system(size: 14, weight: .regular))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Divider()
                        
                        stateCharacterView(status: status)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(10.0)
            }
        }
    }
}

@ViewBuilder
func stateCharacterView(status: String) -> some View {
    
    let symbol: (String) = {
        switch status {
        case "Vivo":
            return "💚"
        case "Muerto":
            return "💀"
        case "Desconocido":
            return "❔"
        default:
            return "🤔"
        }
    }()
    
    Text(symbol)
        .imageScale(.large)

}

#Preview {
    UCardView(
        name: "",
        status: "",
        photo: "",
        specie: "")
}
