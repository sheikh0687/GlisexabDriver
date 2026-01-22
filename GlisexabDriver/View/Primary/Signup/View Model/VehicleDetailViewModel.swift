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
    
    func webServiceCallForSignup(appState: AppState) async {
        
        print(paramSigupDetail)
        print(paramImageSignupDt)
        
        isLoading = true
        customError = nil
        isNewUser = false
        
//        Api.shared.requestToSignup(params: paramSigupDetail, imageParam: paramImageSignupDt) { [weak self] result in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                self.isLoading = false
//                
//                switch result {
//                case .success(let userResponse):
//                    self.user = userResponse
//                    print("✅ Login Success:", userResponse)
//                    
//                    if let useriD = userResponse.id  {
//                        appState.useriD = useriD
//                        appState.isLoggedIn = true
//                        appState.cardiD = userResponse.cust_id ?? ""
//                    }
//                    
//                case .failure(let error):
//                    self.customError = .customError(message: error.localizedDescription)
//                    print("❌ API Error:", error.localizedDescription)
//                }
//            }
//        }
        
        do {
            let response = try await Api.shared.requestToSignup(params: paramSigupDetail, imageParam: paramImageSignupDt)
            self.isNewUser = true
            
            print("✅ Login Success:", response)
            
            if let useriD = response.id  {
                appState.useriD = useriD
                appState.isLoggedIn = true
                appState.cardiD = response.cust_id ?? ""
            }
            
        } catch {
            self.customError = .customError(message: error.localizedDescription)
            print("❌ API Error:", error.localizedDescription)
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
