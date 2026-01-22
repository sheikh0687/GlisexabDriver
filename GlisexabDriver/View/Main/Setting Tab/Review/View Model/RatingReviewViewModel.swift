//
//  RatingReviewViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/01/26.
//

import SwiftUI
internal import Combine

@MainActor
final class RatingReviewViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError?
    @Published var arrayOfReview: [Res_ReviewList] = []
    
    func ratingReviewList(appState: AppState) async {
        isLoading = true
        customError = nil
     
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
                
        do {
            let res = try await Api.shared.requestToReviewList(params: paramDict)
            self.arrayOfReview = res
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
}
