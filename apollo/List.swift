//
//  List.swift
//  apollo
//
//  Created by Jason Yamoah on 4/20/26.
//

import SwiftUI

struct ListRow<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    } 

    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 4) {
                content
                    .frame(height: 54)
                    .background(.fill.quaternary)
            }
        }
    }
}

struct ListHeader: View {
    let header: Text

    init(_ header: Text) {
        self.header = header
    }

    var body: some View {
        header
            .font(.subheadline)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Label.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct ListFooter: View {
    let footer: Text

    init(_ footer: Text) {
        self.footer = footer
    }

    var body: someView {
        footer
            .font(.footnote)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(Color.Label.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct ListSection<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
    }
}

struct ListGroup<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 1) {
            content
                .clipShape(.rect(cornerRadius: 26))
        }
    }
}