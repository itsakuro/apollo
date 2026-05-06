//
//  NowPlayingView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI
import MediaPlayer
import CoreImage
import CoreImage.CIFilterBuiltins
import Glur

extension UIImage {
    func blurred(radius: CGFloat) -> UIImage {
        guard let ciImage = CIImage(image: self) else { return self }
        let context = CIContext()
        
        let clamped = ciImage.clampedToExtent()
        
        let blurFilter = CIFilter.gaussianBlur()
        blurFilter.inputImage = clamped
        blurFilter.radius = Float(radius)
        
        guard let output = blurFilter.outputImage else { return self }
        
        let cropped = output.cropped(to: ciImage.extent)
        
        guard let cgImage = context.createCGImage(cropped, from: cropped.extent) else { return self }
        return UIImage(cgImage: cgImage)
    }
}

extension GeometryProxy {
    var isLandscape: Bool { size.width > size.height }
}

struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1)
            .animation(.interpolatingSpring(.bouncy), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == BouncyButtonStyle {
    static var bouncy: Self { Self() }
}

enum FavoritePhase: CaseIterable {
    case initial
    case scale
    case favorited
    
    var scale: Double {
        switch self {
        case .initial, .favorited: 1
        case .scale: 1.3
        }
    }
}

struct PlaybackProgressBar: View {
    @State private var progressTrackWidth: CGFloat = .zero
    
    @State private var progress: Double = 0.0
    var onEditingChanged: (Bool) -> Void
    
    @GestureState private var isScrubbing: Bool = false
    @State private var scrubProgress: Double? = nil
    
    private var displayProgress: Double {
        scrubProgress ?? progress
    }
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.NowPlaying.Controls.tertiary)
                    
                    Rectangle()
                        .fill(Color.NowPlaying.Labels.secondary)
                        .frame(width: artworkWidth * 0.4)
                }
                .frame(height: isScrubbing ? 12 : 8)
                .clipShape(.capsule)
                .blendMode(.plusLighter)
                .allowedDynamicRange(.standard)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isScrubbing) { _, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            if scrubProgress == nil {
                                onEditingChanged(true)
                            }
                            
                            scrubProgress = (value.location.x / progressTrackWidth).clamped(to: 0...1)
                        }
                        .onEnded { value in
                            progress = (value.location.x / progressTrackWidth).clamped(to: 0...1)
                            scrubProgress = nil
                            onEditingChanged(false)
                        }
                )
                .onAppear {
                    progressTrackWidth = geo.size.width
                }
                .onChange(of: geometry.size.width) { _, newWidth in
                    progressTrackWidth = newWidth
                }
            }
            
            HStack {
                Text("0:57")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .monospacedDigit()
                
                Spacer()
                
                Text("–1:25")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .monospacedDigit()
            }
            .foregroundStyle(Color.NowPlaying.Labels.tertiary)
        }
    }
}

struct NowPlayingView: View {
    @State private var artworkWidth: CGFloat = .zero
    
    @State private var showingLyrics: Bool = false
    
    @State private var songIsFavorited: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.NowPlaying.background.ignoresSafeArea()
                
                ZStack {
                    Image(uiImage: UIImage(resource: .LE_SSERAFIM_DIFFERENT).blurred(radius: 120))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaleEffect(1.5)
                        .rotationEffect(.degrees(0))
                        .opacity(0.8)
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width)
                    
                    Rectangle()
                        .fill(Color.NowPlaying.background.opacity(0.5))
                        .blendMode(.overlay)
                        .ignoresSafeArea()
                }
                
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.NowPlaying.Controls.tertiary)
                        .blendMode(.plusLighter)
                        .allowedDynamicRange(.standard)
                        .frame(width: geometry.isLandscape ? 100 : 60, height: geometry.isLandscape ? 10 : 6)
                        .padding(.top, geometry.isLandscape ? 10 : 6)
                        .padding(.bottom, geometry.isLandscape ? 10 : 20)
                    
