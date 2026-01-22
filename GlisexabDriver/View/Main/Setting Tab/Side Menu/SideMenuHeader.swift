//
//  SideMenuHeader.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct SideMenuHeader: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            if let uiImage = viewModel.selectedUIImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            }

            Text("\(viewModel.firstName) \(viewModel.lastName)")
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
        .onAppear {
           Task {
               await viewModel.fetchUserProfile(appState: appState)
            }
        }
    }
}

#Preview {
    SideMenuHeader()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
