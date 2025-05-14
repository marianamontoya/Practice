//
//  LSideMenuView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/10/25.
//

import SwiftUI

struct LSideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var imageOffset: CGSize
    @Binding var isImageInContentView: Bool
    
    @State private var dragStartPosition: CGSize = .zero
    
    var body: some View {
        ZStack {
            if isShowing {
                // Gray-out background
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        LSideMenuHeaderView()
                        
                        VStack {
                            ForEach(0..<5) { _ in
                                LSideMenuRowView()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(Color.white)
                    
                    Spacer()
                }
                
                // Only show star in the menu if it's not in the content view
                if !isImageInContentView {
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
                                    
                                    // If dragged past menu width, move to content view
                                    if imageOffset.width > 150 {
                                        isImageInContentView = true
                                        isShowing = false
                                    }
                                }
                        )
                        .animation(.easeInOut, value: imageOffset)
                }
            }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
        LSideMenuViewPreviewWrapper()
}

struct LSideMenuViewPreviewWrapper: View {
        @State private var isShowing = true
        @State private var imageOffset: CGSize = .zero
        @State private var isImageInContentView = false

        var body: some View {
            LSideMenuView(
                isShowing: $isShowing,
                imageOffset: $imageOffset,
                isImageInContentView: $isImageInContentView
            )
        }
    }
