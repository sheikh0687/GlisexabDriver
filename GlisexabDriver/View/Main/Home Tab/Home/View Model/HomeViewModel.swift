//
//  HomeViewModel.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 19/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    // UI
    @Published var isOnline: Bool = false
    @Published var showMenu: Bool = false
    @Published var customError: CustomError?
    @Published var isLoading: Bool = false
    
    // Earnings
    @Published var todayEarning: Double = 0
    @Published var todayTrips: Int = 0
    
    // Pending Ride Requests
    @Published var pendingRequests: [Res_PendingRequest] = []
    @Published var selectedRequest: Res_PendingRequest?
    
    func toggleOnline() {
        isOnline.toggle()
    }
    
    // MARK: API
    func loadPendingRequests(appState: AppState) {
        
        isLoading = true
        customError = nil
        
        let params: [String : Any] = ["driver_id": appState.useriD]
        
        Api.shared.requestToDriverPendingReq(params: params) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let res):
                    self.pendingRequests = res
                    self.selectedRequest = res.first      // Automatically show first request
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
}
