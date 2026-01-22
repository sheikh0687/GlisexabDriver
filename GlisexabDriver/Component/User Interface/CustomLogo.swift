//
//  CustomLogo.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct CustomLogo: View {
    var body: some View {
        Image("customLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .background(.clear)
    }
}

#Preview {
    CustomLogo()
}
