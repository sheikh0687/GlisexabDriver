//
//  Api.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import Foundation
import Alamofire
import UIKit

final class Api {
    static let shared = Api()
    
    private init() {}
    
    func requestToLogin(params: [String: Any], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
        Service.shared.request(
            url: Router.login.url(),
            method: .get,
            params: params,
            responseType: Api_LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Login failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToSignup(params: [String: String],imageParam: [String : UIImage], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
        Service.shared.uploadSingleMedia(
            url: Router.signup.url(),
            params: params,
            images: imageParam,
            videos: [:],
            responseType: Api_LoginResponse.self
        ) { result in
            switch result {
            case .success(let data):
                if data.status == "1", let data = data.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(data.message ?? "Update Profile failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToFetchVehicle(params: [String: Any], completion: @escaping (Result<[Res_VehicleList], ApiError>) -> Void) {
        Service.shared.request (
            url: Router.vehicle_list.url(),
            method: .get,
            params: params,
            responseType: Api_Vehiclelist.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToDriverPendingReq(params: [String: Any], completion: @escaping (Result<[Res_PendingRequest], ApiError>) -> Void) {
        Service.shared.request (
            url: Router.get_driver_pending_request.url(),
            method: .get,
            params: params,
            responseType: Api_PendingRequest.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    //
    //    func requestToForgetPassword(params: [String: Any], completion: @escaping (Result<Api_Basic, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.forgot_password.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_Basic.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.result != nil {
    //                    completion(.success(response))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToFetchProfile(params: [String: Any], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.get_profile.url(),
    //            method: .get,
    //            params: params,
    //            responseType: LoginResponse.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToFetchVehicle(params: [String: Any], completion: @escaping (Result<[Res_VehicleList], ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.vehicle_list_with_calculation.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_VehicleList.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToFetchSaveCard(params: [String: Any], completion: @escaping (Result<Res_CardList, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.save_card_list.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_CardList.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToUpdateProfile(params: [String: String],imageParam: [String : UIImage], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
    //        Service.shared.uploadSingleMedia(
    //            url: Router.user_update_profile.url(),
    //            params: params,
    //            images: imageParam,
    //            videos: [:],
    //            responseType: LoginResponse.self
    //        ) { result in
    //            switch result {
    //            case .success(let data):
    //                if data.status == "1", let data = data.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(data.message ?? "Update Profile failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToChangePassword(params: [String: Any], completion: @escaping (Result<Api_Basic, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.change_password.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_Basic.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.result != nil {
    //                    completion(.success(response))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToSaveAddressList(params: [String: Any], completion: @escaping (Result<[Res_InfoAddress], ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.get_user_address.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_InfoAddress.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToAddAddress(params: [String: Any], completion: @escaping (Result<Res_AddAddress, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.add_user_address.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_AddAddress.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToDeleteAddress(params: [String: Any], completion: @escaping (Result<Api_Basic, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.delete_user_address.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_Basic.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.result != nil {
    //                    completion(.success(response))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToChatList(params: [String: Any], completion: @escaping (Result<[Res_InfoAddress], ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.get_user_address.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_InfoAddress.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToAddNewRequest(params: [String: Any], completion: @escaping (Result<Res_AddNewRequest, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.request_nearbuy_driver.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_AddNewRequest.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    //
    //    func requestToUserActiveReq(params: [String: Any], completion: @escaping (Result<Res_UserActiveRequest, ApiError>) -> Void) {
    //        Service.shared.request (
    //            url: Router.get_user_active_request.url(),
    //            method: .get,
    //            params: params,
    //            responseType: Api_UserActiveRequest.self
    //        ) { result in
    //            switch result {
    //            case .success(let response):
    //                if response.status == "1", let data = response.result {
    //                    completion(.success(data))
    //                } else {
    //                    completion(.failure(.serverError(response.message ?? "")))
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
}
