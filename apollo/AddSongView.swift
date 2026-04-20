//
//  AddSongView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI

enum SongField {
    case title, artists
}

struct AddSongView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: SongField?
    
    @State private var songTitle: String = ""
    @State private var songArtists: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.List.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 28) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.fill.tertiary)
                                .frame(width: 200, height: 200)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .imageScale(.large)
                                        .foregroundStyle(.background)
                                }
                            
                            VStack(spacing: 4) {
                                Text("Title")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Button {
                                    withAnimation(.snappy(duration: 0.2)) {
                                        focusedField = .artists
                                    }
                                } label: {
                                    HStack(spacing: 4) {
                                        if songArtists.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                            Image(systemName: "plus")
                                        }
                                        
                                        Text(!songArtists.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "\(songArtists) song" : "Add artists")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4.5)
                                    .background(.fill.tertiary)
                                    .clipShape(.rect(cornerRadius: 8))
                                }
                                .buttonStyle(.plain)
                            }

                            //
                        }
                    }
                }
            }
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Discard changes", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add a song")
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Save changes", systemImage: "checkmark")
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddSongView()
}
