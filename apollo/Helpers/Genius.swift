//
//  Genius.swift
//  apollo
//
//  Created by Jason Yamoah on 4/25/26.
//

import Foundation

struct GeniusReponse: Codable {
    let response: GeniusResponseBody
}

struct GeniusResponseBody: Codable {
    let song: GeniusSong
}

struct GeniusSong: Codable {
    let title: String
    let language: String?
    let artists: String
    let writers: [GeniusArtist]
    
    enum CodingKeys: String, CodingKey {
        case title
        case language
        case artists = "artist_names"
        case writers = "writer_artists"
    }
}

struct GeniusArtist: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let imageURL: String
    let headerImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case imageURL = "image_url"
        case headerImageURL = "header_image_url"
    }
}

func fetchGeniusSong(_ id: Int) async throws -> GeniusSong {
    let url = URL(string: "https://api.genius.com/songs/\(id)")!
    var request = URLRequest(url: url)
    request.setValue("Bearer \(Secrets.geniusClientID)", forHTTPHeaderField: "Authorization")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let decoded = try JSONDecoder().decode(GeniusReponse.self, from: data)
    return decoded.response.song
}

func searchGenius(_ query: String) async throws {
    guard let url = URL(string: /*"https://api.genius.com/search?q=\(query)"*/ "https://api.genius.com/songs/11487113") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    request.setValue("Bearer \(Secrets.geniusClientID)", forHTTPHeaderField: "Authorization")
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
            print("-------")
        }
    } catch {
        print("Error: \(error)")
    }
}
