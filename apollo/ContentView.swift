//
//  ContentView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI

struct Song: Identifiable {
    let id: UUID = UUID()
    var title: String
    var artists: [String]
    var isExplicit: Bool = false
    var artwork: Image? = nil
    var lyrics: String? = nil
    var trackNumber: Int? = nil
    var credits: [Credit] = []
    var projectID: UUID? = nil // foreign key
}

struct Project: Identifiable {
    let id: UUID = UUID()
    var title: String
    var type: ProjectType
    var artwork: Image? = nil
    var releaseDate: Date? = nil
}

enum ProjectType {
    case album, ep, single
}

struct Credit: Identifiable {
    let id: UUID = UUID()
    var name: String
    var role: CreditRole
}

enum CreditRole {
    case performer, songwriter, producer, feature
}

enum Tabs: Equatable, Hashable {
    case library, search
}

struct ContentView: View {
    @State private var selectedTab: Tabs = .library
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Library", systemImage: "square.grid.2x2", value: .library) {
                LibraryTabView()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                Text("Search tab")
            }
        }
    }
}

#Preview {
    ContentView()
}
