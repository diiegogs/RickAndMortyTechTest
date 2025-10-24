//
//  AquaMarkView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI

struct AquaMarkView: View {
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text(text)
                        .font(.system(size: 8.0, weight: .bold))
                        .foregroundStyle(.blue.opacity(0.6))
                        .padding(.trailing, 5.0)
                }
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    AquaMarkView(text: "")
}
