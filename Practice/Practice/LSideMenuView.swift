//
//  LSideMenuView.swift
//  Practice
//
//  Created by Mariana Montoya on 5/10/25.
//

import SwiftUI

struct LSideMenuView: View {
    @Binding var isShowing: Bool
    
    
    var body: some View {
        ZStack {
            if isShowing {
                // In order to gray out the back. Not necessary needed
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
                            ForEach(0 ..< 5) {option in
                                LSideMenuRowView()
                            }
                        }
                        Spacer()

                    }
                    .padding()
                    .frame(width:270, alignment: .leading)
                    .background(.white)
                    Spacer()
                }

            }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    LSideMenuView(isShowing: .constant(true))
}
