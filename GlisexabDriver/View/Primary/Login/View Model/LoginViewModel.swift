//
//  LoginViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var mobile: String = ""
    @Published var password: String = ""
    
    @Published var mobileCode: String = ""
    @Published var isLoading: Bool = false
    @Published var user: Res_LoginResponse?
    @Published var isSuccess: Bool = false
    
    @Published var customError: CustomError? = nil
    
    func validateFields() -> Bool {
        if mobile.isEmpty || password.isEmpty {
            customError = .customError(message: "Please enter the required details.")
            return false
        }
        return true
    }
    
    func webLoginResponse(appState: AppState) {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["mobile"] = mobile
        paramDict["password"] = password
        paramDict["mobile_witth_country_code"] = "\(mobileCode)\(mobile)"
        paramDict["register_id"] = ""
        paramDict["ios_register_id"] = ""
        paramDict["type"] = "DRIVER"
        paramDict["lat"] = "0.0"
        paramDict["lon"] = "0.0"
        
        print(paramDict)
        
        Api.shared.requestToLogin(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let userResponse):
                    self.user = userResponse
                    print("✅ Login Success:", userResponse)
                    
                    if let useriD = userResponse.id  {
                        appState.useriD = useriD
                        appState.isLoggedIn = true
                        appState.cardiD = userResponse.cust_id ?? ""
                    }
                    
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                    print("❌ API Error:", error.localizedDescription)
                }
            }
        }
    }
}
