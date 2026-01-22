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
    @Published var isPaswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false 
    
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
}

// MARK: DRIVER PERSONAL DETAILS
extension SignupViewModel {
    
    func paramDictionary() {
        paramSigupDetail["first_name"] = firstName
        paramSigupDetail["last_name"] = lastName
        paramSigupDetail["mobile"] = mobile
        paramSigupDetail["mobile_witth_country_code"] = "\(mobileCode)\(mobile)"
        paramSigupDetail["password"] = password
        paramSigupDetail["email"] = email
        paramSigupDetail["address"] = address
        paramSigupDetail["register_id"] = ""
        paramSigupDetail["ios_register_id"] = ""
        paramSigupDetail["type"] = "DRIVER"
        paramSigupDetail["vehicle_work_type"] = ""
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