//                    Image(ImageResource.Bubbly.musicNoteBeamed)
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(Color.NowPlaying.Labels.tertiary)
//                        .frame(width: 128, height: 128)
//                        .frame(width: artworkWidth, height: artworkWidth)
//                        .glassEffect(.clear.interactive(), in: .rect(cornerRadius: 26))
//                        .onAppear {
//                            artworkWidth = geometry.size.width - 48
//                        }
//                        .onChange(of: geometry.size.width) { _, newWidth in
//                            artworkWidth = newWidth - 48
//                        }
                    
                    Image(ImageResource.LE_SSERAFIM_DIFFERENT)
                        .resizable()
                        .scaledToFit()
                        .frame(width: artworkWidth, height: artworkWidth)
                        .clipShape(.rect(cornerRadius: 26))
                        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 26))
                        .onAppear {
                            if geometry.isLandscape {
                                artworkWidth = geometry.size.height - 92
                            } else {
                                artworkWidth = geometry.size.width - 48
                            }
                        }
                        .onChange(of: geometry.size.width) { _, newWidth in
                            if geometry.isLandscape {
                                artworkWidth = geometry.size.height - 92
                            } else {
                                artworkWidth = newWidth - 48
                            }
                        }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text("DIFFERENT")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Image(ImageResource.Bubbly.explicitFill)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.NowPlaying.Labels.secondary)
                                    .frame(width: 20, height: 20)
                                    .blendMode(.plusLighter)
                                    .allowedDynamicRange(.standard)
                            }
                            
                            Text("LE SSERAFIM")
                                .foregroundStyle(Color.NowPlaying.Labels.secondary)
                                .blendMode(.plusLighter)
                                .allowedDynamicRange(.standard)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button {
                                songIsFavorited.toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(songIsFavorited ? Color.NowPlaying.Controls.primary : Color.NowPlaying.Controls.tertiary)
                                        .frame(width: 32, height: 32)
                                        .blendMode(.plusLighter)
                                        .allowedDynamicRange(.standard)
                                    
                                    Image(ImageResource.Bubbly.starFill)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(songIsFavorited ? Color.NowPlaying.Controls.primaryInverse : Color.NowPlaying.Labels.primary)
                                        .frame(width: 24, height: 24)
                                        .blendMode(songIsFavorited ? .plusDarker : .plusLighter)
                                        .allowedDynamicRange(.standard)
                                }
                                .animation(nil, value: songIsFavorited)
//                                .phaseAnimator(
//                                    FavoritePhase.allCases,
//                                    trigger: songIsFavorited
//                                ) { content, phase in
//                                    content
//                                        .scaleEffect(phase.scale)
//                                }
                            }
                            .buttonStyle(.bouncy)
                            
                            Menu {
                                Button(role: .destructive) {
                                    print("Delete from Library")
                                } label: {
                                    Text("Delete from Library")
                                    Image(ImageResource.Bubbly.skipAlt)
                                }
                                
                                Divider()
                                
                                Button {
                                    print("Go to Single (DIFFERENT)")
                                } label: {
                                    Text("Go to Single")
                                    Text("DIFFERENT")
                                    Image(ImageResource.Bubbly.cdSquareFill)
                                }
                                
                                Button {
                                    print("Go to Artist")
                                } label: {
                                    Text("Go to Artist")
                                    Text("LE SSERAFIM")
                                    Image(ImageResource.Bubbly.musicNoteBeamed)
                                }
                                
                                ControlGroup {
                                    Button {
                                        songIsFavorited.toggle()
                                    } label: {
                                        Text(songIsFavorited ? "Undo Favorite" : "Favorite")
                                        Image(ImageResource.Bubbly.starFill)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                    }
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.NowPlaying.Controls.tertiary)
                                        .frame(width: 32, height: 32)
                                        .blendMode(.plusLighter)
                                        .allowedDynamicRange(.standard)
                                    
                                    Image(ImageResource.Bubbly.ellipsisFill)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.NowPlaying.Labels.primary)
                                        .frame(width: 24, height: 24)
                                        .blendMode(.plusLighter)
                                        .allowedDynamicRange(.standard)
                                }
                            }
                            .buttonStyle(.bouncy)
                        }
                    }
                    .padding(.horizontal, 12)
                    
                    Spacer()
                    
                    //
                    
                    Spacer()
                    
                    Spacer()
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.NowPlaying.Controls.tertiary)
                            
                            Rectangle()
                                .fill(Color.NowPlaying.Labels.secondary)
                                .frame(width: artworkWidth * 0.8)
                        }
                        .frame(height: 8)
                        .clipShape(.capsule)
                    }
                    .blendMode(.plusLighter)
                    .allowedDynamicRange(.standard)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(Color.NowPlaying.Labels.primary)
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

