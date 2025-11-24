//
//  CustomAlertView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/11/25.
//

import SwiftUI
internal import Combine

class AlertManager: ObservableObject {
    static let shared = AlertManager() // Singleton instance

    @Published var isPresented: Bool = false // Tracks whether the alert is shown
    @Published var title: String = "" // Alert title
    @Published var message: String = "" // Alert message
    @Published var primaryButtonText: String = "OK" // Primary button text
    @Published var secondaryButtonText: String? = nil // Optional secondary button text
    var primaryAction: (() -> Void)? = nil // Optional action for the primary button
    var secondaryAction: (() -> Void)? = nil // Optional action for the secondary button

    private init() {} // Prevent external initialization

    func showAlert(
        title: String,
        message: String,
        primaryButtonText: String = "OK",
        primaryAction: (() -> Void)? = nil,
        secondaryButtonText: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryButtonText = primaryButtonText
        self.primaryAction = primaryAction
        self.secondaryButtonText = secondaryButtonText
        self.secondaryAction = secondaryAction
        self.isPresented = true
    }
}

