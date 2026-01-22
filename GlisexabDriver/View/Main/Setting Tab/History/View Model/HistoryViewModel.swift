//
//  HistoryViewModel.swift
//  Glisexab
//
//  Created by Arbaz  on 06/01/26.
//

import Foundation
import SwiftUI
internal import Combine

class HistoryViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
    @Published var isShowRideDetail: Bool = false
    @Published var requestiD: String = ""
    
    @Published var appState = AppState()
    
    @Published var rideHistory: [Res_HistoryList] = []
    
    func fetchRideHistory() async {
        isLoading = true
        customError = nil

        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD

        print(paramDict)
                
        do {
            let response = try await Api.shared.requestToHistoryList(params: paramDict)
            self.rideHistory = response
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
}
