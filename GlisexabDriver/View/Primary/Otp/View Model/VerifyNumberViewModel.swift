//
//  VerifyNumberViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 12/01/26.
//

import SwiftUI
internal import Combine
import CountryPicker

@MainActor
final class VerifyNumberViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError?
    
    @Published var isReceivedOTP: Bool = false
    @Published var otp: Int = 0
    @Published var isNewUser: Bool = false
    @Published var showSuccessToast = false
    @Published var showErrorMessgae = false

    func verifyEmailAddress(email: String) async {
        
        isLoading = true
        customError = nil
        defer { isLoading = false }
        
        var paramDict: [String : Any] = [:]
        paramDict["email"] = email
        paramDict["type"] = "DRIVER"
        
        print(paramDict)
                
        do {
            let response = try await Api.shared.requestToVerifyEmail(params: paramDict)
            self.otp = response.code ?? 0
            print(self.otp)
            self.isReceivedOTP = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
    }
    
    func webServiceCallForSignup(appState: AppState) async {
        
        print(paramSigupDetail)
        print(paramImageSignupDt)
        
        isLoading = true
        customError = nil
        isNewUser = false
        
        defer { isLoading = false }
        
        do {
            let response = try await Api.shared.requestToSignup(params: paramSigupDetail, imageParam: paramImageSignupDt)
            self.isNewUser = true
            
            print("✅ Login Success:", response)
            
            if let useriD = response.id  {
                appState.useriD = useriD
                appState.isLoggedIn = true
                appState.cardiD = response.cust_id ?? ""
            }
            
        } catch {
            self.customError = .customError(message: error.localizedDescription)
            print("❌ API Error:", error.localizedDescription)
        }
    }
    
//    func validateFields() -> Bool {
//        if emailAddress.isEmpty {
//            customError = .customError(message: "Please enter the registered email address.")
//            return false
//        }
//        return true
//    }
}

