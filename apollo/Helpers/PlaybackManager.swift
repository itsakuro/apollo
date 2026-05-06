//
//  PlaybackManager.swift
//  apollo
//
//  Created by Jason Yamoah on 4/23/26.
//

import Foundation
import AVFoundation
import MediaPlayer

@Observable
class PlaybackManager {
    static let shared = PlaybackManager()
    
    var player: AVPlayer?
    var currentSong: Song?
    var isPlaying: Bool = false
    var currentTime: Double = 0.0
    var duration: Double = 0.0
    var volume: Float = 1.0
    var isFavorited: Bool = false
    
    private var timeObserver: Any?
    
    init() {
        setupAudioSession()
        setupRemoteControls()
    }
    
    // AUDIO SESSION
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("audio session error ... : \(error)")
        }
    }
    
    // PLAYBACK
    func play(song: Song) {
        guard let url = song.fileURL else { return }
        
        stop() // clean up previous
        
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        currentSong = song
        
        // observe duration when ready
        Task {
            if let seconds = try? await item.asset.load(.duration) {
                duration = seconds.seconds
                updateNowPlayingInfo()
            }
        }
        
        // observe current time every half a second
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.5, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time.seconds
        }
        
        player?.play()
        isPlaying = true
        updateNowPlayingInfo()
    }
    
    func playPause() {
        guard let player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        updateNowPlayingInfo()
    }
    
    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 600))
        currentTime = time
        updateNowPlayingInfo()
    }
    
    func stop() {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
        player?.pause()
        player = nil
        isPlaying = false
        currentTime = 0
        duration = 0
    }
    
    // NOW PLAYING INFO
    
    func updateNowPlayingInfo() {
        guard let song = currentSong else { return }
        
        var info: [String: Any] = [
            MPMediaItemPropertyTitle: song.isExplicit ? "\(song.title) 🅴" : song.title,
            MPMediaItemPropertyArtist: song.artists.joined(separator: "; "),
            MPNowPlayingInfoPropertyElapsedPlaybackTime: currentTime,
            MPMediaItemPropertyPlaybackDuration: duration,
            MPNowPlayingInfoPropertyPlaybackRate: isPlaying ? 1.0: 0.0
        ]
        
        // Artwork
        if let artworkData = song.artworkData,
           let image = UIImage(data: artworkData) {
            info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(
                boundsSize: image.size
            ) { _ in
                image
            }
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    }
    
    func backward() {
        if currentTime > 3 {
            seek(to: 0)
        }
    }
    
    func forward() {
        print("Okay")
    }
    
    // REMOTE CONTROLS
    
    private func setupRemoteControls() {
        let center = MPRemoteCommandCenter.shared()
        
        center.previousTrackCommand.addTarget { [weak self] _ in
            self?.backward()
            return .success
        }
        
        center.nextTrackCommand.addTarget { [weak self] _ in
            self?.forward()
            return .success
        }
        
        center.playCommand.addTarget { [weak self] _ in
            self?.playPause()
            return .success
        }
        
        center.pauseCommand.addTarget { [weak self] _ in
            self?.playPause()
            return .success
        }
        
        center.changePlaybackPositionCommand.addTarget { [weak self] event in
            if let e = event as? MPChangePlaybackPositionCommandEvent {
                self?.seek(to: e.positionTime)
            }
            return .success
        }
    }
}
