//
//  apolloApp.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI
import SwiftData

@main
struct apolloApp: App {
    var body: some Scene {
        WindowGroup {
//            AddSongView()
            ContentView()
        }
        .modelContainer(for: [Song.self, Project.self, Credit.self])
    }
}
