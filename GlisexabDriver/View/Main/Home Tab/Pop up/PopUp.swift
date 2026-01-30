//
//  PopUp.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI

struct PopUp: View {
    
    @Binding var isShowing: Bool
    let totalAmount: String
    var cloIsPaymentComplete: ((Bool) -> Void)?
    var popFor: String
    
    var body: some View {
        ZStack {
            Spacer()
             VStack(spacing: 12) {
                Text(popFor == "Payment" ? "Payment Confirmation" : "Help")
                    .font(.customfont(.semiBold, fontSize: 14))
                
                Text(popFor == "Payment" ? "Have you received the amount of: $\(totalAmount)?" : "If you want any support from admin then you can write him.")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                HStack {
                    CustomButtonAction(title: "Yes", color: .colorNeavyBlue, titleColor: .white) {
                        self.cloIsPaymentComplete?(true)
                    }
                    
                    CustomButtonAction(title: "No", color: Color(.systemGray6), titleColor: .black) {
                        print("See Earninh")
                        self.cloIsPaymentComplete?(false)
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
        }
    }
}

#Preview {
    PopUp(isShowing: .constant(false), totalAmount: "80", popFor: "Admin")
}
