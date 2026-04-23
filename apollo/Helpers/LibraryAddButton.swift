//
//  LibraryAddButton.swift
//  apollo
//
//  Created by Jason Yamoah on 4/23/26.
//

import SwiftUI

struct LibraryAddButton<Label: View, Content: View, ExpandedContent: View>: View {
    @Binding var showingExpandedContent: Bool
    
    @ViewBuilder var label: Label
    @ViewBuilder var content: Content
    @ViewBuilder var expandedContent: ExpandedContent
    
    // View properties
    @State private var showingFullScreenCover: Bool = false
    @State private var animateContent: Bool = false
    @State private var viewPosition: CGRect = .zero
    
    var body: some View {
        label
            .glassEffect(.regular.tint(.accentColor).interactive(), in: .circle)
            .contentShape(.circle)
            .onGeometryChange(for: CGRect.self, of: {
                $0.frame(in: .global)
            }, action: { newValue in
                viewPosition = newValue
            })
            .opacity(showingFullScreenCover ? 0 : 1)
            .onTapGesture {
                toggleFullScreenCover(false, status: true)
            }
            .fullScreenCover(isPresented: $showingFullScreenCover) {
                ZStack(alignment: .topLeading) {
                    if animateContent {
                        ZStack(alignment: .top) {
                            if showingExpandedContent {
                                expandedContent
                            } else {
                                content
                                    .transition(.blurReplace)
                            }
                        }
                        .transition(.blurReplace)
                    } else {
                        label
                            .transition(.blurReplace)
                    }
                }
                .geometryGroup()
                .clipShape(.rect(cornerRadius: 34))
                .background {
                    RoundedRectangle(cornerRadius: 34)
                        .fill(Color.Lists.foreground)
                        .ignoresSafeArea()
                }
                .padding(.horizontal, animateContent && !showingExpandedContent ? 28 : 0)
                .padding(.bottom, 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: animateContent ? .bottom : .topLeading)
                .offset (
                    x: animateContent ? 0 : viewPosition.minX,
                    y: animateContent ? 0 : viewPosition.minY
                )
                .ignoresSafeArea(animateContent ? [] : .all)
                .background {
                    Rectangle()
                        .fill(.black.opacity(animateContent ? 0.05 : 0))
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.interpolatingSpring(duration: 0.2, bounce: 0), completionCriteria: .removed) {
                                animateContent = false
                            } completion: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    toggleFullScreenCover(false, status: false)
                                }
                            }
                        }
                }
                .task {
                    try? await Task.sleep(for: .seconds(0.05))
                    
                    withAnimation(.interpolatingSpring(duration: 0.2, bounce: 0)) {
                        animateContent = true
                    }
                }
                .animation(.interpolatingSpring(duration: 0.2, bounce: 0), value: showingExpandedContent)
            }
    }
    
    private func toggleFullScreenCover(_ withAnimation: Bool, status: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = !withAnimation
        
        withTransaction(transaction) {
            showingFullScreenCover = status
        }
    }
}

#Preview {
    LibraryTabView()
}
