//
//  Api.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Common API Response Protocol
protocol HasApiMessage {
    var message: String? { get }
    var status: String? { get }
}

final class Api {
    static let shared = Api()
    
    private init() {}
    
    private func handleApiResponse<T: Decodable & HasApiMessage> (
        _ response: T,
        successCondition: (T) -> Bool,
        extractData: (T) -> Any?,
        defaultMessage: String
    ) throws -> Any {
        if successCondition(response), let data = extractData(response) {
            return data
        }
        
        throw ApiError.serverError(response.message ?? defaultMessage)
    }
    
    func requestToLogin(params: [String: Any]) async throws -> Res_LoginResponse {
        
        let response: Api_LoginResponse = try await Service.shared.request(
            url: Router.login.url(),
            method: .get,
            params: params,
        )
        
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_LoginResponse
    }
    
    func requestToSignup(params: [String: String], imageParam: [String : UIImage]) async throws -> Res_LoginResponse {
        let response: Api_LoginResponse = try await Service.shared.uploadSingleMedia (
            url: Router.signup.url(),
            params: params,
            images: paramImageSignupDt
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1"},
                                     extractData: { $0.result },
                                     defaultMessage: "Signup Failed") as! Res_LoginResponse
    }
    
    func requestToFetchVehicle(params: [String: Any]) async throws -> [Res_VehicleList] {
        
        let response: Api_Vehiclelist = try await Service.shared.request (
            url: Router.vehicle_list.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1"},
                                     extractData: { $0.result },
                                     defaultMessage: "Failed Vehicle List") as! [Res_VehicleList]
    }
    
    func requestToDriverPendingReq(params: [String: Any]) async throws -> [Res_PendingRequest] {
        
        let response: Api_PendingRequest = try await Service.shared.request (
            url: Router.get_driver_pending_request.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: {$0.status == "1"},
                                     extractData: { $0.result },
                                     defaultMessage: "Failed") as! [Res_PendingRequest]
    }
    
    func reqToChangeRequest(params: [String: Any]) async throws -> Res_ChangeRequest {
        
        let response: Api_ChangeRequest = try await Service.shared.request(
            url: Router.change_request_status.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: {$0.status == "1"},
                                     extractData: {$0.result},
                                     defaultMessage: "Something went worng") as! Res_ChangeRequest
    }
    
    func reqToRejectRequest(params: [String: Any]) async throws -> Res_RejectRequest {
        
        let response: Api_RejectRequest = try await Service.shared.request(
            url: Router.add_rejected_request.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: {$0.status == "1"},
                                     extractData: {$0.result},
                                     defaultMessage: "Something went wrong") as! Res_RejectRequest
    }
    
    func reqToUpdateDriverStatus(params: [String: Any]) async throws -> Api_DriverStatus {
        
        let response: Api_DriverStatus = try await Service.shared.request(
            url: Router.update_driver_status.url(),
            method: .get,
            params: params
        )
        guard response.result != nil else {
            throw ApiError.serverError(response.message ?? "Something went wrong")
        }
        return response
    }
    
    func requestToFetchProfile(params: [String: Any]) async throws -> Res_LoginResponse {
        
        let response: Api_LoginResponse = try await Service.shared.request(
            url: Router.get_profile.url(),
            method: .get,
            params: params,
        )
        
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_LoginResponse
    }
    
    func requestToDriverActiveRequest(params: [String: Any]) async throws -> Res_ActiveDriverRequest {
        
        let response: Api_ActiveDriverRequest = try await Service.shared.request(
            url: Router.get_driver_active_request.url(),
            method: .get,
            params: params,
        )
        
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_ActiveDriverRequest
        
    }
    
    func requestToFinalFareCalculation(params: [String: Any]) async throws -> Api_FinalFareCalculation {
        
        let response: Api_FinalFareCalculation = try await Service.shared.request(
            url: Router.final_fare_calculation.url(),
            method: .get,
            params: params,
        )
        
        guard response.result != nil else {
            throw ApiError.serverError(response.message ?? "Something went wrong")
        }
        return response
    }
    
    func requestToAddUserRating(params: [String: Any]) async throws -> Res_UserRating {
        
        let response: Api_UserRating = try await Service.shared.request(
            url: Router.give_rating_to_user.url(),
            method: .get,
            params: params,
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_UserRating
    }
    
    func requestToRideDetails(params: [String: Any]) async throws -> Res_RideDetail {
        
        let response: Api_RideDetails = try await Service.shared.request(
            url: Router.get_request_details.url(),
            method: .get,
            params: params,
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_RideDetail
        
    }
    
    func requestToUpdateProfile(params: [String: String],imageParam: [String : UIImage]) async throws -> Res_LoginResponse {
        
        let response: Api_LoginResponse = try await Service.shared.uploadSingleMedia(
            url: Router.driver_update_profile.url(),
            params: params,
            images: imageParam,
            videos: [:]
        )
        
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_LoginResponse
        
    }
    
    func requestToVerifyMobileNumber(params: [String: Any]) async throws -> Res_VerifyNumber {
        
        let response: Api_VerifyNumber = try await Service.shared.request(
            url: Router.verify_number.url(),
            method: .get,
            params: params,
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_VerifyNumber
    }
    
    func requestToReviewList(params: [String: Any]) async throws -> [Res_ReviewList] {
        
        let response: Api_ReviewList = try await Service.shared.request(
            url: Router.get_rating_review.url(),
            method: .get,
            params: params,
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! [Res_ReviewList]
    }
    
    
    func requestToAddBankDetail(params: [String : Any]) async throws -> Res_LoginResponse {
        let response: Api_LoginResponse = try await Service.shared.request(
            url: Router.driver_update_bank_details.url(),
            method: .get,
            params: params,
        )
        
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "Login failed") as! Res_LoginResponse
    }
    
    func requestToHistoryList(params: [String: Any]) async throws -> [Res_HistoryList] {
        let response: Api_HistoryList = try await Service.shared.request(
            url: Router.get_driver_complete_request.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "History fetch failed") as! [Res_HistoryList]
    }
    
    func requestToScheduleList(params: [String: Any]) async throws -> [Res_HistoryList] {
        let response: Api_HistoryList = try await Service.shared.request(
            url: Router.get_driver_schedule_request.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "History fetch failed") as! [Res_HistoryList]
    }
    
    func requestToNotificationList(params: [String: Any]) async throws -> [Res_NotificationList] {
        let response: Api_NotificationList = try await Service.shared.request (
            url: Router.get_notification_list.url(),
            method: .get,
            params: params
        )
        return try handleApiResponse(response,
                                     successCondition: { $0.status == "1" },
                                     extractData: { $0.result },
                                     defaultMessage: "History fetch failed") as! [Res_NotificationList]
    }
}

extension Api_LoginResponse: HasApiMessage {}
extension Api_Vehiclelist: HasApiMessage {}
extension Api_PendingRequest: HasApiMessage {}
extension Api_ChangeRequest: HasApiMessage {}
extension Api_RejectRequest: HasApiMessage {}
extension Api_ActiveDriverRequest: HasApiMessage {}
extension Api_UserRating: HasApiMessage {}
extension Api_RideDetails: HasApiMessage {}
extension Api_VerifyNumber: HasApiMessage {}
extension Api_ReviewList: HasApiMessage {}
extension Api_HistoryList: HasApiMessage {}
extension Api_NotificationList: HasApiMessage {}
