//
//  CustomErrorBanner.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/11/25.
//

import SwiftUI

struct CustomErrorBanner: View {
    
    let message: String
    var onDismiss: (() -> Void)? = nil
    @State private var isVisible = true
    
    var body: some View {
        
        if isVisible {
            
            VStack(spacing: 16) {
                Text(message)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Button("OK") {
                    withAnimation {
                        isVisible = false
                        onDismiss?()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
            .transition(.move(edge: .top).combined(with: .opacity))
            .zIndex(1)
        }
    }
}

#Preview {
    CustomErrorBanner(message: "")
}
