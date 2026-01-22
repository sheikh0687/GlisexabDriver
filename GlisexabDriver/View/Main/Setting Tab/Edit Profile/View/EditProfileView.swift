//
//  EditProfileView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI
import CountryPicker

struct EditProfileView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    @State private var showCameraPicker = false
    @State private var showCountryPicker = false
    @State private var showToastMessage = false
    
    @State private var countryObj: Country?
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
             VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        profileImageView
                        formFields
                        updateButton
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white)
                } // Scrool View
            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .padding(.top, 40)
            .ignoresSafeArea(edges: .bottom)
            
            SimpleToastView (
                message: "Your profile has been updated successfully.",
                isPresented: showToastMessage
            )
            
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
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.selectedUIImage = image
            }
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            if countryObj == nil {
                countryObj = Country(phoneCode: "91", isoCode: "IN")
            }
            // Update ViewModel mobileCode when countryObj changes
            if let countryObj = countryObj {
                viewModel.mobileCode = "\(countryObj.phoneCode)"
            }
           Task {
               await viewModel.fetchUserProfile(appState: appState)
            }
        }
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok")) {
                    withAnimation {
                        viewModel.customError = nil
                    }
                }
            )
        }
        .onChange(of: viewModel.isSuccess) { isSuccess in
            if isSuccess {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.showToastMessage = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showToastMessage = false
                    }
                    Task {
                        await viewModel.fetchUserProfile(appState: appState)
                     }
                }
            }
        }
    }
    
    private var profileImageView: some View {
        ZStack(alignment: .bottomTrailing) {
            
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
            
            Image("editImg")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(6)
                .background(.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
        .onTapGesture {
            showCameraPicker = true
        }
    }
    
    private var formFields: some View {
        VStack(spacing: 20) {
            optionRow(heading: "First Name", text: $viewModel.firstName)
            optionRow(heading: "Last Name", text: $viewModel.lastName)
            optionRow(heading: "Email", text: $viewModel.email)
            optionRow(heading: "Contact Number", text: $viewModel.contactNumber)
        }
    }
    
    private var updateButton: some View {
        Button {
            Task {
                await viewModel.updateUserProfile(appState: appState)
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Update Profile")
                        .font(.customfont(.regular, fontSize: 14))
                }
            }
            .foregroundColor(.yellow)
            .shadow(radius: 2)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            
        }
        .background (.colorNeavyBlue)
        .cornerRadius(10)
        .disabled(viewModel.isLoading)
        .padding(.top, 16)
    }

    @ViewBuilder
    func optionRow(heading: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.customfont(.medium, fontSize: 12))
                .foregroundColor(.gray)
            HStack {
                if heading == "Contact Number" {
                    Button {
                        showCountryPicker = true
                    } label: {
                        if let countryObj = countryObj {
                            Text("\(countryObj.isoCode.getFlag())")
                                .font(.customfont(.medium, fontSize: 28))
                            Text("+\(countryObj.phoneCode)")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.black)
                        }
                    }
                    TextField("", text: text)
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                    
                } else {
                    TextField("", text: text)
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                }
            }
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
