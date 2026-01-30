//
//  VehicleDetailViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 12/01/26.
//

import SwiftUI
internal import Combine

@MainActor
final class VehicleDetailViewModel: ObservableObject {
    
    @Published var vehicleiD = ""
    @Published var vehicleName = ""
    @Published var registrationNumber = ""
    @Published var licenseNumber = ""
    @Published var vehicleImage: UIImage? = nil
    @Published var registrationImage: UIImage? = nil
    @Published var licenseImage: UIImage? = nil
    
    @Published var vehicleList: [Res_VehicleList] = []

    @Published var customError: CustomError? = nil
    @Published var isLoading: Bool = false
    
    @Published var isNewUser: Bool = false
    
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

// MARK: DRIVER VEHICLE DETAILS
extension VehicleDetailViewModel {
    
    func paramVehicleDictionary() {
        paramSigupDetail["vehicle_id"] = vehicleiD
        paramSigupDetail["vehicle_name"] = vehicleName
        paramSigupDetail["registration_no"] = registrationNumber
        paramSigupDetail["licence_number"] = licenseNumber
    }
    
    func paramVehicleImageDictionary() {
        paramImageSignupDt["vehicle_image"] = vehicleImage
        paramImageSignupDt["registration_image"] = registrationImage
        paramImageSignupDt["licence_image"] = registrationImage
    }
    
    func validateVehicleFields() -> Bool {
        if vehicleiD.isEmpty {
            customError = .customError(message: "Please select the vehicle type.")
            return false
        } else if registrationNumber.isEmpty {
            customError = .customError(message: "Please enter register number.")
            return false
        } else if licenseNumber.isEmpty {
            customError = .customError(message: "Please enter license number.")
            return false
        } else if vehicleImage == nil {
            customError = .customError(message: "Please select your vehicle image.")
            return false
        } else if registrationImage == nil {
            customError = .customError(message: "Please select your vehicle registration image.")
            return false
        } else if licenseImage == nil {
            customError = .customError(message: "Please select your vehicle license image.")
            return false
        }
        return true
    }
}
