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
        HStack(spacing: 8) {
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
            .frame(width: 30, height: 30)
            .clipShape(.rect(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 2) {
                    Text(playback.currentSong?.title ?? "Not Playing")
                        .fontWeight(.bold)
                    
                    if playback.currentSong?.isExplicit == true {
                        Image(ImageResource.Bubbly.explicitFill)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color.Labels.secondary)
                    }
                }
                .font(.footnote)
                .fontWeight(.bold)
                
                Text(playback.currentSong?.artists.joined(separator: "; ") ?? "On this device")
                    .font(.caption)
                    .foregroundStyle(Color.Labels.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            
            Button {
                playback.playPause()
            } label: {
                Group {
                    Image(playback.isPlaying ? ImageResource.Bubbly.pause : ImageResource.Bubbly.play)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                .frame(width: 32, height: 32)
            }
            
            Button {
                playback.forward()
            } label: {
                Group {
                    Image(ImageResource.Bubbly.skipAlt)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                .frame(width: 32, height: 32)
            }
        }
        .padding(.leading)
        .padding(.trailing, 12)
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(Color.Labels.primary)
        .contentShape(.rect)
    }
}

#Preview {
    MiniPlayerView()
}
