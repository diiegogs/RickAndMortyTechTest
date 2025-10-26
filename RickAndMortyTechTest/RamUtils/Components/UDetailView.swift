//
//  UDetailView.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import SwiftUI
import AVKit

struct UDetailView: View {
    private var name: String
    private var image: String
    private var gender: String
    private var specie: String
    private var episodes: [Episode]
    private var textEpisodes: String = ""
    private var actionOverLay: (() -> Void)
    
    private var textGender: AttributedString {
        var attributed = AttributedString(gender.translatedGender)
        let color: Color = {
            switch gender.translatedGender {
                case "Hombre": return .blue
                case "Mujer": return .pink
                default: return .black
            }
        }()
        
        attributed.foregroundColor = color
        return attributed
    }
    
    init(name: String,
         image: String,
         gender: String,
         specie: String,
         episodes: [Episode],
         actionOverLay: @escaping () -> Void) {
            self.name = name
            self.image = image
            self.gender = gender
            self.specie = specie
            self.episodes = episodes
            self.actionOverLay = actionOverLay
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .transition(.opacity)
                .onTapGesture {
                    actionOverLay()
                }
            
            VStack {
                VStack(spacing: 16.0) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation(.spring()) {
                                actionOverLay()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 20.0, height: 20.0)
                            
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Text(name)
                        .font(.title2)
                        .bold()
                    
                    AsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        Text(specie)
                            .foregroundStyle(.black.opacity(0.7))
                            .font(.system(size: 14.0, weight: .bold))
                            .lineLimit(2)
                        
                        Divider()
                        
                        Text(textGender)
                            .font(.system(size: 14.0, weight: .semibold))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20.0) {
                            ForEach(episodes) { episode in
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    if let videoURL = URL(string: episode.url) {
                                        VideoPlayer(player: AVPlayer(url: videoURL))
                                            .frame(height: 100)
                                            .clipped()
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(episode.name)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        
                                        Text(episode.episode)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        
                                        Text(episode.airDate)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                    }
                                    .padding(8)
                                    
                                    Spacer()
                                }
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12.0)
                                .shadow(color: Color.black.opacity(0.2), radius: 4.0, x: 0, y: 2.0)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(24.0)
                .shadow(radius: 10.0)
                Spacer()
            }
            .transition(.scale.combined(with: .opacity))
        }
    }
}

#Preview {
    UDetailView(name: "", image: "", gender: "", specie: "", episodes: []) { }
}
