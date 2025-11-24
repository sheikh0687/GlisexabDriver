//
//  SignupViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

internal import Combine
import SwiftUI

@MainActor
final class SignupViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var mobile: String = ""
    @Published var mobileCode: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var newUser: Res_LoginResponse?
    
    private let locationManager = LocationSearchViewModel()
    @Published var locationError: LocationError?
    
    @Published var address: String = ""
    @Published var city: String?
    @Published var state: String?
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    @Published var customError: CustomError? = nil
    
    @Published var profileImage: UIImage? = nil
    @Published var isCheck = false
    
    @Published var vehicleiD = ""
    @Published var vehicleName = ""
    @Published var registrationNumber = ""
    @Published var licenseNumber = ""
    @Published var vehicleImage: UIImage? = nil
    @Published var registrationImage: UIImage? = nil
    @Published var licenseImage: UIImage? = nil
    
    @Published var vehicleList: [Res_VehicleList] = []
    
    @Published var user: Res_LoginResponse?
    
    func requestForLocationServices() {
        locationManager.getLocation { result in
            switch result {
            case .success(let location):
                self.locationError = nil
                self.address = location.address ?? ""
                self.city = location.city ?? ""
                self.state = location.state ?? ""
                self.latitude = location.latitude ?? 0.0
                self.longitude = location.longitude ?? 0.0
            case .failure(let error):
                //                Console.log("Error: \(error.userMessage)")
                self.locationError = error
            }
        }
    }
    
    func fetchVehicleList(appState: AppState) {
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
        
        Api.shared.requestToFetchVehicle(params: paramDict) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let res):
                    self.vehicleList = res
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func webServiceCallForSignup(appState: AppState) {
        
        print(paramSigupDetail)
        print(paramImageSignupDt)
        
        isLoading = true
        customError = nil
        
        Api.shared.requestToSignup(params: paramSigupDetail, imageParam: paramImageSignupDt) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let userResponse):
                    self.user = userResponse
                    print("✅ Login Success:", userResponse)
                    
                    if let useriD = userResponse.id  {
                        appState.useriD = useriD
                        appState.isLoggedIn = true
                        appState.cardiD = userResponse.cust_id ?? ""
                    }
                    
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                    print("❌ API Error:", error.localizedDescription)
                }
            }
        }
    }
}

// MARK: DRIVER PERSONAL DETAILS
extension SignupViewModel {
    
    func paramDictionary() {
        paramSigupDetail["first_name"] = firstName
        paramSigupDetail["last_name"] = lastName
        paramSigupDetail["mobile"] = mobile
        paramSigupDetail["mobile_witth_country_code"] = "\(mobileCode)\(mobile)"
        paramSigupDetail["email"] = email
        paramSigupDetail["address"] = address
        paramSigupDetail["register_id"] = ""
        paramSigupDetail["ios_register_id"] = ""
        paramSigupDetail["type"] = "DRIVER"
        paramSigupDetail["lat"] = String(latitude ?? 0.0)
        paramSigupDetail["lon"] = String(longitude ?? 0.0)
    }
    
    func paramImageDictionary() {
        paramImageSignupDt["image"] = profileImage
    }
    
    func validateFields() -> Bool {
        if firstName.isEmpty {
            customError = .customError(message: "Please enter your first name.")
            return false
        } else if lastName.isEmpty {
            customError = .customError(message: "Please enter your last name.")
            return false
        } else if email.isEmpty {
            customError = .customError(message: "Please enter your valid email address.")
            return false
        } else if mobile.isEmpty {
            customError = .customError(message: "Please enter your mobile number.")
            return false
        } else if address.isEmpty {
            customError = .customError(message: "Please select your address.")
            return false
        } else if password.isEmpty {
            customError = .customError(message: "Please enter the password.")
            return false
        } else if confirmPassword.isEmpty {
            customError = .customError(message: "Please confirm the password.")
            return false
        } else if password != confirmPassword {
            customError = .customError(message: "Password mismatch. Please enter the same password.")
            return false
        } else if isCheck == false {
            customError = .customError(message: "Please read the terms and conditions.")
            return false
        } else if profileImage == nil {
            customError = .customError(message: "Please select your profile image.")
            return false
        }
        return true
    }
}

// MARK: DRIVER VEHICLE DETAILS
extension SignupViewModel {
    
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
