//
//  NotificationViewModel.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 18/01/26.
//

import SwiftUI
internal import Combine

@MainActor
final class NotificationViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError?
    @Published var arrayNotificationList: [Res_NotificationList] = []
    
    func fetchNotificationList(appState: AppState) async {
        isLoading = true
        customError = nil
    
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["type"] = "DRIVER"
        
        print(paramDict)
        
        do {
            let response = try await Api.shared.requestToNotificationList(params: paramDict)
            self.arrayNotificationList = response
        } catch {
            self.customError = .customError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
}
