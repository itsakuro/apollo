//
//  AddSongView.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI

struct AddSongView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Backgrounds.primary.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.fill.tertiary)
                                .frame(width: 200, height: 200)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .imageScale(.large)
                                        .foregroundStyle(.background)
                                }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Discard changes", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add song")
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Save changes", systemImage: "checkmark")
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddSongView()
}
