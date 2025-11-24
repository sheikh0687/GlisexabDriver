//
//  SideMenu.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var isShow: Bool
//    @State private var selectedOption: SideMenuRowOption?
    var onOptionSelection: (SideMenuRowOption) -> Void
    
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
                    VStack(spacing: 30) {
                        SideMenuHeader()

                        VStack(spacing: 10) {
                            ForEach(SideMenuRowOption.allCases) { option in
                                Button {
                                    isShow = false
                                    onOptionSelection(option)
                                } label: {
                                    SideMenuRow(optionModel: option)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding( )
                    .frame(width: 270)
                    .background(Color.colorNeavyBlue)
                    .multilineTextAlignment(.center)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShow)
    }
}

#Preview {
    SideMenu(isShow: .constant(true), onOptionSelection: { option in
        print("Selected: \(option)")
        })
    }
