//
//  GlisexabDriverApp.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

@main
struct GlisexabDriverApp: App {
    
    @StateObject private var router = NavigationRouter()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(appState)
        }
    }
}
