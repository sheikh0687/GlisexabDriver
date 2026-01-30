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
    @EnvironmentObject private var appState: AppState
    
    @Environment(\.dismiss) var dissmiss
    
    @StateObject var viewModel = VerifyNumberViewModel()
    
    @State private var digits: [String] = Array(repeating: "", count: 4)
    @State var email: String = ""
    
    let numberOfDigits = 4
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                headerButton
                title
                
                OTPFieldView (
                    numberOfFields: numberOfDigits,
                    digits: $digits
                )
                
                if viewModel.showErrorMessgae {
                    Text("Please enter the correct code")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                if viewModel.isReceivedOTP {
                    HStack {
                        Text("Didn't receive code?")
                            .font(.body)
                            .foregroundColor(.gray)
                        Button("Resend") {
                            Task { await viewModel.verifyEmailAddress(email: email) }
                        }
                        .font(.body.bold())
                        .foregroundColor(.blue)
                        .disabled(viewModel.isLoading)
                    }
                    .padding(.horizontal)
                }
                
                sendOtp
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok"))
            )
        }
        .onChange(of: viewModel.isNewUser) { isNewUser in
            if isNewUser {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.showSuccessToast = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.viewModel.showSuccessToast = false
                    }
                    
                    router.push(to: .uploadDocument)
                }
            }
        }
        .onAppear {
            // Send initial OTP
            Task { await viewModel.verifyEmailAddress(email: email) }
        }
    }
        
    private func autoFillOTP(newOTP: Int) {
        let codeString = "\(newOTP)"
        for (index, digit) in codeString.enumerated() {
            if index < digits.count {
                digits[index] = String(digit)
            }
        }
    }
    
    // headerButton, title, sendOtp remain exactly the same as your original
    private var headerButton: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    dissmiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var title: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Enter verification code")
                .font(.customfont(.semiBold, fontSize: 16))
            Text("A code was sent to your email \(email)")
                .font(.customfont(.medium, fontSize: 14))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
    
    private var sendOtp: some View {
        let enteredCode = digits.joined()
        let isValidLength = enteredCode.count == numberOfDigits
        
        return Button {
            if enteredCode == "\(viewModel.otp)" {
                print("✅ OTP Verified: \(enteredCode)")
               Task {
                   await viewModel.webServiceCallForSignup(appState: appState)
                }
            } else {
                print("❌ Invalid OTP. Expected: \(viewModel.otp), Got: \(enteredCode)")
                withAnimation {
                    digits = Array(repeating: "", count: numberOfDigits)
                }
                viewModel.showErrorMessgae = true
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Submit")
                        .font(.customfont(.regular, fontSize: 14))
                }
            }
            .foregroundColor(.yellow)
            .shadow(radius: 2)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
        }
        .background(isValidLength && !viewModel.isLoading ? .colorNeavyBlue : Color.gray.opacity(0.5))
        .cornerRadius(10)
        .disabled(!isValidLength || viewModel.isLoading)
        .padding(.top, 16)
    }
}

struct OTPFieldView: View {
    let numberOfFields: Int
    @Binding var digits: [String]
    @FocusState private var focusedField: Int?  // Keep focus INTERNAL
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                SingleDigitField (
                    text: $digits[index],
                    isFocused: focusedField == index
                ) { newText in
                    handleDigitChange(at: index, newValue: newText)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .onAppear {
            // Auto-focus first field
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedField = 0
            }
        }
    }
    
    private func handleDigitChange(at index: Int, newValue: String) {
        digits[index] = String(newValue.prefix(1)).filter { $0.isNumber }
        
        // Forward focus
        if !digits[index].isEmpty && index < numberOfFields - 1 {
            focusedField = index + 1
        }
        // Backward focus (backspace)
        else if digits[index].isEmpty && index > 0 {
            focusedField = index - 1
        }
        // Complete - dismiss keyboard
        else if digits.allSatisfy({ !$0.isEmpty }) {
            focusedField = nil
        }
    }
}

struct SingleDigitField: View {
    @Binding var text: String
    let isFocused: Bool
    let onChange: (String) -> Void
    
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(isFocused ? .blue : .black)
            .frame(width: 50, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 2)
                    .background(Color.gray.opacity(0.3))
            )
            .onChange(of: text) { newValue in
                let filtered = String(newValue.prefix(1)).filter { $0.isNumber }
                onChange(filtered)
            }
    }
}

#Preview {
    OtpView()
}
