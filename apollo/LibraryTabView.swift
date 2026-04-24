//
//  LibraryTabView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI

struct LibraryTabView: View {
    @State private var library = LibraryStore.shared
    @State private var showingAddSongSheet: Bool = false
    
//    @State private var showingAddNew: Bool = false
//    @State private var showingAddSource: Bool = false
//    @State private var showingExpandedContent: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Lists.background.ignoresSafeArea()
                
                if library.songs.isEmpty {
                    VStack(spacing: 0) {
                        Text("Your library’s a little empty")
                            .fontWeight(.bold)
                        
                        Text("You should add a song or a project.")
                            .foregroundStyle(Color.Labels.secondary)
                    }
                    .padding(.horizontal, 24)
                } else {
                    ScrollView {
                        VStack(spacing: 1) {
                            ForEach(library.songs) { song in
                                HStack(spacing: 12) {
                                    Group {
                                        if let data = song.artworkData,
                                           let image = UIImage(data: data) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                        } else {
                                            RoundedRectangle(cornerRadius: 36)
                                                .fill(Color.Backgrounds.secondary)
                                                .overlay {
                                                    Image(ImageResource.Bubbly.musicNoteBeamed)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .foregroundStyle(Color.Labels.secondary.opacity(0.05))
                                                        .frame(width: 36, height: 36)
                                                }
                                        }
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(.rect(cornerRadius: 6))
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(song.title)
                                            .fontWeight(.bold)
                                        Text(song.artists.joined(separator: "; "))
                                            .foregroundStyle(Color.Labels.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(1)
                                    
                                    Button {
                                        PlaybackManager.shared.play(song: song)
                                    } label: {
                                        Label("Play", systemImage: "play.fill")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .labelStyle(.iconOnly)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(Color.Lists.foreground)
                            }
                        }
                        .clipShape(.rect(cornerRadius: 18))
                    }
                    .padding(.horizontal, 24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        withAnimation(.bouncy) {
                            showingAddSongSheet = true
                        }
                    } label: {
                        Label("Add an item", systemImage: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $showingAddSongSheet) {
                        AddSongView()
                    }
                }
            }
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Labels.primary)
        }
    }
    
//    // Menu
//    @ViewBuilder
//    func RowView(_ image: String, _ title: String) -> some View {
//        HStack(spacing: 18) {
//            Image(systemName: image)
//                .font(.title2)
//                .frame(width: 48, height: 48)
//                .background(.background, in: .rect(cornerRadius: 12))
//            
//            VStack(alignment: .leading, spacing: 0) {
//                Text(title)
//                    .fontWeight(.bold)
//                    .foregroundStyle(Color.Labels.primary)
//                
//                Text("Description")
//                    .fontWeight(.medium)
//                    .foregroundStyle(Color.Labels.secondary)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//        .padding(.horizontal)
//        .padding(.vertical, 12)
//        .contentShape(.rect)
//        .onTapGesture {
//            showingExpandedContent.toggle()
//        }
//    }
}

#Preview {
    LibraryTabView()
}
