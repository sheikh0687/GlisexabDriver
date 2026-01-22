//
//  SimpleToastView.swift
//  Glisexab
//
//  Created by Arbaz  on 15/01/26.
//

import SwiftUI

struct SimpleToastView: View {
    
    let message: String
    let isPresented: Bool

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.customfont(.regular, fontSize: 14))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
                .opacity(isPresented ? 1 : 0)
                .offset(y: isPresented ? 0 : 50)
                .animation(.easeInOut(duration: 0.3), value: isPresented)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SimpleToastView(message: "Hello,", isPresented: true)
}
