//
//  VehcileDetailSignupView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

enum ActiveAlert {
    case error
    case success
}

struct VehcileDetailSignupView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @State private var isDropDown: Bool = false
    @State private var showVehicleCamera = false
    @State private var showRegistrationCamera = false
    @State private var showLicenseCamera = false
    @State private var showErrorBanner = false
    @State private var showSuccessBanner = false
    
    @StateObject var viewModel = SignupViewModel()
    
    @State private var activeAlert: ActiveAlert?
    
    var isAlertPresented: Binding<Bool> {
        Binding(
            get: { activeAlert != nil },
            set: { if !$0 { activeAlert = nil } }
        )
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    
                    Text("Add Vehicle Details")
                        .font(.customfont(.medium, fontSize: 18))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        //----------------------------------------------------
                        // MARK: - VEHICLE TYPE LABEL
                        //----------------------------------------------------
                        Text("Vehicle Type")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        //----------------------------------------------------
                        // MARK: - CUSTOM DROPDOWN BUTTON
                        //----------------------------------------------------
                        Button(action: {
                            withAnimation {
                                isDropDown.toggle()
                            }
                        }) {
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
                                    Text(
                                        viewModel.vehicleName.isEmpty ?
                                        "Select Vehicle Type" :
                                        viewModel.vehicleName
                                    )
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    
                                    Spacer()
                                    
                                    Image(systemName: isDropDown ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        //----------------------------------------------------
                        // MARK: - VEHICLE IMAGE
                        //----------------------------------------------------
                        Text("Vehicle Image")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 100)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            if let uiImage = viewModel.vehicleImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                        }
                        .onTapGesture {
                            showVehicleCamera = true
                        }
                        
                        //----------------------------------------------------
                        // MARK: - REGISTRATION NUMBER
                        //----------------------------------------------------
                        Text("Registration Number")
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
                            
                            TextField("Enter Registration Number", text: $viewModel.registrationNumber)
                                .font(.customfont(.light, fontSize: 14))
                                .padding()
                        }
                        
                        
                        Text("Vehicle Registration")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 100)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            if let uiImage = viewModel.registrationImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                        }
                        .onTapGesture {
                            showRegistrationCamera = true
                        }
                        
                        //----------------------------------------------------
                        // MARK: - LICENSE NUMBER
                        //----------------------------------------------------
                        Text("License Number")
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
                            
                            TextField("Enter License Number", text: $viewModel.licenseNumber)
                                .font(.customfont(.light, fontSize: 14))
                                .padding()
                        }
                        
                        Text("Driving License")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 100)
                                .cornerRadius(10)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            if let uiImage = viewModel.licenseImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Image("imagePlace")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                        }
                        .onTapGesture {
                            showLicenseCamera = true
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    SignupAction
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color.white)
                .navigationBarBackButtonHidden(true)
            }
            
            // ------------------------------------------------------------
            // MARK: - DROPDOWN LIST (OVERLAY ON TOP)
            // ------------------------------------------------------------
            if isDropDown {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(viewModel.vehicleList) { item in
                        Button {
                            viewModel.vehicleName = item.vehicle ?? ""
                            viewModel.vehicleiD = item.rawId ?? ""
                            
                            withAnimation {
                                isDropDown = false
                            }
                            
                        } label: {
                            HStack {
                                Text(item.vehicle ?? "")
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        }
                        
                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(.horizontal, 24)
                .offset(y: 155) // Position below dropdown button
            }
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
            viewModel.fetchVehicleList(appState: appState)
        }
        .sheet(isPresented: $showVehicleCamera) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.vehicleImage = image
            }
        }
        .sheet(isPresented: $showRegistrationCamera) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.registrationImage = image
            }
        }
        .sheet(isPresented: $showLicenseCamera) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.licenseImage = image
            }
        }
        .onChange(of: viewModel.customError) { newError in
            withAnimation {
                showErrorBanner = newError != nil
            }
        }
        .alert(isPresented: isAlertPresented) {
            switch activeAlert {
            case .error:
                return Alert (
                    title: Text(Constant.AppName),
                    message: Text(viewModel.customError?.localizedDescription ?? "Something went wrong!"),
                    dismissButton: .default(Text("Ok")) {
                        viewModel.customError = nil
                        activeAlert = nil
                    }
                )
            case .success:
                return Alert (
                    title: Text(Constant.AppName),
                    message: Text("Your profile has been created successfully!"),
                    dismissButton: .default(Text("ok")) {
                        activeAlert = nil
                        router.push(to: .home)
                    }
                )
            case nil:
                return Alert(title: Text(""))
            }
        }
        
    }
    
    private var SignupButtonLabel: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.white)
                    .cornerRadius(10)
            } else {
                Text("Signup")
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.colorNeavyBlue)
                    .cornerRadius(10)
            }
        }
    }
    
    private var SignupAction: some View {
        Button {
            if viewModel.validateVehicleFields() {
                viewModel.webServiceCallForSignup(appState: appState)
            }
        } label: {
            SignupButtonLabel
        }
        .disabled(viewModel.isLoading)
        .padding(.horizontal, 24)
        .padding(.top, 40)
    }
}

#Preview {
    VehcileDetailSignupView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}

