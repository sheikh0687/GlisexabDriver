//
//  DocumentViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 17/01/26.
//

import SwiftUI
internal import Combine

@MainActor
final class DocumentViewModel: ObservableObject {
    
    @Published var vehicleList: [Res_VehicleList] = []

    @Published var customError: CustomError? = nil
    @Published var isLoading: Bool = false
    @Published var vehicleiD = ""
    @Published var vehicleName = ""
    
    func fetchVehicleList(appState: AppState) async {
        
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
        
        do {
            let res = try await Api.shared.requestToFetchVehicle(params: paramDict)
            self.vehicleList = res
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
}
