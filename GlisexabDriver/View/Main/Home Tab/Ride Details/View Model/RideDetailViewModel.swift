//
//  RideDetailViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import Foundation
import SwiftUI
internal import Combine

class RideDetailViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: String? = nil
    @Published var rideDtls: Res_RideDetail?
    
    func loadRideDetails(appState: AppState, requestiD: String) async {
            isLoading = true
            customError = nil
            
            var paramDict: [String : Any] = [:]
            paramDict["request_id"] = requestiD
            paramDict["timezone"] = localTimeZoneIdentifier
            
            print(paramDict)
                    
        do {
            let response = try await Api.shared.requestToRideDetails(params: paramDict)
            self.rideDtls = response
        } catch {
            self.customError = error.localizedDescription
        }
        
        isLoading = false
    }
}
