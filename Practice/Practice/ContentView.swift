//
//  ContentView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var presentSideMenuL: Bool = false
    @State private var presentSideMenuR: Bool = false
    @State private var showMenu = false

    @Binding var imageOffset: CGSize
    @Binding var isImageVisible: Bool
    
    @State private var dragStartPosition: CGSize = .zero

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.white.ignoresSafeArea()
                

                // Draggable image
                if isImageVisible {
                    Image("minion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                        .offset(imageOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    imageOffset = CGSize(
                                        width: value.translation.width + dragStartPosition.width,
                                        height: value.translation.height + dragStartPosition.height
                                    )
                                }
                                .onEnded { _ in
                                    dragStartPosition = imageOffset
                                }
                        )
                        .animation(.easeInOut, value: imageOffset)
                }

                // Side menu (toggle with button)
                if showMenu {
                    LSideMenuView(
                        isShowing: $showMenu,
                        imageOffset: $imageOffset,
                        isImageInContentView: $isImageVisible
                    )
                }
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Jack's Stacks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                    })
                }
            }
        }
    }
}


#Preview {
    ContentViewPreviewWrapper()
}

struct ContentViewPreviewWrapper: View {
    @State private var offset: CGSize = .zero
    @State private var visible: Bool = false

    var body: some View {
        ContentView(imageOffset: $offset, isImageVisible: $visible)
    }
}
