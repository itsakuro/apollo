//
//  AddSongView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI
import AVFoundation
import SwiftData

enum SongField {
    case title, artists
}

struct SongMetadata {
    var title: String?
    var artists: [String]?
    var artworkData: Data?
    var trackNumber: Int?
    var totalTracks: Int?
    var releaseDate: Date?
    var projectTitle: String?
}

struct AddSongView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // Upload
    
    @State private var isFilePickerShowing: Bool = false
    @State private var isFindingMetadata: Bool = false
    @State private var foundMetadata: SongMetadata? = nil
    @State private var savedDestination: URL? = nil
    
    // Details
    
    @FocusState private var focusedField: SongField?
    
    @State private var songTitle: String = ""
    @State private var songArtists: String = ""
    
    @State private var songIsExplicit: Bool = false
    
    @State private var songLyrics: String = ""
    
    let explicitTag = Text(Image(ImageResource.explicitTag)).baselineOffset(-3).foregroundStyle(Color.Labels.secondary)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.Lists.background.ignoresSafeArea()
                
                
                
                if !isFindingMetadata && foundMetadata == nil {
                    Text("Pick your audio file")
                        .fileImporter(
                            isPresented: $isFilePickerShowing,
                            allowedContentTypes: [.mp3, .mpeg4Audio, .aiff, .wav],
                            allowsMultipleSelection: true
                        ) { result in
                            switch result {
                            case .success(let urls):
                                Task {
                                    await handlePickedFiles(urls)
                                }
                            case .failure:
                                print("Upload failed")
                            }
                        }
                        .onTapGesture {
                            isFilePickerShowing.toggle()
                        }
                } else if isFindingMetadata {
                    Text("Finding...")
                } else if foundMetadata != nil {
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
                                        NavigationLink {
                                            EditLyricsView(lyrics: $songLyrics)
                                        } label: {
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
                                    }
                                    .clipShape(.rect(cornerRadius: 26))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
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
                        saveSong()
                        dismiss()
                    } label: {
                        Label("Save changes", systemImage: "checkmark")
                    }
                    .disabled(songTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Labels.primary)
        }
    }
    
    func handlePickedFiles(_ urls: [URL]) async {
        for url in urls {
            isFindingMetadata = true
            
            guard url.startAccessingSecurityScopedResource() else { return }
            defer { url.stopAccessingSecurityScopedResource() }
            
            guard let destination = try? await copyToDocuments(url) else {
                print("Failed to copy file")
                return
            }
            
            savedDestination = destination
            
            let metadata = await extractMetadata(from: destination)
            
            if urls.count == 1 {
                foundMetadata = metadata
                songTitle = metadata.title ?? ""
                songArtists = metadata.artists?.joined(separator: "; ") ?? ""
                // extra metadata will be added later ... im lazy and i wanna see proof of concept ok
                
                isFindingMetadata = false
                print("uploaded one song")
            } else {
//                await batchAdd(metadata, fileURL: destination)
                print("Batch add eventually")
            }
        }
    }
    
    func copyToDocuments(_ url: URL) async throws -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let songsFolder = documentsURL.appendingPathComponent("songs")
        
        try FileManager.default.createDirectory(
            at: songsFolder,
            withIntermediateDirectories: true
        )
        
        let ext = url.pathExtension
        let destination = songsFolder.appendingPathComponent("\(UUID()).\(ext)")
        
        try FileManager.default.copyItem(at: url, to: destination)
        return destination
    }
    
    func extractMetadata(from url: URL) async -> SongMetadata {
        let asset = AVURLAsset(url: url)
        var metadata = SongMetadata()
        
        guard let items = try? await asset.load(.commonMetadata) else {
            return parseFilename(url.deletingPathExtension().lastPathComponent)
        }
        
        for item in items {
            guard let value = try? await item.load(.value) else { continue }
            
            switch item.commonKey {
            case .commonKeyTitle:
                metadata.title = value as? String
            case .commonKeyArtist:
                // split by semicolon
                if let artist = value as? String {
                    metadata.artists = artist
                        .split(separator: ";")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                }
            case .commonKeyArtwork:
                metadata.artworkData = value as? Data
            default:
                break
            }
        }
        
        return metadata
    }
    
    func parseFilename(_ name: String) -> SongMetadata {
        var metadata = SongMetadata()
        
        // try "Artist - Title"
        let dashComponents = name.components(separatedBy: " - ")
        if dashComponents.count == 2 {
            metadata.artists = [dashComponents[0].trimmingCharacters(in: .whitespaces)]
            metadata.title = dashComponents[1].trimmingCharacters(in: .whitespaces)
            return metadata
        }
        
        metadata.title = name
        return metadata
    }
    
    func saveSong() {
        guard let destination = savedDestination else { return }
        
        let bookmark = try? destination.bookmarkData(
            options: .minimalBookmark,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        
        let song = Song(
            title: songTitle.trimmingCharacters(in: .whitespacesAndNewlines),
            artists: songArtists.split(separator: "; ").map {
                $0.trimmingCharacters(in: .whitespaces)
            }.filter { !$0.isEmpty },
            isExplicit: songIsExplicit,
            artworkData: foundMetadata?.artworkData,
            lyrics: .lrc(songLyrics),
            fileBookmark: bookmark
        )
        
        modelContext.insert(song)
        try? modelContext.save()
    }
}

#Preview {
    AddSongView()
}
