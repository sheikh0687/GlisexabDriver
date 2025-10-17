//
//  SideMenuRow.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenuRow: View {
    var body: some View {
        HStack {
            Image(systemName: "paperplane")
                .imageScale(.medium)
            
            Text("Message")
                .font(.customfont(.semiBold, fontSize: 16))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.leading)
        .frame(height: 44)
        
    }
}

#Preview {
    SideMenuRow()
}