//struct NowPlayingView: View {
//    @Namespace var nowPlaying
//    
//    @State private var playback = PlaybackManager.shared
//    @State private var isDraggingPlayback = false
//    @State private var isDraggingVolume = false
//    @State private var scrubTime: Double = 0.0
//    
//    @State private var artworkWidth: CGFloat = .zero
//    
//    @State private var detailsHeight: CGFloat = .zero
//    @State private var spacerHeight: CGFloat = .zero
//    
//    var topSectionHeight: CGFloat {
//        artworkWidth + spacerHeight + detailsHeight
//    }
//    
//    @State private var showingLyrics: Bool = false
//    var parsedLines: [LRCLine]? {
//        guard let lyrics = playback.currentSong?.lyrics else { return nil }
//        switch lyrics {
//        case .ttml(let raw):
//            return nil
//        case .lrc(let raw):
//            return parseLRC(raw)
//        case .raw(let raw):
//            return nil
//        }
//    }
//    
//    @State private var blurredArtworkMain: UIImage? = nil
//    @State private var blurredArtworkLyrics: UIImage? = nil
//    
//    @State private var artworkImage: UIImage? = nil
//
//    var body: some View {
//        ZStack {
//            Color.Backgrounds.primary.ignoresSafeArea()
//            
//            ZStack {
//                if let image = blurredArtworkMain {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: artworkWidth)
//                }
//                
//                if let image = blurredArtworkLyrics {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: artworkWidth)
//                        .opacity(showingLyrics ? 1 : 0)
//                }
//                
//                Rectangle()
//                    .fill(Color.Backgrounds.primary.opacity(0.3))
//                    .blendMode(.overlay)
//            }
//            .ignoresSafeArea()
//            .animation(.smooth(duration: 0.4), value: showingLyrics)
//            
////            if let data = playback.currentSong?.artworkData, let image = UIImage(data: data) {
////                Image(uiImage: image.blurred(radius: showingLyrics ? 150 : 300))
////            }
//            
//            GeometryReader { geometry in
//                VStack(spacing: 0) {
//                    Capsule()
//                        .fill(playback.currentSong != nil ? .white.opacity(0.15) : Color.Backgrounds.secondary)
//                        .blendMode(.plusLighter)
//                        .frame(width: 60, height: 6)
//                        .padding(.top, 8)
//                        .padding(.bottom, 20)
//                    
//                    HStack(spacing: 12) {
//                        Group {
//                            if let artworkImage {
//                                Image(uiImage: artworkImage)
//                                    .resizable()
//                                    .scaledToFit()
//                            } else {
//                                Rectangle()
//                                    .fill(Color.Backgrounds.secondary)
//                                    .overlay {
//                                        Image(ImageResource.Bubbly.musicNoteBeamed)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .foregroundStyle(Color.Labels.secondary.opacity(0.05))
//                                            .frame(width: showingLyrics ? 48 : 128, height: showingLyrics ? 48 : 128)
//                                    }
//                            }
//                        }
//                        .frame(width: showingLyrics ? 72 : artworkWidth, height: showingLyrics ? 72 : artworkWidth)
//                        .onAppear {
//                            artworkWidth = geometry.size.width
//                        }
//                        .onChange(of: geometry.size.width) { oldValue, newValue in                        artworkWidth = newValue
//                        }
//                        .clipShape(.rect(cornerRadius: showingLyrics ? 10 : 26))
//                        .glassEffect(.clear, in: .rect(cornerRadius: showingLyrics ? 10 : 26))
//                        .opacity(playback.isPlaying ? 1 : 0.5)
//                        .scaleEffect(playback.isPlaying ? 1 : showingLyrics ? 0.8 : 0.6)
//                        .animation(.spring(duration: 0.6, bounce: 0.4), value: playback.isPlaying)
//                        .onChange(of: playback.currentSong?.artworkData) { _, newData in
//                            guard let data = newData else { artworkImage = nil; return }
//                            artworkImage = UIImage(data: data)
//                        }
//                        .onAppear {
//                            guard let data = playback.currentSong?.artworkData else { return }
//                            artworkImage = UIImage(data: data)
//                        }
//                        
//                        if showingLyrics {
//                            HStack(spacing: 4) {
//                                VStack(alignment: .leading, spacing: 0) {
//                                    HStack(spacing: 4) {
//                                        Text(playback.currentSong?.title ?? "Not Playing")
//                                        
//                                        if playback.currentSong?.isExplicit == true {
//                                            Image(ImageResource.Bubbly.explicitFill)
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 16, height: 16)
//                                                .opacity(0.5)
//                                        }
//                                    }
//                                    .fontWeight(.bold)
//                                    
//                                    Text(playback.currentSong?.artists.joined(separator: "; ") ?? "On this device")
//                                        .foregroundStyle(.white.opacity(0.5))
//                                }
//                                .lineLimit(1)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .blendMode(.plusLighter)
//                                
//                                Button {
//                                    withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
//                                        playback.isFavorited.toggle()
//                                    }
//                                } label: {
//                                    Image(systemName: playback.isFavorited ? "heart.circle.fill" : "heart.fill")
//                                        .font(.title)
//                                        .foregroundStyle(playback.isFavorited ? .pink : Color.Labels.secondary.opacity(0.5))
//                                    //                                .symbolEffect(.bounce, value: playback.isFavorited)
//                                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
//                                }
//                                .buttonStyle(.plain)
//                            }
//                            .matchedGeometryEffect(id: "songDetails", in: nowPlaying)
////                            .transition(.scale(scale: 1))
//                        }
//                    }
//                    
//                    if showingLyrics {
//                        VStack(alignment: .leading, spacing: 36) {
//                            if let songTitle = playback.currentSong?.title {
//                                let title = Text(songTitle).foregroundStyle(.white.opacity(0.5))
//                                
//                                Text("\(title) has no lyrics.")
//                                    .foregroundStyle(.white.opacity(0.25))
//                            } else {
//                                Text("Nothing’s playing right now.")
//                                    .foregroundStyle(.white.opacity(0.25))
//                            }
//                        }
//                        .frame(height: topSectionHeight - 72)
//                        .blendMode(.plusLighter)
//                    }
//                    
//                    if !showingLyrics {
//                        Spacer()
//                        
//                        HStack(spacing: 4) {
//                            VStack(alignment: .leading, spacing: 0) {
//                                HStack(spacing: 4) {
//                                    Text(playback.currentSong?.title ?? "Not Playing")
//                                    
//                                    if playback.currentSong?.isExplicit == true {
//                                        Image(ImageResource.Bubbly.explicitFill)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 16, height: 16)
//                                            .opacity(0.5)
//                                    }
//                                }
//                                .fontWeight(.bold)
//                                
//                                Text(playback.currentSong?.artists.joined(separator: "; ") ?? "On this device")
//                                    .foregroundStyle(.white.opacity(0.5))
//                            }
//                            .lineLimit(1)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .blendMode(.plusLighter)
//                            
//                            Button {
//                                withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
//                                    playback.isFavorited.toggle()
//                                }
//                            } label: {
//                                Image(systemName: playback.isFavorited ? "heart.circle.fill" : "heart.fill")
//                                    .font(.title)
//                                    .foregroundStyle(playback.isFavorited ? .pink : Color.Labels.secondary.opacity(0.5))
//                                //                                .symbolEffect(.bounce, value: playback.isFavorited)
//                                    .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
//                            }
//                            .buttonStyle(.plain)
//                        }
//                        .padding(.horizontal, 12)
//                        .matchedGeometryEffect(id: "songDetails", in: nowPlaying)
////                        .transition(.scale(scale: 1))
//                        .background(GeometryReader { geo in
//                            Color.clear
//                                .onAppear { detailsHeight = geo.size.height }
//                                .onChange(of: geo.size.height) { _, new in detailsHeight = new }
//                        })
//                    }
//                    
//                    Spacer()
//                        .background(GeometryReader { geo in
//                            Color.clear
//                                .onAppear { spacerHeight = geo.size.height }
//                                .onChange(of: geo.size.height) { _, new in spacerHeight = new }
//                        })
//                    
//                    VStack(spacing: 4) {
//                        Slider(
//                            value: isDraggingPlayback ? $scrubTime : .init(
//                                get: { playback.currentTime },
//                                set: { playback.seek(to: $0) }
//                            ),
//                            in: 0...(playback.duration > 0 ? playback.duration : 1)
//                        ) { editing in
//                            isDraggingPlayback = editing
//                            if !editing {
//                                playback.seek(to: scrubTime)
//                            }
//                        }
//                        .tint(.primary)
//                        
//                        HStack {
//                            Text(formatTime(isDraggingPlayback ? scrubTime : playback.currentTime))
//                            
//                            Spacer()
//                            
//                            Text(formatTime(playback.duration))
//                        }
//                        .font(.caption)
//                        .foregroundStyle(Color.Labels.secondary)
//                        .monospacedDigit()
//                    }
//                    
//                    Spacer()
//                    
//                    HStack(spacing: 32) {
//                        Button {
////                            if playback.curentTime > 3 {
//                            withAnimation(.smooth(duration: 0.2)) {
//                                playback.seek(to: 0)
//                            }
////                            } else {
////                                print("Previous in queue")
////                            }
//                        } label: {
//                            Group {
//                                Image(ImageResource.Bubbly.previousAlt)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 48, height: 48)
//                            }
//                            .frame(width: 72, height: 72)
//                            .contentShape(.circle)
//                        }
//                        .buttonStyle(.plain)
//                        
//                        Button {
//                            playback.playPause()
//                        } label: {
//                            Group {
//                                Image(playback.isPlaying ? ImageResource.Bubbly.pause : ImageResource.Bubbly.play)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 64, height: 64)
//                            }
//                            .frame(width: 72, height: 72)
//                            .contentShape(.circle)
//                        }
//                        .buttonStyle(.plain)
//                        
//                        Button {
//                            print("Next in queue")
//                        } label: {
//                            Group {
//                                Image(ImageResource.Bubbly.skipAlt)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 48, height: 48)
//                            }
//                            .frame(width: 72, height: 72)
//                            .contentShape(.circle)
//                        }
//                        .buttonStyle(.plain)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(spacing: 8) {
//                        Slider(value: $playback.volume, in: 0...1) { _ in }
//                            .tint(.primary)
//                            .onChange(of: playback.volume) { _, newValue in
//                                AVAudioSession.sharedInstance().outputVolume
//                                
//                                playback.player?.volume = newValue
//                            }
//                        
//                        HStack {
//                            Image(systemName: "speaker.fill")
//                            Spacer()
//                            Image(systemName: "speaker.wave.3.fill")
//                        }
//                        .font(.caption)
//                        .foregroundStyle(Color.Labels.secondary)
//                    }
//                    
//                    Spacer()
//                    
//                    Button {
//                        withAnimation(.spring(duration: 0.4, bounce: 0.2)) {
//                            showingLyrics.toggle()
//                        }
//                    } label: {
//                        Group {
//                            Image(ImageResource.Bubbly.quoteBubbleFill)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 28, height: 28)
//                                .foregroundStyle(showingLyrics ? .black.opacity(0.4) : .white.opacity(0.4))
//                                .blendMode(showingLyrics ? .plusDarker : .plusLighter)
//                        }
//                        .frame(width: 40, height: 40)
//                        .background(showingLyrics ? .white.opacity(0.4) : .clear)
//                        .blendMode(.plusLighter)
//                        .clipShape(.circle)
//                        .contentShape(.circle)
//                    }
//                }
//                
////                if showingLyrics, let lines = parsedLines {
////                    LyricsView(showingLyrics: $showingLyrics, lines: lines)
////                        .background(.ultraThinMaterial)
////                        .clipShape(.rect(cornerRadius: 28))
////                        .transition(.move(edge: .bottom).combined(with: .opacity))
////                }
//            }
//            .padding(.horizontal, 24)
//            // BACKGROUND BLUR
//            .onChange(of: playback.currentSong?.artworkData) { _, newData in
//                guard let data = newData, let image = UIImage(data: data) else {
//                    blurredArtworkMain = nil
//                    blurredArtworkLyrics = nil
//                    return
//                }
//                Task.detached(priority: .userInitiated) {
//                    let blurredMain = await image.blurred(radius: 300)
//                    let blurredLyrics = await image.blurred(radius: 150)
//                    
//                    await MainActor.run {
//                        withAnimation(.smooth(duration: 0.1)) {
//                            blurredArtworkMain = blurredMain
//                            blurredArtworkLyrics = blurredLyrics
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                guard let data = playback.currentSong?.artworkData, let image = UIImage(data: data) else { return }
//                Task.detached(priority: .userInitiated) {
//                    let blurredMain = await image.blurred(radius: 300)
//                    let blurredLyrics = await image.blurred(radius: 150)
//                    
//                    await MainActor.run {
//                        withAnimation(.smooth(duration: 0.1)) {
//                            blurredArtworkMain = blurredMain
//                            blurredArtworkLyrics = blurredLyrics
//                        }
//                    }
//                }
//            }
//        }
//        .fontWeight(.medium)
//        .fontDesign(.rounded)
//        .foregroundStyle(.white)
//        .preferredColorScheme(.dark)
//    }
//    
//    func formatTime(_ seconds: Double) -> String {
//        guard seconds.isFinite else { return "0:00" }
//        let s = Int(seconds)
//        return "\(s / 60):\(String(format: "%02d", s % 60))"
//    }
//}

