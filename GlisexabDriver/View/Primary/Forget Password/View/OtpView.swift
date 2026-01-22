//
//  Otp.swift
//  Glisexab
//
//  Created by Arbaz  on 02/01/26.
//

import SwiftUI
import CountryPicker

struct OtpView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) var dissmiss
    
    @StateObject var viewModel = VerifyNumberViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                headerText
                numberField
                sendOtp
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.viewModel.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $viewModel.showCountryPicker) {
            CountryPickerUI(country: $viewModel.countryObj)
        }
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok"))
            )
        }
        .onChange(of: viewModel.isReceived) { isReceived in
            if isReceived {
                router.push(to: .forgetPassword)
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
            
            Text("Enter your registered number")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var numberField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Phone Number")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
            
            HStack(spacing: 0) {
                Button {
                    viewModel.showCountryPicker = true
                } label: {
                    HStack(spacing: 6) {
                        if let countryObj = viewModel.countryObj {
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
                
                TextField("123-245-89", text: $viewModel.phoneNumber)
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
        
    private var sendOtp: some View {
        Button {
           Task {
               await viewModel.verifyNumber()
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Send OTP")
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
}

#Preview {
    OtpView()
}
