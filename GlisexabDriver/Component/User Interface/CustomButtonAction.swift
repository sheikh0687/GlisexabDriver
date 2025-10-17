//
//  CustomButtonAction.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI

struct CustomButtonAction: View {
    var title: String
    var color: Color
    var titleColor: Color = .white // ✅ New property with default value
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.customfont(.semiBold, fontSize: 14))
                .foregroundColor(titleColor) // ✅ Use dynamic color
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(color)
                .cornerRadius(18)
        }
    }
}

#Preview {
    CustomButtonAction(
        title: "Accept",
        color: .green,
        titleColor: .white
    ) {
        print("Button tapped")
    }
}