//struct NowPlayingArtworkView: View {
//    let artworkData: Data?
//    let width: CGFloat
//    let isPlaying: Bool
//    
//    var body: some View {
//        //
//    }
//}
//
//struct nowPlayingBackgroundView: View {
//    let artworkData: Data?
//    
//    var body: some View {
//        //
//    }
//}

struct LyricsView: View {
    @Binding var showingLyrics: Bool
    
    let lines: [LRCLine]
    @State private var playback = PlaybackManager.shared
    
    @State private var currentLineIndex: Int? = nil
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // top padding
                        Color.clear
                            .frame(height: 72)
                        
                        ForEach(Array(lines.enumerated()), id: \.element.id) { index, line in
                            Text(line.lyric)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .opacity(index == currentLineIndex ? 1 : 0.5)
                                .scaleEffect(index == currentLineIndex ? 1 : 0.96, anchor: .leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .id(index)
                                .contentShape(.rect)
                                .onTapGesture {
                                    playback.seek(to: line.timestamp)
                                }
                                .animation(.spring(duration: 0.4, bounce: 0.2), value: index == currentLineIndex)
                        }
                        
                        // bottom padding
                        Color.clear
                            .frame(height: 72)
                    }
                }
                .onChange(of: playback.currentTime, { _, _ in
                    let newIndex = lines.indices.last { lines[$0].timestamp <= playback.currentTime }
                    if newIndex != currentLineIndex {
                        currentLineIndex = newIndex
                    }
                })
                .onChange(of: currentLineIndex) { _, newIndex in
                    guard let newIndex else { return }
                    withAnimation(.spring(duration: 0.4, bounce: 0.2)) {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingLyrics = false
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
            .fontDesign(.rounded)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    NowPlayingView()
}
