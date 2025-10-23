//
//  CardView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct CardView: View {
    private var name: String
    private var state: String
    private var photo: String
    private var specie: String
    
    init(name: String,
         state: String,
         photo: String,
         specie: String) {
        self.name = name
        self.state = state
        self.photo = photo
        self.specie = specie
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CardView(name: "", state: "", photo: "", specie: "")
}
