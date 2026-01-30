//
//  ContactUsViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 28/01/26.
//

import SwiftUI
internal import Combine

final class ContactUsViewModel: ObservableObject {
    
    @Published var comment: String = ""
    @Published var email: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isConnected: Bool = false
    
    @Published var customError: CustomError?
    
    @MainActor
    func webToContactAdmin(appState: AppState) async {
        
        guard isValidFields() else { return }
        
        isLoading = true
        customError = nil
        isConnected = false
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["email"] = email
        paramDict["message"] = comment
        
        print(paramDict)
        
        do {
            let _ = try await Api.shared.requestToContactAdmin(params: paramDict)
            self.isConnected = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        self.isLoading = false
    }
    
    func isValidFields() -> Bool {
        if comment.isEmpty {
            customError = .customError(message: "Please put the message!")
            return false
        } else if email.isEmpty {
            customError = .customError(message: "Please enter the registered email address!")
            return false
        }
     
        return true
    }
}
