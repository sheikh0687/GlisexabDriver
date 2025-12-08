//
//  LoginView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/10/25.
//

import SwiftUI
import CountryPicker

struct LoginView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.dismiss) private var dissmiss
    @EnvironmentObject var router: NavigationRouter
    
    @StateObject var viewModel = LoginViewModel()
    @State private var countryObj: Country?
    
    @State private var showCountryPicker = false
    @State private var showErrorBanner = false
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    headerText
                    inputFields
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    forgetPasswordAction
                    loginAction
                    signupAction
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color.white)
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
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
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .onChange(of: viewModel.customError) { newError in
            if newError != nil {
                showErrorBanner = true
            }
        }
        .alert(isPresented: $showErrorBanner) {
            Alert (
                title: Text(Constant.AppName),
                message: Text(viewModel.customError?.localizedDescription ?? "Something went wrong!"),
                dismissButton: .default(Text("Ok")) {
                    withAnimation {
                        viewModel.customError = nil
                    }
                }
            )
        }
    }
    
    // MARK: - Explicitly typed subviews
    private var headerText: some View {
        Text("Continue to Sign in")
            .font(.customfont(.medium, fontSize: 18))
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)
            .padding(.bottom, 20)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            mobileNumberField
            passwordField
        }
    }
    
    @ViewBuilder
    private var mobileNumberField: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact Number")
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
                    .padding(.leading, 8)
                    
                    TextField("Enter Contact Number", text: $viewModel.mobile)
                        .font(.customfont(.light, fontSize: 14))
                        .padding(.leading, 4)
                }
//                .padding()
            }
        }
    }
    
    @ViewBuilder
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
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
                    
                    SecureField("Enter Password", text: $viewModel.password)
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
    }
    
    private var forgetPasswordAction: some View {
        HStack {
            Spacer()
            Button("Forget Password?") {
                //                router.push(to: )
            }
            .font(.customfont(.semiBold, fontSize: 14))
            .foregroundColor(.colorNeavyBlue)
            .padding(.trailing, 24)
        }
        .padding(.top, 15)
    }
    
    private var loginButtonLabel: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.white)
                    .cornerRadius(10)
            } else {
                Text("Signin")
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.colorNeavyBlue)
                    .cornerRadius(10)
            }
        }
    }
    
    private var loginAction: some View {
        Button {
            viewModel.mobileCode = countryObj?.phoneCode ?? ""
            viewModel.webLoginResponse(appState: appState)
        } label: {
            loginButtonLabel
        }
        .disabled(viewModel.isLoading)
        .padding(.horizontal, 24)
        .padding(.top, 40)
        .onChange(of: viewModel.user != nil) { userIn in
            if userIn {
                router.push(to: .home)
            }
        }
    }
    
    private var signupAction: some View {
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
    }
}

#Preview {
    LoginView()
}
