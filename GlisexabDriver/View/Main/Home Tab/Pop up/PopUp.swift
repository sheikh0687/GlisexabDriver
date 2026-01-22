//
//  PopUp.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI

struct PopUp: View {
    
    @Binding var isShowing: Bool
    @State var isPresent: Bool = false
    
    var body: some View {
        ZStack {
            Spacer()
            VStack(spacing: 12) {

                Text("Payment Confirmation")
                    .font(.customfont(.semiBold, fontSize: 14))
                
                Text("Have you received the amount of: $180.00?")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                HStack {
                    CustomButtonAction(title: "Yes", color: .colorNeavyBlue, titleColor: .white) {
                        self.isPresent = true
                    }
                    
                    CustomButtonAction(title: "No", color: Color(.systemGray6), titleColor: .black) {
                        print("See Earninh")
                    }
                }
                .padding(.horizontal)
            } // MAIN VSTACK
            .padding(16)
            .background (
                RoundedRectangle(cornerRadius: 11)
                .stroke(Color.gray, lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.white)))
            )
            .padding(.horizontal, 24)
            
            Spacer()
            
            if isPresent {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isPresent = false }
                    }
                PopUp(isShowing: $isPresent)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    PopUp(isShowing: .constant(false))
}
