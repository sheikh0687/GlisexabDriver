//
//  ResetPasswordViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 30/01/26.
//

import SwiftUI
internal import Combine

final class ResetPasswordViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError?
    
    @Published var email: String = ""
    @Published var userStatus: Bool = false
    @Published var showSuccessBanner: Bool = false
    
    @MainActor
    func webResetPassword() async {
        
        guard validInputs() else { return }
        
        isLoading = true
        customError = nil
        userStatus = false
        defer { isLoading = false }
        
        var paramDict: [String : Any] = [:]
        paramDict["email"] = email
        paramDict["type"] = "DRIVER"
        
        print(paramDict)
        
        do {
            let response = try await Api.shared.requestToForgetPassword(params: paramDict)
            userStatus = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
    }
    
    func validInputs() -> Bool {
        if email.isEmpty {
            self.customError = .customError(message: "Please enter the registered email address")
            return false
        }
        
        return true
    }
}
