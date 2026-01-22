//
//  ProfileViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import Foundation
import SwiftUI
internal import Combine
import SDWebImageSwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var userProfile: Res_LoginResponse?
    @Published var customError: CustomError? = nil
    @Published var isLoading: Bool = false
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var contactNumber: String = ""
    @Published var mobileCode: String = ""
    @Published var location: String = ""
    
    @Published var selectedUIImage: UIImage? = nil
    
    @Published var isSuccess: Bool = false
    
    func fetchUserProfile(appState: AppState) async {
        
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
        
//        Api.shared.requestToFetchProfile(params: paramDict) { [weak self] result in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let res):
//                    self.firstName = res.first_name ?? ""
//                    self.lastName = res.last_name ?? ""
//                    self.email = res.email ?? ""
//                    self.contactNumber = res.mobile ?? ""
//                    self.location = res.address ?? ""
//                    
//                    Utility.downloadImageBySDWebImage(res.image ?? "") { img, error in
//                        if let img = img {
//                            DispatchQueue.main.async {
//                                self.selectedUIImage = img
//                            }
//                        } else if let error = error {
//                            print("Image download failed: \(error.localizedDescription)")
//                        }
//                    }
//                    
//                case .failure(let error):
//                    self.customError = .customError(message: error.localizedDescription)
//                }
//            }
//        }
        do {
            let res = try await Api.shared.requestToFetchProfile(params: paramDict)
            self.firstName = res.first_name ?? ""
            self.lastName = res.last_name ?? ""
            self.email = res.email ?? ""
            self.contactNumber = res.mobile ?? ""
            self.location = res.address ?? ""
            
            Utility.downloadImageBySDWebImage(res.image ?? "") { img, error in
                if let img = img {
                    DispatchQueue.main.async {
                        self.selectedUIImage = img
                    }
                } else if let error = error {
                    print("Image download failed: \(error.localizedDescription)")
                }
            }
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func updateUserProfile(appState: AppState) async {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        isSuccess = false
        
        var paramDict: [String : String] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["first_name"] = self.firstName
        paramDict["last_name"] = self.lastName
        paramDict["mobile"] = self.contactNumber
        paramDict["mobile_witth_country_code"] = "\(mobileCode)\(contactNumber)"
        paramDict["email"] = self.email
        
        print(paramDict)
        
        var paramImageDict: [String : UIImage] = [:]
        paramImageDict["image"] = self.selectedUIImage
        
        print(paramImageDict)
        
//        Api.shared.requestToUpdateProfile(params: paramDict, imageParam: paramImageDict) { [weak self] result in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(_):
//                    self.successMessage = "Your Profile Updated Successfully!"
//                case .failure(let error):
//                    self.customError = .customError(message: error.localizedDescription)
//                }
//            }
//        }
        
        do {
            let _ = try await Api.shared.requestToUpdateProfile(params: paramDict, imageParam: paramImageDict)
            self.isSuccess = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func validateFields() -> Bool {
        if firstName.isEmpty {
            customError = .customError(message: "Please enter your first name.")
            return false
        } else if lastName.isEmpty {
            customError = .customError(message: "Please enter your last name.")
            return false
        } else if email.isEmpty {
            customError = .customError(message: "Please enter your valid email address.")
            return false
        } else if contactNumber.isEmpty {
            customError = .customError(message: "Please enter your mobile number.")
            return false
        } else if selectedUIImage == nil {
            customError = .customError(message: "Please select your profile image.")
            return false
        }
        return true
    }
}
