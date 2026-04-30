//
//  ContentView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI
import SwiftData

@Observable
class LibraryStore {
    static let shared = LibraryStore()
    var songs: [Song] = []
    
    func add(_ song: Song) {
        songs.append(song)
    }
}

@Model
class Song {
    var title: String
    var artists: [String]
    var isExplicit: Bool = false
    var artworkData: Data? = nil
    var lyrics: Lyrics? = nil
    var trackNumber: Int? = nil
    var fileBookmark: Data? = nil
    
    var project: Project? = nil
    var credits: [Credit] = []
    
    var fileURL: URL? {
        guard let bookmark = fileBookmark else { return nil }
        var stale = false
        return try? URL(
            resolvingBookmarkData: bookmark,
            bookmarkDataIsStale: &stale
        )
    }
    
    init(title: String, artists: [String], isExplicit: Bool = false, artworkData: Data? = nil, lyrics: Lyrics? = nil, fileBookmark: Data? = nil) {
        self.title = title
        self.artists = artists
        self.isExplicit = isExplicit
        self.artworkData = artworkData
        self.lyrics = lyrics
        self.fileBookmark = fileBookmark
    }
}

@Model
class Project {
    var title: String
    var type: ProjectType
    var artworkData: Data? = nil
    var releaseDate: Date? = nil
    @Relationship(deleteRule: .nullify, inverse: \Song.project)
    var songs: [Song] = []
    
    init(title: String, type: ProjectType, artworkData: Data? = nil, releaseDate: Date? = nil, songs: [Song]) {
        self.title = title
        self.type = type
//        self.artworkData = artworkData
//        self.releaseDate = releaseDate
//        self.songs = songs
    }
}

@Model
class Credit {
    var name: String
    var role: CreditRole
    var song: Song?
    
    init(name: String, role: CreditRole, song: Song? = nil) {
        self.name = name
        self.role = role
//        self.song = song
    }
}

enum ProjectType: Codable {
    case album, ep, single
}

enum CreditRole: Codable {
    case performer, songwriter, producer, feature
}

enum Lyrics: Codable {
    case ttml(String)
    case lrc(String)
    case raw(String)
}



enum Tabs: Equatable, Hashable {
    case library, search
}

struct ContentView: View {
    @State private var selectedTab: Tabs = .library
    @State private var showNowPlaying: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Library", systemImage: "square.grid.2x2", value: .library) {
                LibraryTabView(showNowPlaying: $showNowPlaying)
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                Text("Search tab")
            }
        }
        .tabViewBottomAccessory {
            MiniPlayerView()
                .onTapGesture {
                    showNowPlaying = true
                }
        }
    }
}

#Preview {
    ContentView()
}
