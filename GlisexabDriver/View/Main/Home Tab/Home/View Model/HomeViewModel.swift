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
    @Published var isReqAccept: Bool = false
    @Published var strBookingType: String = ""
    
    // Earnings
    @Published var todayEarning: Double = 0
    @Published var todayTrips: Int = 0
    
    // Pending Ride Requests
    @Published var pendingRequests: [Res_PendingRequest] = []
    @Published var selectedRequest: Res_PendingRequest?
    @Published var userProfile: Res_LoginResponse?
    
    func toggleOnline() {
        isOnline.toggle()
    }
    
    // MARK: API
    func loadPendingRequests(appState: AppState) {
        
        isLoading = true
        customError = nil
        
        let params: [String : Any] = ["driver_id": appState.useriD]
        
        print(params)
        
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
    
    func loadChangeRequest(appState: AppState, requestiD: String) {
        isLoading = true
        customError = nil
        
        var param: [String : Any] = [:]
        param["driver_id"] = appState.useriD
        param["request_id"] = requestiD
        param["status"] = "Accept"
        
        print(param)
        
        Api.shared.reqToChangeRequest(params: param) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(_):
                    self.isReqAccept = true
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadRejectedRequest(appState: AppState, reqiD: String) {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        paramDict["request_id"] = reqiD
        
        print(paramDict)
        
        Api.shared.reqToRejectRequest(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(_):
                    self.isReqAccept = false
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadDriverStatus(appState: AppState, driverStatus: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        paramDict["available_status"] = driverStatus
        
        print(paramDict)
        
        Api.shared.reqToUpdateDriverStatus(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func toggleDriverStatus(appState: AppState) {
        let newStatus = !isOnline      // what user wants to change to
        let statusString = newStatus ? "Online" : "Offline"

        isLoading = true

        loadDriverStatus(appState: appState, driverStatus: statusString) { success in
            DispatchQueue.main.async {
                if success {
                    self.isOnline = newStatus   // update UI only on success
                } else {
                    // Optionally show an error alert
                    print("Status change failed")
                }
            }
        }
    }
    
    func loadDriverProfileDetail(appState: AppState) {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        Api.shared.requestToFetchProfile(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let res):
                    self.userProfile = res
                    
                    if res.available_status?.lowercased() == "online" {
                        self.isOnline = true
                    } else {
                        self.isOnline = false
                    }
                    
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
}
