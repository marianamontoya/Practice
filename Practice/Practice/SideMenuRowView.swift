//
//  LSideMenuRowView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/12/25.
//

import SwiftUI

struct SideMenuRowView: View {
    var body: some View {
        HStack {
            Image(systemName: "paperplane")
                .imageScale(.large)
            
            Text("Messages")
                .font(.subheadline)
            
            Spacer()
        }
        .padding(.leading)
        .frame(height: 44)
    }
}

#Preview {
    SideMenuRowView()
}
