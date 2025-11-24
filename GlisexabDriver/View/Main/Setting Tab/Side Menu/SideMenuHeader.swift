//
//  SideMenuHeader.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenuHeader: View {
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 8) {
            Image("userPlace")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text("Jerome Bell")
                .font(.customfont(.semiBold, fontSize: 16))
                .foregroundColor(.white)
            
            Button {
                router.push(to: .editProfile)
            } label: {
                Text("View Profile")
                    .font(.customfont(.semiBold, fontSize: 14))
                    .foregroundColor(.white)
                    .underline()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    SideMenuHeader()
}
