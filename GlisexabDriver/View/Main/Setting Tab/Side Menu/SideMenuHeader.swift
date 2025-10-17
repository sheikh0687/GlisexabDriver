//
//  SideMenuHeader.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenuHeader: View {
    
    var body: some View {
        HStack {
            Image("userPlace")
                .resizable()
                .frame(width: 80, height: 80)

            VStack(alignment: .center, spacing: 08) {
                Text("Loress Andreew")
                    .font(.customfont(.semiBold, fontSize: 16))
                    .foregroundColor(.white)
                
                Text("Technical Driver")
                    .font(.customfont(.semiBold, fontSize: 16))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    SideMenuHeader()
}
