//
//  SignupView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI
import CountryPicker

struct SignupView: View {
    
    // MARK: PROPERTY
    @State private var showCountryPicker = false
    @State private var showAddressPicker = false
    @State private var showErrorBanner = false
    @State private var showCameraPicker = false
    
    @State private var countryObj: Country?
    
    @Environment(\.dismiss) private var dissmiss
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject var viewModel = SignupViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 16) {
                headerText
                
                ScrollView {
                    VStack(spacing: 24) {
                        inputsField
                        signupButton
                        bottomSignin
                    }// VSTACK
                    .padding(.top, 24)
                }
            }
            .padding(.horizontal, 24)
        } // ZSTACk
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .sheet(isPresented: $showAddressPicker) {
            NavigationView {
                addressView()
            }
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.profileImage = image
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
                    dissmiss()
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
            
            Text("Sign up")
                .font(.customfont(.semiBold, fontSize: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Create an account to continue")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputsField: some View {
        VStack(alignment: .leading, spacing: 16) {
            profileImageView
            firstName
            lastName
            emailField
            addressField
            numberField
            passwordField
            confirmPasswordField
            termCondition
        }
    }
    
    private var profileImageView: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let uiImage = viewModel.profileImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            Image("editImg")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(6)
                .background(.white)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onTapGesture {
            showCameraPicker = true
        }
    }
    
    private var firstName: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("First Name")
                .font(.customfont(.medium, fontSize: 14))
            
            TextField("Please enter first name", text: $viewModel.firstName)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .font(.customfont(.regular, fontSize: 14))
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)
                )
        }
    }
    
    private var lastName: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Last Name")
                .font(.customfont(.medium, fontSize: 14))
            
            TextField("Please enter last name", text: $viewModel.lastName)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .font(.customfont(.regular, fontSize: 14))
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)
                )
        }
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Email")
                .font(.customfont(.medium, fontSize: 14))
            
            TextField("Please enter email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .font(.customfont(.regular, fontSize: 14))
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.04), radius: 8,x: 0, y: 2)
                )
        }
    }
    
    private var numberField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Phone Number")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
            
            HStack(spacing: 0) {
                Button {
                    showCountryPicker = true
                } label: {
                    HStack(spacing: 6) {
                        if let countryObj = countryObj {
                            Text("\(countryObj.isoCode.getFlag())")
                                .font(.customfont(.medium, fontSize: 28))
                                .padding(.leading, 12)
                            
                            Text("+\(countryObj.phoneCode)")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.black)
                        }
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                .background(Color.white)
                
                TextField("123-245-89", text: $viewModel.mobile)
                    .keyboardType(.phonePad)
                    .font(.customfont(.regular, fontSize: 15))
                    .padding(.horizontal, 10)
                    .frame(height: 44)
            }
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                    )
            )
        }
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Set Password")
                .font(.customfont(.medium, fontSize: 14))
            
            HStack {
                if viewModel.isPaswordVisible {
                    TextField("Please enter password", text: $viewModel.password)
                } else {
                    SecureField("Please enter password", text: $viewModel.password)
                }
                
                Button {
                    viewModel.isPaswordVisible.toggle()
                } label: {
                    Image(systemName: viewModel.isPaswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .font(.customfont(.regular, fontSize: 14))
            .padding(.horizontal, 12)
            .frame(height: 50)
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
            )
        }
    }
    
    private var confirmPasswordField: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Confirm Password")
                .font(.customfont(.medium, fontSize: 14))
            
            HStack {
                if viewModel.isConfirmPasswordVisible {
                    TextField("Please enter password", text: $viewModel.confirmPassword)
                } else {
                    SecureField("Please enter password", text: $viewModel.confirmPassword)
                }
                
                Button {
                    viewModel.isConfirmPasswordVisible.toggle()
                } label: {
                    Image(systemName: viewModel.isConfirmPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .font(.customfont(.regular, fontSize: 14))
            .padding(.horizontal, 12)
            .frame(height: 50)
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
            )
        }
    }
    
    private var addressField: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Location")
                .font(.customfont(.medium, fontSize: 14))
            
            Button {
                showAddressPicker = true
            } label: {
                Text(viewModel.address.isEmpty ? "Select location" : viewModel.address)
                    .font(.customfont(.regular, fontSize: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .frame(height: 50)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.04),
                                    radius: 8,
                                    x: 0,
                                    y: 2)
                    )
            }
        }
    }
    
    private var signupButton: some View {
        Button {
            viewModel.mobileCode = countryObj?.phoneCode ?? ""
            if viewModel.validateFields() {
                viewModel.paramDictionary()
                viewModel.paramImageDictionary()
                router.push(to: .otp(email: viewModel.email))
            }
        } label: {
            Text("Register")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.colorNeavyBlue)
                .cornerRadius(10)
        }
        .padding(.top, 40)
    }
    
    private var bottomSignin: some View {
        VStack(spacing: 12) {
            Spacer()
            
            HStack(spacing: 4) {
                Text("Already have an account?")
                    .font(.customfont(.regular, fontSize: 14))
                    .foregroundColor(.gray)
                
                Button("Login") {
                    dissmiss()
                }
                .font(.customfont(.bold, fontSize: 14))
                .foregroundColor(.colorNeavyBlue)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 8)
        }
    }
    
    private var termCondition: some View {
        HStack(spacing: 8) {
            // Checkbox
            Button {
                viewModel.isCheck.toggle()
            } label: {
                Image(systemName: viewModel.isCheck ? "checkmark.square.fill" : "square")
                    .font(.title3)
                    .foregroundColor(.colorNeavyBlue)
            }
            .buttonStyle(.plain)

            // Text + link
            (
                Text("By Signing up you agree to our ")
                    .foregroundColor(.primary)
                +
                Text("Terms & Conditions")
                    .foregroundColor(.colorNeavyBlue)
                    .fontWeight(.semibold)
            )
            .font(.system(size: 14))
        }
        .padding(.horizontal)
    }
    
    private func addressView() -> some View {
        let addressViewModel = AddressSearchViewModel()
        addressViewModel.delegate = self
        return AnyView(AddressPickerView(searchViewModel: addressViewModel))
    }
}

extension SignupView: Address {
    func didSelectAddress(result: Result<LocationData, LocationError>) {
        switch result {
        case .success(let result):
            viewModel.address = result.address ?? ""
            viewModel.city = result.city ?? ""
            viewModel.state = result.state ?? ""
            viewModel.latitude = result.latitude ?? 0.0
            viewModel.longitude = result.longitude ?? 0.0
        case .failure(let error):
            //            $viewModel.error = .customError(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SignupView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
