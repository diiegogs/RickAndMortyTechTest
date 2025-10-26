//
//  UNetworkView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 25/10/25.
//

import SwiftUI

struct UNetworkView: View {
    private var makeTextNetwork: AttributedString {
        var textPlease: AttributedString = AttributedString("Por favor, ")
        textPlease.font = .system(size: 16.0)
            
        var textConnect: AttributedString = AttributedString("conéctate a una red Wi-Fi o activa los datos móviles ")
        textConnect.font = .system(size: 16.0, weight: .bold)
        
        var textForContinue: AttributedString = AttributedString("para continuar utilizando la aplicación.")
        textForContinue.font = .system(size: 16.0)
        
        var responseText = (textPlease + textConnect + textForContinue)
        responseText.foregroundColor = .black.opacity(0.6)
        
        return responseText
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 60.0))
                .foregroundColor(.blue.opacity(0.6))
            
            Text(makeTextNetwork)
                .font(.system(size: 16.0))
                .foregroundColor(.black.opacity(0.9))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    UNetworkView()
}
