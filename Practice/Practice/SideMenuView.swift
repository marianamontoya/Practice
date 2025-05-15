//
//  LSideMenuView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/10/25.
//

import SwiftUI

enum Side {
    case left, right
}

struct SideMenuView: View {
    var side: Side
    
    @Binding var isShowing: Bool
    @Binding var imageOffset: CGSize
    @Binding var isImageInContentView: Bool
    
    @State private var dragStartPosition: CGSize = .zero
    
//    var images:[String] // or [UIImage]
//    
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
                    if side == .left {
                        VStack(alignment: .leading, spacing: 32) {
                            SideMenuHeaderView()
                            Spacer()
                        }
                        .padding()
                        .frame(width: 190, alignment: .leading)
                        .background(Color.white)
                        
                        Spacer()
                    } else {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 32) {
                            SideMenuHeaderView()
                            Spacer()
                        }
                        .padding()
                        .frame(width: 190, alignment: .trailing)
                        .background(Color.white)
                    }
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
        .transition(.move(edge: side == .left ? .leading : .trailing))
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
        SideMenuViewPreviewWrapper()
}

struct SideMenuViewPreviewWrapper: View {
        @State private var isShowing = true
        @State private var imageOffset: CGSize = .zero
        @State private var isImageInContentView = false

        var body: some View {
            SideMenuView(
                side: .left,
                isShowing: $isShowing,
                imageOffset: $imageOffset,
                isImageInContentView: $isImageInContentView
            )
        }
    }
