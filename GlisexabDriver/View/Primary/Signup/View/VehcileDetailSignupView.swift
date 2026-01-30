//
//  VehcileDetailSignupView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

struct VehcileDetailSignupView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var isDropDown: Bool = false
    @State private var showVehicleCamera = false
    @State private var showRegistrationCamera = false
    @State private var showLicenseCamera = false
    @State private var showSuccessBanner = false
    
    @StateObject private var viewModel = VehicleDetailViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                headerText
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        inputFields
                        SignupAction
                    }
                    .padding(.top, 24)
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            
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
            
            SimpleToastView (
                message: "Your account has been created successfully!",
                isPresented: showSuccessBanner
            )
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.fetchVehicleList(appState: appState)
            }
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
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    private var headerText: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                }
                
                HStack(spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("Glide Cabs")
                        .font(.customfont(.semiBold, fontSize: 28))
                }
            }
            
            Text("Add Vehicle details")
                .font(.customfont(.semiBold, fontSize: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Add your vehicle details for verification")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            vehicleTypeField
            vehicleImageField
            registrationNumField
            registrationImageField
            licenseNumField
            licenseImageField
        }
    }
    
    private var vehicleTypeField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Vehicle Type")
                .font(.customfont(.medium, fontSize: 14))

            Button(action: {
                withAnimation {
                    isDropDown.toggle()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(height: 45)
                        .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)
                    
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
        }
    }
    
    private var vehicleImageField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Vehicle Image")
                .font(.customfont(.medium, fontSize: 14))

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 100)
                    .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)

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
        }
    }
    
    private var registrationNumField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Registration Number")
                .font(.customfont(.medium, fontSize: 14))

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 45)
                    .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)

                TextField("Enter Registration Number", text: $viewModel.registrationNumber)
                    .font(.customfont(.light, fontSize: 14))
                    .padding()
            }
        }
    }
    
    private var registrationImageField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Vehicle Registration")
                .font(.customfont(.medium, fontSize: 14))

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 100)
                    .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)

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
        }
    }
    
    private var licenseNumField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("License Number")
                .font(.customfont(.medium, fontSize: 14))
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 45)
                    .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)

                TextField("Enter License Number", text: $viewModel.licenseNumber)
                    .font(.customfont(.light, fontSize: 14))
                    .padding()
            }
        }
    }
    
    private var licenseImageField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Driving License")
                .font(.customfont(.medium, fontSize: 14))
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 100)
                    .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)

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
    }
    
    private var SignupButtonLabel: some View {
        Group {
//            if viewModel.isLoading {
//                ProgressView()
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 45)
//                    .background(Color.white)
//                    .cornerRadius(10)
//            } else {
//                Text("Register")
//                    .font(.customfont(.bold, fontSize: 16))
//                    .foregroundColor(.yellow)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 45)
//                    .background(Color.colorNeavyBlue)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//            }
            Text("Register")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.colorNeavyBlue)
                .cornerRadius(10)
                .shadow(radius: 2)

        }
    }
    
    private var SignupAction: some View {
        Button {
            if viewModel.validateVehicleFields() {
                viewModel.paramVehicleDictionary()
                viewModel.paramVehicleImageDictionary()
//                router.push(to: .otp)
//                Task {
//                    await viewModel.webServiceCallForSignup(appState: appState)
//                }
            }
        } label: {
            SignupButtonLabel
        }
        .disabled(viewModel.isLoading)
    }
}

#Preview {
    VehcileDetailSignupView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
