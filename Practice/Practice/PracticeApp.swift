//
//  PracticeApp.swift
//  Practice
//
//  Created by Mariana Montoya on 5/9/25.
//

import SwiftUI

@main
struct PracticeApp: App {
    @State private var imageOffset: CGSize = .zero
    @State private var isImageVisible: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView(
                imageOffset: $imageOffset,
                isImageVisible: $isImageVisible
            )
        }
    }
}

