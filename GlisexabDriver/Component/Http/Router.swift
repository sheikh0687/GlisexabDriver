//
//  Router.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/glidecab/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/glidecab/uploads/images/"
    
    case login
    case forgot_password
    case signup
    case verify_number
    
    case get_profile
    case vehicle_list
    case get_driver_pending_request
    case get_driver_active_request
    case final_fare_calculation
    case give_rating_to_user
    case get_request_details
    case driver_update_profile
    
    case change_request_status
    case update_driver_status
    case get_rating_review
    case driver_update_bank_details
    
    case add_rejected_request
    case get_user_request
    case get_driver_complete_request
    case get_driver_schedule_request
    case get_notification_list
    
    public func url() -> String {
        switch self {
        case .login:
            return Router.oAuthRoute(path: "login")
        case .signup:
            return Router.oAuthRoute(path: "signup")
        case .forgot_password:
            return Router.oAuthRoute(path: "forgot_password")
        case .get_profile:
            return Router.oAuthRoute(path: "get_profile")
        
        case .vehicle_list:
            return Router.oAuthRoute(path: "vehicle_list")
            
        case .get_driver_pending_request:
            return Router.oAuthRoute(path: "get_driver_pending_request")
        case .change_request_status:
            return Router.oAuthRoute(path: "change_request_status")
        case .add_rejected_request:
            return Router.oAuthRoute(path: "add_rejected_request")
        case .update_driver_status:
            return Router.oAuthRoute(path: "update_driver_status")
        case .get_driver_active_request:
            return Router.oAuthRoute(path: "get_driver_active_request")
            
        case .final_fare_calculation:
            return Router.oAuthRoute(path: "final_fare_calculation")
            
        case .give_rating_to_user:
            return Router.oAuthRoute(path: "give_rating_to_user")
        case .get_request_details:
            return Router.oAuthRoute(path: "get_request_details")
            
        case .driver_update_profile:
            return Router.oAuthRoute(path: "driver_update_profile")
        case .verify_number:
            return Router.oAuthRoute(path: "verify_number")
            
        case .get_rating_review:
            return Router.oAuthRoute(path: "get_rating_review")
            
        case .driver_update_bank_details:
            return Router.oAuthRoute(path: "driver_update_bank_details")
            
        case .get_user_request:
            return Router.oAuthRoute(path: "get_user_request")
            
        case .get_driver_complete_request:
            return Router.oAuthRoute(path: "get_driver_complete_request")
            
        case .get_driver_schedule_request:
            return Router.oAuthRoute(path: "get_driver_schedule_request")
            
        case .get_notification_list:
            return Router.oAuthRoute(path: "get_notification_list")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
