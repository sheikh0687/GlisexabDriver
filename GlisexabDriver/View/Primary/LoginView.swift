//
//  LoginView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/10/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: NavigationRouter
    
    @State private var txtContactNumber: String = ""
    @State private var txtPassword: String = ""
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Continue to Sign in")
                        .font(.customfont(.medium, fontSize: 18))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contact Number")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                Image("Contact")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                TextField("Enter Contact Number", text: $txtContactNumber)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                        }
                        
                        Text("Password")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                Image("Password")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                SecureField("Enter Password", text: $txtPassword)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                                
                                Spacer()
                                
                                Image("Unlock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 12)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        Button("Forget Password?") {
//                            router.push(to: .forgetPassword)
                        }
                        .font(.customfont(.semiBold, fontSize: 14))
                        .foregroundColor(.colorNeavyBlue)
                        .padding(.trailing, 24)
                    }
                    .padding(.top, 15)
                    
                    Button {
                        router.push(to: .home)
                    } label: {
                        Text("Signin")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Don’t have an Account?")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.gray)
                        Button("Sign up") {
                            router.push(to: .signup)
                        }
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.colorNeavyBlue)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }// VSTACK
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color.white)
                .navigationBarBackButtonHidden(true)
                
            }//SCROOLVIEW
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        router.popView()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    CustomLogo()
                        .frame(width: 100, height: 120)
                }
                
            }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
}

#Preview {
    LoginView()
}
