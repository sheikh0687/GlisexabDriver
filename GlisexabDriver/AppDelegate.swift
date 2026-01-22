//
//  AppDelegate.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import Foundation
import IQKeyboardManagerSwift
import UIKit
import _LocationEssentials
//import Firebase

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate /*MessagingDelegate*/ {
    
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    var appState = AppState()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.isEnabled = true
//        FirebaseApp.configure()
//        
//        UNUserNotificationCenter.current().delegate = self
//        Messaging.messaging().delegate = self
//        
//        requestNotificationPermission(application)
        return true
    }
    
//    private func requestNotificationPermission(_ application: UIApplication) {
//        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, _ in
//            if granted {
//                DispatchQueue.main.async {
//                    application.registerForRemoteNotifications()
//                }
//            }
//        }
//    }
    
    // MARK: FCM TOKEN
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("FCM Token:", fcmToken ?? "")
//        appState.ios_RegisterediD = fcmToken ?? ""
//    }
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//    
//    func userNotificationCenter (
//        _ center: UNUserNotificationCenter,
//        willPresent notification: UNNotification,
//        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//    ) {
//        completionHandler([.banner, .list, .badge, .sound])
//    }
//    
//    func userNotificationCenter (
//        _ center: UNUserNotificationCenter,
//        didReceive response: UNNotificationResponse,
//        withCompletionHandler completionHandler: @escaping () -> Void
//    ) {
//        let userInfo = response.notification.request.content.userInfo
//        print(userInfo)
//        completionHandler()
//    }
//}

extension AppDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}
