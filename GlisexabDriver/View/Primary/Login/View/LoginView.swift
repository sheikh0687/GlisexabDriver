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
        ZStack(alignment: .top) {
            
            ScrollView {
                VStack(spacing: 24) {
                    headerText
                    inputFields
                    forgetPasswordAction
                    loginButton
                    separatorOr
                    googleButton
                    bottomSignup
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.user != nil) { loggedIn in
            if loggedIn { router.push(to: .home) }
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
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                Text("Glide Cabs")
                    .font(.customfont(.semiBold, fontSize: 28))
            }
            
            Text("Log in")
                .font(.customfont(.semiBold, fontSize: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Enter your email and password to login")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            emailField
            passwordField
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
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Password")
                .font(.customfont(.medium, fontSize: 14))
            
            HStack {
                if viewModel.isPasswordVisible {
                    TextField("Please enter password", text: $viewModel.password)
                } else {
                    SecureField("Please enter password", text: $viewModel.password)
                }
                
                Button {
                    viewModel.isPasswordVisible.toggle()
                } label: {
                    Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
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
    
    private var forgetPasswordAction: some View {
        HStack {
            Spacer()
            Button("Forget Password?") {
                router.push(to: .otp)
            }
            .font(.customfont(.semiBold, fontSize: 13))
            .foregroundColor(.colorNeavyBlue)
        }
    }
    
    private var loginButton: some View {
        Button {
            Task {
               await viewModel.webLoginResponse(appState: appState)
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Login")
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
    
    private var separatorOr: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.2))
            Text("Or")
                .font(.customfont(.regular, fontSize: 13))
                .foregroundColor(.gray)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.2))
        }
        .padding(.top, 12)
    }
    
    private var googleButton: some View {
        Button {
            // Google sign-in action
        } label: {
            HStack(spacing: 10) {
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                
                Text("Continue with Google")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
            )
        }
    }
    
    private var bottomSignup: some View {
        VStack(spacing: 12) {
            Spacer()
            
            HStack(spacing: 4) {
                Text("Don’t have an account?")
                    .font(.customfont(.regular, fontSize: 14))
                    .foregroundColor(.gray)
                
                Button("Sign Up") {
                    router.push(to: .signup)
                }
                .font(.customfont(.bold, fontSize: 14))
                .foregroundColor(.colorNeavyBlue)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    LoginView()
}
