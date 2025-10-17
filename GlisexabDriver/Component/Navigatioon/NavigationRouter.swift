//
//  NavigationRouter.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/10/25.
//

import SwiftUI
internal import Combine

final class NavigationRouter: ObservableObject {
    
    @Published var path: [AppNavigationView] = []
    @Published var isLoggedIn: Bool = false
    
    func popToRoot() {
        path.removeAll()
    }
    
    func popView() {
        if path.isEmpty { return }
        path.removeLast()
    }
    
    func push(to view: AppNavigationView) {
        path.append(view)
    }
    
    func setRoot(to view: AppNavigationView) {
        path.removeAll()
        path.append(view)
    }
    
    func logIn() {
        isLoggedIn = true
        path = [.home] // Reset path to home on login
    }

    func logOut() {
        isLoggedIn = false
        path.removeAll() // Clear navigation path on logout
        path.append(.login) // Show login screen
    }
}
