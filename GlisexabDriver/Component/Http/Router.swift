//
//  Router.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/glisexab/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/glisexab/uploads/images/"
    
    case login
    case forgot_password
    case signup
    
    case get_profile
    case vehicle_list_with_calculation
    case save_card_list
    case get_user_address
    case get_user_active_request
    case vehicle_list
    
    case user_update_profile
    case change_password
    case add_user_address
    case request_nearbuy_driver
    case update_driver_status
    
    case get_conversation_detail
    case get_driver_pending_request
    
    case change_request_status
    
    case delete_user_address
    case add_rejected_request
    
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
        case .vehicle_list_with_calculation:
            return Router.oAuthRoute(path: "vehicle_list_with_calculation")
        case .save_card_list:
            return Router.oAuthRoute(path: "save_card_list")
        case .user_update_profile:
            return Router.oAuthRoute(path: "user_update_profile")
        case .change_password:
            return Router.oAuthRoute(path: "change_password")
        case .get_user_address:
            return Router.oAuthRoute(path: "get_user_address")
        case .add_user_address:
            return Router.oAuthRoute(path: "add_user_address")
        case .delete_user_address:
            return Router.oAuthRoute(path: "delete_user_address")
        case .get_conversation_detail:
            return Router.oAuthRoute(path: "get_conversation_detail")
        case .request_nearbuy_driver:
            return Router.oAuthRoute(path: "request_nearbuy_driver")
        case .get_user_active_request:
            return Router.oAuthRoute(path: "get_user_active_request")
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
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
