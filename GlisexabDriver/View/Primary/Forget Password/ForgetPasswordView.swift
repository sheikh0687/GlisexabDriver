//
//  ForgetPasswordView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var newPassword: String = ""
    @State var otpCode: String = ""
    
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) var dissmiss
    
    @State var isLoading: Bool = false
    @State var customError: CustomError? = nil
    @State var showErrorBanner = false
    @State var showSuccessBanner = false
    
    @State var isPasswordReset: Bool = false
    @State var isPasswordVisible = false
    
    var body: some View {
        ZStack(alignment: .top) {
             VStack(spacing: 24) {
                headerText
                inputFields
                confirmButton
                Spacer()
            }// VSTACK
             .padding(.horizontal, 24)
             .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: customError) { newError in
            if newError != nil {
                showErrorBanner = true
            }
        }
        .onChange(of: isPasswordReset) { isSuccess in
            if isSuccess {
                showSuccessBanner = true
            }
        }
        .alert(isPresented: $showSuccessBanner) {
            Alert (
                title: Text(Constant.AppName),
                message: Text("Your new password has been sent to your mail."), dismissButton: .default(Text("ok")) {
                    router.popView()
                })
        }
        .alert(isPresented: $showErrorBanner) {
            Alert (
                title: Text(Constant.AppName),
                message: Text(customError?.localizedDescription ?? "Something went wrong"),
                dismissButton: .default(Text("ok")) {
                    withAnimation {
                        customError = nil
                    }
                }
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
            
            Text("Forgot Password")
                .font(.customfont(.semiBold, fontSize: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Enter your registered number")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 18) {
            codeField
            newPasswordField
            confirmPasswordField
        }
    }
    
    private var codeField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Code")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
            
            TextField("Please enter the code", text: $otpCode)
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
    
    private var newPasswordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("New Password")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
            
            HStack {
                if isPasswordVisible {
                    TextField("Please enter password", text: $newPassword)
                } else {
                    SecureField("Please enter password", text: $newPassword)
                }
                
                Button {
                   isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
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
        VStack(alignment: .leading, spacing: 6) {
            Text("Confirm Password")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)

            HStack {
                if isPasswordVisible {
                    TextField("Please enter password", text: $newPassword)
                } else {
                    SecureField("Please enter password", text: $newPassword)
                }
                
                Button {
                   isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
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
    
    private var confirmButton: some View {
        Button {
            print("Call an Api")
        } label: {
            Text("Confirm")
                .font(.customfont(.semiBold, fontSize: 14))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .background(Color.colorNeavyBlue)
        .cornerRadius(8)
    }
}

extension ForgetPasswordView {
    
//    func resetPassword() {
//        
//        guard !txtMobileNumber.isEmpty else {
//            return customError = .customError(message: "Please enter the valid email address.")
//        }
//        
//        isLoading = true
//        customError = nil
//        
//        let params = ["email": txtMobileNumber] // Pass your actual params
//        
//        print(params)
//        
//        Api.shared.requestToForgetPassword(params: params) { result in
//            
//            DispatchQueue.main.async {
//                isLoading = false
//                
//                switch result {
//                case .success(let response):
//                    if response.status == "1" {
//                        isPasswordReset = true
//                    } else {
//                        customError = .customError(message: response.result ?? "")
//                    }
//                case .failure(let error):
//                    customError = .customError(message: error.localizedDescription)
//                    print("❌ API Error:", error.localizedDescription)
//                }
//            }
//        }
//    }
}

#Preview {
    ForgetPasswordView()
}
