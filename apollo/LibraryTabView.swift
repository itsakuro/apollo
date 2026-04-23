//
//  LibraryTabView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI

struct LibraryTabView: View {
    @State private var showingAddNew: Bool = false
    @State private var showingAddSource: Bool = false
    
    @State private var showingAddSong: Bool = false
    
    @State private var showingExpandedContent: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Backgrounds.primary.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text("Your library’s a little empty")
                        .fontWeight(.bold)
                    
                    Text("You should add a song or a project.")
                        .foregroundStyle(Color.Labels.secondary)
                }
                .padding(.horizontal, 24)
                
//                ScrollView {
//
//                }
            }
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    Button {
//                        withAnimation(.bouncy) {
//                            showingAddNew = true
//                        }
//                    } label: {
//                        Label("Add an item", systemImage: "plus")
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .sheet(isPresented: $showingAddNew, onDismiss: {
//                        showingAddSource = false
//                    }) {
//                        ZStack {
//                            Color.Backgrounds.primary.ignoresSafeArea()
//                            
//                            VStack(alignment: .leading, spacing: 0) {
//                                Text("Add new")
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                                    .padding(.horizontal)
//                                    .padding(.bottom, 4)
//                                    .frame(height: 41, alignment: .bottom)
//                                
//                                Button {
//                                    print("Add new song")
//                                    showingAddNew = false
//                                    showingAddSong = true
//                                } label: {
//                                    HStack(spacing: 12) {
//                                        ZStack {
//                                            RoundedRectangle(cornerRadius: 12)
//                                                .fill(Color.Backgrounds.primary)
//                                                .frame(width: 48, height: 48)
//                                            
//                                            HStack {
//                                                Image(ImageResource.Bubbly.musicNoteBeamed)
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .foregroundStyle(.accent)
//                                                    .frame(width: 40, height: 40)
//                                            }
//                                            .frame(width: 48, height: 48)
//                                            .background(.accent.opacity(0.15))
//                                            .clipShape(.rect(cornerRadius: 12))
//                                        }
//                                        
//                                        VStack(alignment: .leading, spacing: 0) {
//                                            Text("Song")
//                                                .fontWeight(.bold)
//                                            Text(".mp3, .m4a, .aiff, or .wav")
//                                                .font(.subheadline)
//                                                .foregroundStyle(Color.Labels.secondary)
//                                        }
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 12)
//                                }
//                                .buttonStyle(.plain)
//                                
//                                Button {
//                                    print("Add new project")
//                                } label: {
//                                    HStack(spacing: 12) {
//                                        ZStack {
//                                            RoundedRectangle(cornerRadius: 12)
//                                                .fill(Color.Backgrounds.primary)
//                                                .frame(width: 48, height: 48)
//                                            
//                                            HStack {
//                                                Image(ImageResource.Bubbly.musicNoteBeamed)
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .foregroundStyle(.accent)
//                                                    .frame(width: 40, height: 40)
//                                            }
//                                            .frame(width: 48, height: 48)
//                                            .background(.accent.opacity(0.15))
//                                            .clipShape(.rect(cornerRadius: 12))
//                                        }
//                                        
//                                        VStack(alignment: .leading, spacing: 0) {
//                                            Text("Project")
//                                                .fontWeight(.bold)
//                                            Text("Albums, EPs, singles")
//                                                .font(.subheadline)
//                                                .foregroundStyle(Color.Labels.secondary)
//                                        }
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 12)
//                                }
//                                .buttonStyle(.plain)
//                            }
//                            .padding(8)
//                        }
//                        .presentationDetents([.height(201)])
//                    }
//                    .sheet(isPresented: $showingAddSong) {
//                        AddSongView()
//                    }
//                }
//                
////                ToolbarItem(placement: .largeTitle) {
////                    Text("Library")
////                        .font(.largeTitle)
////                        .fontWeight(.bold)
////                        .frame(maxWidth: .infinity, alignment: .leading)
////                        .padding(.horizontal, 8)
////                }
//            }
//            .toolbarTitleDisplayMode(.inlineLarge)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Labels.primary)
        }
        .overlay(alignment: .bottomTrailing) {
            LibraryAddButton(showingExpandedContent: $showingExpandedContent) {
                Text("Add")
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .padding()
            } content: {
                VStack(alignment: .leading, spacing: 0) {
                    RowView("music.note", "Song")
                    RowView("square.stack.fill", "Project")
                }
            } expandedContent: {
                AddSongView()
            }
            .padding()
        }
    }
    
    // Menu
    @ViewBuilder
    func RowView(_ image: String, _ title: String) -> some View {
        HStack(spacing: 18) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 48, height: 48)
                .background(.background, in: .rect(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.Labels.primary)
                
                Text("Description")
                    .fontWeight(.medium)
                    .foregroundStyle(Color.Labels.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .contentShape(.rect)
        .onTapGesture {
            showingExpandedContent.toggle()
        }
    }
}

#Preview {
    LibraryTabView()
}
