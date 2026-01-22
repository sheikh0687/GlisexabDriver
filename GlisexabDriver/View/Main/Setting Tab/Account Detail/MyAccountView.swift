//
//  MyAccountView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 27/10/25.
//

import SwiftUI

struct MyAccountView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
         ZStack {
            VStack(alignment: .leading, spacing: 20) {
                 VStack(alignment: .leading, spacing: 20) {
                    
                     HStack(alignment: .top, spacing: 16) {
                         if let uiImage = viewModel.selectedUIImage {
                             Image(uiImage: uiImage)
                                 .resizable()
                                 .scaledToFill()
                                 .frame(width: 60, height: 60)
                                 .clipShape(Circle())
                         } else {
                             Image("user")
                                 .resizable()
                                 .scaledToFit()
                                 .frame(width: 60, height: 60)
                                 .clipShape(Circle())
                         }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(viewModel.firstName) \(viewModel.lastName)")
                                .font(.customfont(.semiBold, fontSize: 18))
                            
                            Text(viewModel.email)
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.gray)
                            
                            Text(viewModel.contactNumber)
                                .font(.customfont(.semiBold, fontSize: 18))
                                .padding(.top)
                        }
                        Spacer()
                        Button {
                            router.push(to: .editProfile)
                        } label: {
                            Image("Edit")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    
                    HStack {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Add Information")
                            .font(.customfont(.medium, fontSize: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .onTapGesture {
                        router.push(to: .uploadDocument)
                    }
                    
                    HStack {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Text("Update Bank Detail")
                            .font(.customfont(.medium, fontSize: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .onTapGesture {
                        router.push(to: .bankDetail)
                    }
                    
                    Button {
                        print("Call Api")
                    } label: {
                        Text("Delete Account")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 45)
                    }
                    .background(Color.red)
                    .shadow(radius: 1)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    Spacer()
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
           Task {
               await viewModel.fetchUserProfile(appState: appState)
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
                .font(.customfont(.medium, fontSize: 13))
            Spacer()
            Text(value)
                .font(.customfont(.semiBold, fontSize: 14))
        }
    }
}

struct DocumentRow: View {
    let icon: String
    let label: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .frame(width: 32, height: 32)
                .background(Color(.systemGray5))
                .cornerRadius(6)
            Text(label)
                .font(.customfont(.medium, fontSize: 14))
            Spacer()
        }
    }
}

#Preview {
    MyAccountView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
