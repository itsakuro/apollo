//
//  EditAlbumArtView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/18/26.
//

import SwiftUI

struct EditAlbumArtView: View {
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.fill.tertiary)
                .overlay {
                    Image(systemName: "music.note")
                        .font(.system(size: 60))
                        .imageScale(.large)
                        .foregroundStyle(.background)
                }
        }
        .frame(width: 260, height: 260)
        .clipShape(.rect(cornerRadius: 26))
        .matchedGeometryEffect(id: "albumArt", in: namespace)
    }
}
