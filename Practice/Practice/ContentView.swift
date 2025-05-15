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
    
    //For removing Images:
//    @State private var images: [UIImage] = [...] // your image data
    @State private var removedImages: [UIImage] = []

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                // Background
                Color.white.ignoresSafeArea()
                

                // Draggable image
                if isImageVisible {
                    Image("minion")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    //Places the image where the user drags it
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
                                } //Tracks where the user leaves the image
                        )
                    // Allows it to be draggable to different items such as trashcan
                        .onDrag {
                            return NSItemProvider(object: UIImage(named: "minion") ?? UIImage())
                        }
                }

                // Side menu (toggle with button)
                SideMenuView(
                        isShowing: $showMenu,
                        imageOffset: $imageOffset,
                        isImageInContentView: $isImageVisible
                    )
                TrashCanView {
                    isImageVisible = false
                    imageOffset = .zero
                }
                .padding(.trailing, 10)
            }
            //Hides the toolbar when its clicked
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
