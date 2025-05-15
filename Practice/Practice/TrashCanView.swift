//
//  TrashCanView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/15/25.
//

import SwiftUI

struct TrashCanView: View {
    var onDropAction: () -> Void
    @State private var isHovering: Bool = false
    
    var body: some View {
        Image(systemName: "trash.fill")
            .font(.largeTitle)
            .padding()
            .onDrop(of: ["public.image"], isTargeted: nil) { _ in
                onDropAction()
                return true
            }
            .animation(.easeInOut(duration: 0.2), value: isHovering)
    }
}

#Preview {
    TrashCanView {
        print("Image dropped in preview!")
    }
}
