//
//  AppNavigationView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/10/25.
//

import SwiftUI

enum AppNavigationView: Hashable {
    
    case login
    case signup
    case vehicleDetail
    case driverDocument
    case home
    case trackRide
    case ridedetails
    case scheduleDetail
    case editProfile
    case myAccount
    case myReview
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .login:
            LoginView()
        case .signup:
            SignupView()
        case .home:
            HomeView()
        case .trackRide:
            TrackingView(showingPopup: .constant(false))
        case .vehicleDetail:
            VehcileDetailSignupView()
        case .driverDocument:
            DriverDocView()
        case .ridedetails:
            RideDetailView()
        case .scheduleDetail:
            ScheduleBookingView()
        case .editProfile:
            EditProfileView()
        case .myAccount:
            MyAccountView()
        case .myReview:
            ReviewView()
        }
    }
}
