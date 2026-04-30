//
//  Lyrics.swift
//  apollo
//
//  Created by Jason Yamoah on 4/29/26.
//

import Foundation

// .lrc format
struct LRCLine: Identifiable {
    var id = UUID()
    let timestamp: Double
    let lyric: String
}

func parseLRC(_ raw: String) -> [LRCLine] {
    raw.components(separatedBy: .newlines)
        .compactMap { line in
            // match [XX:XX.XX] pattern
            let pattern = /\[(\d{2}):(\d{2})\.(\d{2})\](.*)/
            guard let match = line.firstMatch(of: pattern) else { return nil }
            
            let minutes = Double(match.1) ?? 0
            let seconds = Double(match.2) ?? 0
            let centiseconds = Double(match.3) ?? 0
            
            let lyric = match.4.trimmingCharacters(in: .whitespaces)
            
            guard !lyric.isEmpty else { return nil }
            
            return LRCLine(
                timestamp: minutes * 60 + seconds + centiseconds / 100,
                lyric: lyric
            )
        }
        .sorted { $0.timestamp < $1.timestamp }
}
