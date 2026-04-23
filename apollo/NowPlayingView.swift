//
//  NowPlayingView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI

struct NowPlayingView: View {
    @State private var artworkWidth: CGFloat = .zero

    var body: some View {
        ZStack {
            Color.Backgrounds.primary.ignoresSafeArea()
            
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.fill.tertiary)
                    .onGeometryChange(
                        for: CGFloat.self,
                        of: { geometry in
                            geometry.size.width
                        }
                    ) { width in
                        artworkWidth = width
                    }
                    .frame(width: artworkWidth, height: artworkWidth)
                    .overlay {
                        Image(ImageResource.Bubbly.musicNoteBeamed)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.Backgrounds.secondary)
                            .frame(width: 96, height: 96)
                    }
                  
                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    Text("Title")
                        .fontWeight(.bold)
                }
            }
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Labels.primary)
        }
    }
}