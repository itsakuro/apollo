//
//  EditSongView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI

struct EditSongView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: SongField?
    
    @State private var songTitle: String = ""
    @State private var songArtists: String = ""
    
    @State private var geniusSong: GeniusSong?
    @State private var fetchingGeniusSong: Bool = false
    @State private var initialFetch: Bool = false
    
//    @FocusState private var focusedSongTitle: Bool
//    @State private var editingSongTitle: Bool = false
//    @FocusState private var focusedSongArtists: Bool
//    @State private var editingSongArtists: Bool = false
    
    @State private var songIsExplicit: Bool = false
    @State private var explicitTagWidth: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
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
                            ZStack {
                                HStack(spacing: 0) {
                                    Text(!songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? songTitle : "Title")
                                        .foregroundStyle(!songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .primary : .tertiary)
                                        .onTapGesture {
                                            focusedField = .title
                                        }
                                        .scaleEffect(focusedField != .title ? 1 : 0.8)
                                        .blur(radius: focusedField != .title ? 0 : 4)
                                        .opacity(focusedField != .title ? 1 : 0)
                                    
                                    Image(systemName: "e.square.fill")
                                        .foregroundStyle(.secondary)
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear
                                                    .onAppear {
                                                        explicitTagWidth = geometry.size.width + 5
                                                    }
                                            }
                                        )
                                        .frame(width: songIsExplicit ? explicitTagWidth : 0, alignment: .trailing)
                                        .scaleEffect(focusedField != .title ? 1 : 0.8)
                                        .blur(radius: focusedField != .title ? 0 : 4)
                                        .opacity(focusedField != .title ? 1 : 0)
                                        .scaleEffect(songIsExplicit ? 1 : 0.8)
                                        .blur(radius: songIsExplicit ? 0 : 4)
                                        .opacity(songIsExplicit ? 1 : 0)
                                }
                                .animation(.snappy(duration: 0.2), value: songIsExplicit)
                                
                                TextField("", text: $songTitle, prompt: Text("Title"))
                                    .multilineTextAlignment(.center)
                                    .focused($focusedField, equals: .title)
                                    .scaleEffect(focusedField == .title ? 1 : 0.8)
                                    .blur(radius: focusedField == .title ? 0 : 4)
                                    .opacity(focusedField == .title ? 1 : 0)
                                    .onChange(of: songTitle) { oldValue, newValue in
                                        Task {
                                            try await searchGenius(newValue)
                                        }
                                    }
                                    .onSubmit {
                                        geniusSong = nil
                                        
                                        withAnimation(.smooth(duration: 0.4)) {
                                            initialFetch = true
                                            fetchingGeniusSong = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            Task {
                                                do {
                                                    geniusSong = try await fetchGeniusSong(11487113)
                                                    
                                                    withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
                                                        fetchingGeniusSong = false
                                                    }
                                                } catch {
                                                    print("couldn’t fetch song data from Genius : \(error)")
                                                    fetchingGeniusSong = false
                                                }
                                            }
                                        }
                                    }
                            }
                            .font(.title)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            
                            ZStack {
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
                                .scaleEffect(focusedField != .artists ? 1 : 0.8)
                                .blur(radius: focusedField != .artists ? 0 : 4)
                                .opacity(focusedField != .artists ? 1 : 0)
                                
                                TextField("", text: $songArtists, prompt: Text("Artists"))
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .fontDesign(.rounded)
                                    .multilineTextAlignment(.center)
                                    .focused($focusedField, equals: .artists)
                                    .scaleEffect(focusedField == .artists ? 1 : 0.8)
                                    .blur(radius: focusedField == .artists ? 0 : 4)
                                    .opacity(focusedField == .artists ? 1 : 0)
                            }
                        }
                    }
                    
                    if initialFetch {
                        ZStack {
                            if fetchingGeniusSong {
                                HStack(spacing: 4) {
                                    ProgressView()
                                    
                                    Text("Fetching from Genius...")
                                        .foregroundStyle(Color.Labels.secondary)
                                }
                                .transition(
                                    .scale(scale: 0.8)
                                    .combined(with: .opacity)
                                )
                            } else if geniusSong != nil {
                                VStack {
                                    HStack(spacing: 12) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            VStack(alignment: .leading, spacing: 0) {
                                                Text("\(geniusSong?.title ?? "?") \(Text("by").foregroundStyle(Color.Labels.secondary)) \(geniusSong?.artists ?? "?")")
                                                    .font(.footnote)
                                                
                                                Text("Info found from Genius")
                                            }
                                            .fontWeight(.bold)
                                            
                                            Text("Artwork, song language, and credits")
                                                .font(.subheadline)
                                                .foregroundStyle(Color.Labels.secondary)
                                        }
                                    }
                                }
                                .padding()
                                .transition(
                                    .scale(scale: 0.8)
                                    .combined(with: .opacity)
                                )
                            } else {
                                Text("HULLO ???")
                            }
                        }
                        .frame(minHeight: 22)
                    }
                    
                    VStack(spacing: 1) {
                        HStack(spacing: 4) {
                            //                            Text("Explicit")
                            Toggle("Explicit", isOn: $songIsExplicit)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .padding(.horizontal)
                                .frame(height: 54)
                                .background(.fill.quaternary)
                                .clipShape(.rect(cornerRadius: 26))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Discard changes", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Edit song")
                        .fontWeight(.medium)
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
            .transition(.offset(x: -100).combined(with: .opacity).animation(.snappy(duration: 0.2)))
        }
    }
}

#Preview {
    EditSongView()
}
