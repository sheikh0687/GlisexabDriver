//
//  CustomError.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/11/25.
//

import Foundation

enum CustomError: LocalizedError, Equatable {
    
    case customError(message: String)
    case networkError
    case validationError(message: String)
    case authenticationFailed

    var errorDescription: String? {
        switch self {
        case .customError(let message), .validationError(let message):
            return message
        case .networkError:
            return "Network error. Please check your connection."
        case .authenticationFailed:
            return "Authentication failed. Please check your credentials."
        }
    }
}
