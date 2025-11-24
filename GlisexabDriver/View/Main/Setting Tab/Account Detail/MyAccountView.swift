//
//  MyAccountView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 27/10/25.
//

import SwiftUI

struct MyAccountView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    
                     HStack(alignment: .top, spacing: 16) {
                        Image("userPlace")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Jerome Bell")
                                .font(.customfont(.semiBold, fontSize: 18))
                            
                            Text("jeromebellgmail.com")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.gray)
                            
                            Text("098827****56")
                                .font(.customfont(.semiBold, fontSize: 18))
                                .padding(.top)
                            
                            Text("3517 W. Pennsylvania 57867")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button {
                            print("Edit Profile")
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
                    
                    // Driver Details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Vehicle Information")
                             .font(.customfont(.semiBold, fontSize: 16))
                        VStack(alignment: .leading, spacing: 10) {
                            InfoRow(label: "Vehicle Type & Model :", value: "Sedan(2024)")
                            InfoRow(label: "Vehicle Number :", value: "MP7379")
                            InfoRow(label: "Vehicle Color :", value: "White")
                            InfoRow(label: "Registration Expiration Date :", value: "12/7/26")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Documents")
                             .font(.customfont(.semiBold, fontSize: 16))
                        VStack(alignment: .leading, spacing: 10) {
                            DocumentRow(icon: "doc", label: "Vehicle Registration")
                            DocumentRow(icon: "doc", label: "Commercial Insurance")
                            DocumentRow(icon: "calendar", label: "Expiration Date")
                            DocumentRow(icon: "person.crop.rectangle", label: "Driving License")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }
                    
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
}
