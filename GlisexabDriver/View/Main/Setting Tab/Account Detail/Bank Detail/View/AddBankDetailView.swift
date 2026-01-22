//
//  AddBankDetailView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 17/01/26.
//

import SwiftUI

struct AddBankDetailsView: View {
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @State private var accountHolderName = ""
    @State private var bankName = ""
    @State private var accountNumber = ""
    @State private var ifscCode = ""
    @State private var upiId = ""
    
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Add Bank Details")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                        }
                        .padding(.top, 40)
                        
                        // Form Fields
                        VStack(spacing: 20) {
                            BankFieldView (
                                title: "Account Holder Name",
                                placeholder: "Enter account holder name",
                                text: $accountHolderName,
                                keyboardType: .default,
                                icon: "person"
                            )
                            
                            BankFieldView(
                                title: "Bank Name",
                                placeholder: "Enter bank name",
                                text: $bankName,
                                keyboardType: .default,
                                icon: "building"
                            )
                            
                            BankFieldView (
                                title: "Account Number",
                                placeholder: "Enter account number",
                                text: $accountNumber,
                                keyboardType: .numberPad,
                                icon: "creditcard"
                            )
                            
                            BankFieldView (
                                title: "IFSC/SWIFT Code",
                                placeholder: "Enter IFSC/SWIFT code",
                                text: $ifscCode,
                                keyboardType: .default,
                                icon: "barcode"
                            )
                            
                            BankFieldView (
                                title: "UPI Account",
                                placeholder: "Enter UPI ID (optional)",
                                text: $upiId,
                                keyboardType: .emailAddress,
                                icon: "qrcode"
                            )
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                        
                        // Next Button
                        Button{
                            print("Call an APi!")
                        } label: {
                            HStack {
                                Spacer()
                                Text("NEXT")
                                    .font(.headline)
                                    .foregroundColor(.yellow)
                                Spacer()
                            }
                            .frame(height: 56)
                            .background(.colorNeavyBlue)
                            .cornerRadius(28)
                            .shadow(radius: 2)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(false)
    }
    
    private var isFormValid: Bool {
        !accountHolderName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !bankName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !accountNumber.trimmingCharacters(in: .whitespaces).isEmpty &&
        !ifscCode.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
//    private func saveBankDetails() {
//        guard isFormValid else { return }
//        
//        isLoading = true
//        
//        let params = [
//            "user_id": appState.useriD,
//            "account_holder_name": accountHolderName.trimmingCharacters(in: .whitespaces),
//            "bank_name": bankName.trimmingCharacters(in: .whitespaces),
//            "account_number": accountNumber.trimmingCharacters(in: .whitespaces),
//            "ifsc_swift_code": ifscCode.trimmingCharacters(in: .whitespaces),
//            "upi_id": upiId.trimmingCharacters(in: .whitespaces)
//        ]
//        
//        Task {
//            do {
//                // Replace with your API endpoint
//                // let response = try await Api.shared.saveBankDetails(params: params)
//                try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network call
//                
//                // Navigate to next screen
//                router.push(to: .bankVerification) // Update with your next screen
//                
//            } catch {
//                errorMessage = error.localizedDescription
//                showError = true
//            }
//            isLoading = false
//        }
//    }
}

struct BankFieldView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.caption)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            TextField(placeholder, text: $text)
                .font(.body)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 4)
        }
    }
}

#Preview {
    AddBankDetailsView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
