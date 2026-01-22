//
//  TrackingViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 12/12/25.
//

import Foundation
import SwiftUI
internal import Combine
internal import MapKit

class TrackingViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showingPopup: Bool = false
    @Published var isSuccess: Bool = false
    @Published var isFinished: Bool = false
    
    @Published var customError: CustomError?
    @Published var resActiveReq: Res_ActiveDriverRequest?
    @Published var locationManager = LocationManager()
    
    @Published var strDriverStatus: String = ""
    @Published var strPaymentStatus: String = ""
    @Published var showErrorBanner: Bool = false
    
    @Published var elapsedTime: TimeInterval = 0
    @Published var freeTime: TimeInterval = 0
    @Published var noShowFeeTime: TimeInterval = 0
    @Published var showWaitingCharge: Bool = false
    @Published var router: NavigationRouter?
    
    var arrivalTimer: Timer?
    
    func loadDriverActiveReq(appState: AppState) async {
        isLoading = true
        customError = nil
        isSuccess = false
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        
        print(paramDict)
                
        do {
            let response = try await Api.shared.requestToDriverActiveRequest(params: paramDict)
            self.isSuccess = true
            self.resActiveReq = response
            self.strDriverStatus = response.status ?? ""
            self.strPaymentStatus = response.payment_status ?? ""
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadChangeRequest(appState: AppState, strStatus: String) async {
        
        isLoading = true
        customError = nil
        isFinished = false
        
        var param: [String : Any] = [:]
        param["driver_id"] = appState.useriD
        param["request_id"] = resActiveReq?.id ?? ""
        param["status"] = strStatus
        param["lat"] = locationManager.region.center.latitude
        param["lon"] = locationManager.region.center.longitude
        
        print(param)
            
        do {
            let res = try await Api.shared.reqToChangeRequest(params: param)
            print(res.status ?? "")
            if res.status != "Finish" {
               Task {
                   await self.loadDriverActiveReq(appState: appState)
                }
            }
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func startArrivalTimer(totalElapsedTime: TimeInterval,
                           freeTime: TimeInterval,
                           noShowFeeTime: TimeInterval) {
        
        arrivalTimer?.invalidate()
        arrivalTimer = nil
        
        elapsedTime = totalElapsedTime
        self.freeTime = freeTime
        self.noShowFeeTime = max(noShowFeeTime, 1)
        showWaitingCharge = elapsedTime > freeTime
        
        print("⏱ START TIMER")
        print("Elapsed: \(elapsedTime), FreeTime: \(freeTime), NoShow: \(noShowFeeTime)")
        
        
        arrivalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            self.elapsedTime += 1
            print("Tick -> elapsed = \(self.elapsedTime)")
            
            if self.elapsedTime > self.freeTime {
                self.showWaitingCharge = true
            }
        }
        
        RunLoop.main.add(arrivalTimer!, forMode: .common)
    }
    
    func stopArrivalTimer() {
        // just reset arrival-related state
        arrivalTimer?.invalidate()
        arrivalTimer = nil
        elapsedTime = 0
        freeTime = 0
        noShowFeeTime = 1
        showWaitingCharge = false
    }
    
    var arrivalProgress: Double {
        min(elapsedTime / noShowFeeTime, 1.0)
    }
    
    var formattedArrivalTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateWaitingChargeWhenStart() {
        showWaitingCharge = false
        guard let obj = resActiveReq else { return }
        
        let freeMinutes = Int(obj.timer_free_minute ?? "") ?? 0
        let totalSeconds = freeMinutes * 60
        
        showWaitingCharge = totalSeconds > 300
    }
}
