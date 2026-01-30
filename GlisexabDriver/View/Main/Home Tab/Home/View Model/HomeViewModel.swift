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
    @Published var resActiveRequest: Res_ActiveDriverRequest?
    @Published var isSuccessReq: Bool = false
    
    func toggleOnline() {
        isOnline.toggle()
    }
    
    // MARK: API
    func loadPendingRequests(appState: AppState) async {
        
        isLoading = true
        customError = nil
        
        let params: [String : Any] = ["driver_id": appState.useriD]
        
        print(params)
                
        do {
            let res = try await Api.shared.requestToDriverPendingReq(params: params)
            self.pendingRequests = res
            self.selectedRequest = res.first
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadChangeRequest(appState: AppState, requestiD: String) async {
        isLoading = true
        customError = nil
        
        var param: [String : Any] = [:]
        param["driver_id"] = appState.useriD
        param["request_id"] = requestiD
        param["status"] = "Accept"
        
        print(param)
               
        do {
            let _ = try await Api.shared.reqToChangeRequest(params: param)
            self.isReqAccept = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadRejectedRequest(appState: AppState, reqiD: String) async {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        paramDict["request_id"] = reqiD
        
        print(paramDict)
                
        do {
            let _ = try await Api.shared.reqToRejectRequest(params: paramDict)
            self.isReqAccept = false
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadDriverStatus(appState: AppState, driverStatus: String, completion: @escaping (Bool) -> Void) async {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        paramDict["available_status"] = driverStatus
        
        print(paramDict)
                
        do {
            let _ = try await Api.shared.reqToUpdateDriverStatus(params: paramDict)
            completion(true)
        } catch {
            self.customError = .customError(message: error.localizedDescription)
            completion(false)
        }
        
        isLoading = false
    }
    
    func toggleDriverStatus(appState: AppState) async {
        let newStatus = !isOnline      // what user wants to change to
        let statusString = newStatus ? "Online" : "Offline"

        isLoading = true

        await loadDriverStatus(appState: appState, driverStatus: statusString) { success in
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
    
    func loadDriverProfileDetail(appState: AppState) async {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
                
        do {
            let res = try await Api.shared.requestToFetchProfile(params: paramDict)
            self.userProfile = res
            
            if res.available_status?.lowercased() == "online" {
                self.isOnline = true
            } else {
                self.isOnline = false
            }
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadDriverActiveReq(appState: AppState) async {
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        
        print(paramDict)
                
        do {
            let response = try await Api.shared.requestToDriverActiveRequest(params: paramDict)
            self.resActiveRequest = response
            self.isSuccessReq = true
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
}
