//
//  NowPlayingView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI
import MediaPlayer

struct NowPlayingView: View {
    @State private var playback = PlaybackManager.shared
    @State private var isDraggingPlayback = false
    @State private var isDraggingVolume = false
    @State private var scrubTime: Double = 0.0
    
    @State private var artworkWidth: CGFloat = .zero

    var body: some View {
        ZStack {
            Color.Backgrounds.primary.ignoresSafeArea()
            
            if let data = playback.currentSong?.artworkData, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 100)
                    .opacity(0.6)
            }
            
            GeometryReader { geometry in
                VStack(spacing: 28) {
                    Group {
                        if let data = playback.currentSong?.artworkData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            RoundedRectangle(cornerRadius: 36)
                                .fill(Color.Backgrounds.secondary)
                                .overlay {
                                    Image(ImageResource.Bubbly.musicNoteBeamed)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(Color.Labels.secondary.opacity(0.05))
                                        .frame(width: 96, height: 96)
                                }
                        }
                    }
                    .frame(width: artworkWidth, height: artworkWidth)
                    .onAppear {
                        artworkWidth = geometry.size.width
                    }
                    .onChange(of: geometry.size.width) { oldValue, newValue in
                        artworkWidth = newValue
                    }
                    .clipShape(.rect(cornerRadius: 36))
                    .scaleEffect(playback.isPlaying ? 1 : 0.8)
                    .animation(.spring(duration: 0.6, bounce: 0.4), value: playback.isPlaying)
                    
                    HStack(spacing: 4) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(playback.currentSong?.title ?? "Not Playing")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(playback.currentSong?.artists.joined(separator: "; ") ?? "On this device")
                                .foregroundStyle(Color.Labels.secondary)
                        }
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
                                playback.isFavorited.toggle()
                            }
                        } label: {
                            Image(systemName: "heart")
                                .font(.title2)
                                .foregroundStyle(playback.isFavorited ? .accent : Color.Labels.secondary.opacity(0.5))
                                .symbolEffect(.bounce, value: playback.isFavorited)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 12)
                    
                    VStack(spacing: 4) {
                        Slider(
                            value: isDraggingPlayback ? $scrubTime : .init(
                                get: { playback.currentTime },
                                set: { playback.seek(to: $0) }
                            ),
                            in: 0...(playback.duration > 0 ? playback.duration : 1)
                        ) { editing in
                            isDraggingPlayback = editing
                            if !editing {
                                playback.seek(to: scrubTime)
                            }
                        }
                        .tint(.primary)
                        
                        HStack {
                            Text(formatTime(isDraggingPlayback ? scrubTime : playback.currentTime))
                            
                            Spacer()
                            
                            Text(formatTime(playback.duration))
                        }
                        .font(.caption)
                        .foregroundStyle(Color.Labels.secondary)
                        .monospacedDigit()
                    }
                    
                    HStack(spacing: 32) {
                        Button {
//                            if playback.curentTime > 3 {
                                playback.seek(to: 0)
//                            } else {
//                                print("Previous in queue")
//                            }
                        } label:{
                            Image(systemName: "backward.fill")
                                .font(.title)
                                .imageScale(.large)
                                .frame(width: 72, height: 72)
                                .contentShape(.circle)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            playback.playPause()
                        } label:{
                            Image(systemName: playback.isPlaying ? "pause.fill" : "play.fill")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
                                .frame(width: 72, height: 72)
                                .contentShape(.circle)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            print("Next in queue")
                        } label:{
                            Image(systemName: "forward.fill")
                                .font(.title)
                                .imageScale(.large)
                                .frame(width: 72, height: 72)
                                .contentShape(.circle)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    VStack(spacing: 8) {
                        Slider(value: $playback.volume, in: 0...1) { _ in }
                            .tint(.primary)
                            .onChange(of: playback.volume) { _, newValue in
                                AVAudioSession.sharedInstance().outputVolume
                                
                                playback.player?.volume = newValue
                            }
                        
                        HStack {
                            Image(systemName: "speaker.fill")
                            Spacer()
                            Image(systemName: "speaker.wave.3.fill")
                        }
                        .font(.caption)
                        .foregroundStyle(Color.Labels.secondary)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(Color.Labels.primary)
    }
    
    func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite else { return "0:00" }
        let s = Int(seconds)
        return "\(s / 60):\(String(format: "%02d", s % 60))"
    }
}

#Preview {
    NowPlayingView()
}
