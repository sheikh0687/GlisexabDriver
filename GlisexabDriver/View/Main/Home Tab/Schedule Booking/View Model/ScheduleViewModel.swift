//
//  ScheduleViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 29/01/26.
//

import SwiftUI
internal import Combine

final class ScheduleViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError?
    @Published var arrayScheduleRide: [Res_ScheduleList] = []
    
    @MainActor
    func webGetScheduleRide(appState: AppState, strPending: String) async {
        isLoading = true
        customError = nil
        defer { isLoading = false }
        
        var paramDict: [String : Any] = [:]
        paramDict["driver_id"] = appState.useriD
        paramDict["status"] = strPending
        paramDict["timezone"] = localTimeZoneIdentifier
        
        print(paramDict)
        
        do {
            let response = try await Api.shared.requestToScheduleRide(params: paramDict)
            self.arrayScheduleRide = response
        } catch {
            self.arrayScheduleRide.removeAll()
            self.customError = .customError(message: error.localizedDescription)
        }
    }
}
