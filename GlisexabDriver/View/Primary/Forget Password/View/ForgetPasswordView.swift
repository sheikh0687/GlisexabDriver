//
//  ForgetPasswordView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI

struct ForgetPasswordView: View {
        
    @StateObject private var viewModel = ResetPasswordViewModel()
    @Environment(\.dismiss) var dissmiss
    
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
            
            SimpleToastView (
                message: "Your password has been sent to your registered email address.",
                isPresented: viewModel.showSuccessBanner
            )
        }
        .navigationBarBackButtonHidden(true)
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok"))
            )
        }
        .onChange(of: viewModel.userStatus) { userStatus in
            if userStatus {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.viewModel.showSuccessBanner = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.viewModel.showSuccessBanner = false
                    }
                    
                    dissmiss()
                }
            }
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
            
            Text("Enter your registered email address")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 18) {
            emailField
//            newPasswordField
//            confirmPasswordField
        }
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
            
            TextField("Please enter email address", text: $viewModel.email)
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
    
    private var confirmButton: some View {
        Button {
            Task {
                await viewModel.webResetPassword()
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Get Password")
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
    }
    
    //    private var newPasswordField: some View {
    //        VStack(alignment: .leading, spacing: 6) {
    //            Text("New Password")
    //                .font(.customfont(.regular, fontSize: 14))
    //                .foregroundColor(.gray)
    //
    //            HStack {
    //                if isPasswordVisible {
    //                    TextField("Please enter password", text: $newPassword)
    //                } else {
    //                    SecureField("Please enter password", text: $newPassword)
    //                }
    //
    //                Button {
    //                   isPasswordVisible.toggle()
    //                } label: {
    //                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
    //                        .foregroundColor(.gray)
    //                }
    //            }
    //            .font(.customfont(.regular, fontSize: 14))
    //            .padding(.horizontal, 12)
    //            .frame(height: 50)
    //            .background (
    //                RoundedRectangle(cornerRadius: 10)
    //                    .fill(Color.white)
    //                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
    //            )
    //        }
    //    }
        
    //    private var confirmPasswordField: some View {
    //        VStack(alignment: .leading, spacing: 6) {
    //            Text("Confirm Password")
    //                .font(.customfont(.regular, fontSize: 14))
    //                .foregroundColor(.gray)
    //
    //            HStack {
    //                if isPasswordVisible {
    //                    TextField("Please enter password", text: $newPassword)
    //                } else {
    //                    SecureField("Please enter password", text: $newPassword)
    //                }
    //
    //                Button {
    //                   isPasswordVisible.toggle()
    //                } label: {
    //                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
    //                        .foregroundColor(.gray)
    //                }
    //            }
    //            .font(.customfont(.regular, fontSize: 14))
    //            .padding(.horizontal, 12)
    //            .frame(height: 50)
    //            .background (
    //                RoundedRectangle(cornerRadius: 10)
    //                    .fill(Color.white)
    //                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
    //            )
    //        }
    //    }

}

#Preview {
    ForgetPasswordView()
}
