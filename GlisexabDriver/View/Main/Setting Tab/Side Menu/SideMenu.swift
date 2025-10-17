//
//  SideMenu.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            if isShow {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShow.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 30) {
                        SideMenuHeader()
                        
                        VStack {
                            ForEach(0..<5) { option in
                                SideMenuRow()
                            }
                        }
                        Spacer()
                    }
                    .padding( )
                    .frame(width: 270, alignment: .leading)
                    .background(Color.colorNeavyBlue)
                    Spacer()
                }
            }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut, value: isShow)
    }
}

#Preview {
    SideMenu(isShow: .constant(true))
}
