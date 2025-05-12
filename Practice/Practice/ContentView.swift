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
    
    
   let name = "Mariana Montoya"
    
    var body: some View {
        Text(name)
            .draggable(name) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 300)
                        .foregroundStyle(.yellow.gradient)
                    Text("Drop \(name)")
                        .font(.title)
                        .foregroundStyle(.red)
                }
            }
        
        NavigationStack {
            ZStack {
                            
                VStack {
                    LSideMenuView(isShowing: $showMenu)
                }
                .toolbar(showMenu ? .hidden: .visible, for: .navigationBar)
                .navigationTitle("Home")
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
}


#Preview {
    ContentView()
}
