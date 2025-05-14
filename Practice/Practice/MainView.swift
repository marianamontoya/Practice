//
//  MainView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/14/25.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingMenu = true
    @State private var imageOffset: CGSize = .zero
    @State private var isImageInContentView = false
    
    
    var body: some View {
        ZStack {
            
            ContentView(imageOffset: $imageOffset, isImageVisible: $isImageInContentView)
            
            if isShowingMenu {
                LSideMenuView(
                    isShowing: $isShowingMenu,
                    imageOffset: $imageOffset,
                    isImageInContentView: $isImageInContentView
                )
            }
        }
        
    }
}

#Preview {
    MainView()
}
