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
    case forgetPassword
    case otp(email: String)
    case vehicleDetail
    case driverDocument
    case home
    case trackRide
    case ridedetails
    case scheduleDetail
    case editProfile
    case myAccount
    case myReview
    case wallet
    case uploadDocument
    case bankDetail
    case history
    case earning
    case notification
    case contactUs
    case rating(useriD: String, requestiD: String)
    
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
            TrackingView()
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
        case .rating(let striD, let strReqiD):
            RatingView(useriD: striD, requestiD: strReqiD)
        case .forgetPassword:
            ForgetPasswordView()
        case .otp(let emailAddress):
            OtpView(email: emailAddress)
        case .wallet:
            WalletView()
        case .uploadDocument:
            UploadDocumentView()
        case .bankDetail:
            AddBankDetailsView()
        case .history:
            HistoryView()
        case .earning:
            EarningView()
        case .notification:
            NotificationView()
        case .contactUs:
            ContactUsView()
        }
    }
}
