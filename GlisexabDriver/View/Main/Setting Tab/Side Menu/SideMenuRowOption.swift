//
//  SideMenuRowOption.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 27/10/25.
//

import Foundation

enum SideMenuRowOption: Int, CaseIterable {
    case home
    case myAccount
    case myReview
    case wallet
    case history
    case earning
    case inviteFriend
    case privacyPolicy
    case support
    case logout
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .myAccount:
            return "My Account"
        case .myReview:
            return "My Review"
        case .wallet:
            return "Wallet"
        case .history:
            return "History"
        case .earning:
            return "Earning"
        case .inviteFriend:
            return "Invite Friend"
        case .privacyPolicy:
            return "Privacy Policy"
        case .support:
            return "Support"
        case .logout:
            return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "home"
        case .myAccount:
            return "myAccount"
        case .myReview:
            return "review"
        case .wallet:
            return "wallet"
        case .history:
            return "history"
        case .earning:
            return "wallet"
        case .inviteFriend:
            return "invite"
        case .privacyPolicy:
            return "privacyPolicy"
        case .support:
            return "support"
        case .logout:
            return "logout"
        }
    }
}

extension SideMenuRowOption: Identifiable {
    var id: Int { return self.rawValue }
}
