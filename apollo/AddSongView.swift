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
    
    @State private var songIsExplicit: Bool = false
    
    let explicitTag = Text(Image(ImageResource.explicitTag)).baselineOffset(-3).foregroundStyle(Color.Labels.secondary)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.Lists.background.ignoresSafeArea()
                
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
                                        .foregroundStyle(Color.Lists.background)
                                }
                            
                            VStack(spacing: 4) {
                                ZStack(alignment: .top) {
                                    Text("\(!songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? songTitle : "Title")\(songIsExplicit ? Text(" \(explicitTag)") : Text(""))")
                                        .foregroundStyle(!songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.Labels.primary : Color.Labels.secondary)
                                        .padding(.vertical, songIsExplicit ? 0 : 1.5)
                                        .scaleEffect(focusedField != .title ? 1 : 0.8)
                                        .blur(radius: focusedField != .title ? 0 : 4)
                                        .opacity(focusedField != .title ? 1 : 0)
                                        .contentShape(.rect)
                                        .onTapGesture {
                                            focusedField = .title
                                        }
                                        .allowsHitTesting(focusedField != .title)
                                    //                                        .background(
                                    //                                            GeometryReader { geometry in
                                    //                                                Color.clear
                                    //                                                    .onAppear {
                                    //                                                        print(geometry.size.height)
                                    //                                                    }
                                    //                                            }
                                    //                                        )
                                    
                                    TextField("", text: $songTitle, prompt: Text("Title").foregroundStyle(Color.Labels.secondary))
                                        .focused($focusedField, equals: .title)
                                        .scaleEffect(focusedField == .title ? 1 : 0.8)
                                        .blur(radius: focusedField == .title ? 0 : 4)
                                        .opacity(focusedField == .title ? 1 : 0)
                                }
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .animation(.snappy(duration: 0.2), value: songIsExplicit)
                                .animation(.snappy(duration: 0.2), value: focusedField)
                                
                                ZStack(alignment: .top) {
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
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        focusedField = .artists
                                    }
                                    .allowsHitTesting(focusedField != .artists)
                                    
                                    TextField("", text: $songArtists, prompt: Text("Artists; separated by semicolon").foregroundStyle(Color.Labels.secondary))
                                        .font(.title2)
                                        .focused($focusedField, equals: .artists)
                                        .scaleEffect(focusedField == .artists ? 1 : 0.8)
                                        .blur(radius: focusedField == .artists ? 0 : 4)
                                        .opacity(focusedField == .artists ? 1 : 0)
                                }
                                .multilineTextAlignment(.center)
                                .animation(.snappy(duration: 0.2), value: focusedField)
                            }
                            

                            VStack(alignment: .leading, spacing: 4) {
                                ListHeader(Text("Content"))
                                
                                VStack(spacing: 1) {
                                    ListRow {
                                        Image(ImageResource.Bubbly.explicitFill)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(Color.Labels.secondary)
                                            .frame(width: 24, height: 24)
                                        
                                        Text("Explicit")
                                        
                                        Spacer()
                                        
                                        Toggle("Explicit", isOn: $songIsExplicit)
                                            .tint(.mint)
                                            .labelsHidden()
                                    }
                                    ListRow {
                                        Image(ImageResource.Bubbly.quoteBubbleFill)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(Color.Labels.secondary)
                                            .frame(width: 24, height: 24)
                                            .opacity(0.5)
                                        
                                        Text("Lyrics support coming soon")
                                            .italic()
                                            .foregroundStyle(Color.Labels.secondary)
                                    }
                                }
                                .clipShape(.rect(cornerRadius: 26))
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
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
                    Text("Add a song")
                        .fontWeight(.semibold)
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
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Labels.primary)
        }
    }
}

#Preview {
    AddSongView()
}
