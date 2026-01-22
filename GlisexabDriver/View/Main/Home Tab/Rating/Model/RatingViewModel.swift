//
//  RatingViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import Foundation
import SwiftUI
internal import Combine

class RatingViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
    
    @Published var rating: Double = 0.0
    @Published var comment: String = ""
    @Published var userProfile: Res_LoginResponse?
    @Published var profileImg: UIImage? = nil
    @Published var showErrorBanner = false
    
    @Published var ratingAdded: Bool = false
    
    func loadUserProfileDetail(useriD: String) async {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = useriD
        
//        Api.shared.requestToFetchProfile(params: paramDict) { [weak self] result in
//            guard let self else { return }
//            
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let res):
//                    self.userProfile = res
//                    
//                    Utility.downloadImageBySDWebImage(res.image ?? "") { img, error in
//                        if let img = img {
//                            DispatchQueue.main.async {
//                                self.profileImg = img
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
            self.userProfile = res
            
            Utility.downloadImageBySDWebImage(res.image ?? "") { img, error in
                if let img = img {
                    DispatchQueue.main.async {
                        self.profileImg = img
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
    
    func addUserRating(appState: AppState, useriD: String, reqiD: String) async {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["form_id"] = appState.useriD
        paramDict["to_id"] = useriD
        paramDict["request_id"] = reqiD
        paramDict["rating"] = rating
        paramDict["feedback"] = comment
        
        print(paramDict)
        
//        Api.shared.requestToAddUserRating(params: paramDict) { [weak self] result in
//            guard let self else { return }
//            
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success:
//                    self.ratingAdded = true
//                case .failure(let error):
//                    self.customError = .customError(message: error.localizedDescription)
//                }
//            }
//        }
        
        do {
            let _ = try await Api.shared.requestToAddUserRating(params: paramDict)
            self.ratingAdded = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func validateFields() -> Bool {
        if rating == 0.0 {
            customError = .customError(message: "Please select the rating.")
            return false
        }
        return true
    }
}
