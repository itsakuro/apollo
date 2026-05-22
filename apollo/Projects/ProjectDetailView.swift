//
//  ProjectDetailView.swift
//  apollo
//
//  Created by Jason Yamoah on 5/19/26.
//

import SwiftUI

struct ProjectDetailView: View {
    @Bindable var project: Project

    @State private var artworkWidth: CGFloat = .zero

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 28) {
                    Group {
                        if let data = project.artworkData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Rectangle()
                                .fill(Color.Backgrounds.secondary)
                                .overlay {
                                    Image(ImageResource.Bubbly.musicNoteBeamed)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.Labels.secondary.opacity(0.05))
                                        .frame(width: 128)
                                }
                        }
                    }
                    .frame(width: artworkWidth, height: artworkWidth)
                    .clipShape(.rect(cornerRadius: 26))
                    .glassEffect(.regular, in: .rect(cornerRadius: 26))
                    .onAppear {
                        if geometry.isLandscape {
                            artworkWidth = geometry.size.height - 92
                        } else {
                            artworkWidth = geometry.size.width - 48
                        }
                    }
                    .onChange(of: geometry.size.width) { _, newWidth in
                        if geometry.isLandscape {
                            artworkWidth = geometry.size.height - 92
                        } else {
                            artworkWidth = geometry.size.width - 48
                        }
                    }
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 4) {
                            Text("DIFFERENT - Single")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Image(ImageResource.Bubbly.explicitFill)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.NowPlaying.Labels.secondary)
                                .frame(width: 20, height: 20)
                                .blendMode(.plusLighter)
                                .allowedDynamicRange(.standard)
                        }

                        Text("LE SSERAFIM")
                            .foregroundStyle(Color.NowPlaying.Labels.secondary)
                            .blendMode(.plusLighter)
                            .allowedDynamicRange(.standard)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        print("Search in project")
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                }
            }
        }
    }
}

#Preview {
    ProjectDetailView()
}