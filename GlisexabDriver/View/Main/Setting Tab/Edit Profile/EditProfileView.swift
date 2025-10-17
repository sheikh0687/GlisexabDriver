//
//  EditProfileView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = "Leslie Alexander"
    @State private var email: String = "lesliealexander@gmail.com"
    @State private var contact: String = "23874823****"
    @State private var location: String = "Royal Ln. Mesa, New Jersey"

    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        Image("leslie")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(.circle)
                        
                        VStack(spacing: 20) {
                            optionRow(heading: "Name", text: $name)
                            optionRow(heading: "Email", text: $email)
                            optionRow(heading: "Contact Number", text: $contact)
                            optionRow(heading: "Location", text: $location)
                        }
                        
                        Button("Edit Profile") {
                            // Edit action
                        }
                        .font(.customfont(.bold, fontSize: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.colorNeavyBlue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white)
                } // Scrool View
            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .padding(.top, 40)
            .ignoresSafeArea(edges: .bottom)
        } // ZSTACK
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
    
    @ViewBuilder
    func optionRow(heading: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.customfont(.medium, fontSize: 12))
                .foregroundColor(.gray)
            TextField("", text: text)
                .font(.customfont(.medium, fontSize: 14))
                .foregroundColor(.black)
                .padding(.vertical, 8)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .background (
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.white))
                .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Outer stroke border
                )
        )
    }
}

#Preview {
    EditProfileView()
}
