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
    @Published var otpCode: Int = 0
    @Published var isReceived: Bool = false
    
    @Published var showCountryPicker = false
    @Published var countryObj: Country?
    @Published var phoneNumber: String = ""
    
    func verifyNumber() async {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["mobile_with_code"] = "\(countryObj?.phoneCode ?? "")\(phoneNumber)"
        paramDict["mobile"] = phoneNumber
        
        print(paramDict)
        
//        Api.shared.requestToVerifyMobileNumber(params: paramDict) { [weak self] result in
//            guard let self else { return }
//            
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let success):
//                    self.otpCode = success.code ?? 0
//                    print(self.otpCode)
//                    self.isReceived = true
//                case .failure(let failure):
//                    self.customError = .customError(message: failure.localizedDescription)
//                }
//            }
//        }
        
        do {
            let response = try await Api.shared.requestToVerifyMobileNumber(params: paramDict)
            self.otpCode = response.code ?? 0
            print(self.otpCode)
            self.isReceived = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func validateFields() -> Bool {
        if phoneNumber.isEmpty {
            customError = .customError(message: "Please enter the registered mobile number.")
            return false
        }
        return true
    }
}

