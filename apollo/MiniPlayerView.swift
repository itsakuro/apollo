//
//  MiniPlayerView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/27/26.
//

import SwiftUI

struct MiniPlayerView: View {
    @State private var playback = PlaybackManager.shared
    
    var body: some View {
        HStack(spacing: 4) {
            Group {
                if let data = playback.currentSong?.artworkData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle()
                        .fill(Color.Backgrounds.secondary)
                        .overlay {
                            Image(ImageResource.Bubbly.musicNoteBeamed)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color.Labels.secondary.opacity(0.5))
                        }
                }
            }
            .frame(width: 32, height: 32)
            .clipShape(.rect(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 3) {
                    Text(playback.currentSong?.title ?? "Not Playing")
                        .fontWeight(.bold)
                    
                    if playback.currentSong?.isExplicit == true {
                        Image(systemName: "e.square.fill")
                            .foregroundStyle(Color.Labels.secondary)
                    }
                }
                .font(.subheadline)
                .fontWeight(.bold)
                
                Text(playback.currentSong?.artists.joined(separator: "; ") ?? "On this device")
                    .font(.caption)
                    .foregroundStyle(Color.Labels.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            
            HStack(spacing: 8) {
                Button {
                    playback.playPause()
                } label: {
                    Image(systemName: playback.isPlaying ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
                }
                
                Button {
                    playback.forward()
                } label: {
                    Image(systemName: "forward.fill")
                }
            }
            .padding(.horizontal)
        }
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(Color.Labels.primary)
        .contentShape(.rect)
    }
}
