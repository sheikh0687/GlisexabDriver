//
//  RootView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/10/25.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $router.path) {
                if appState.isLoggedIn {
                    HomeView()
                        .navigationDestination(for: AppNavigationView.self) { destination in
                            destination.view // This is your enum’s view property
                        }
                } else {
                    OnboardingView()
                        .navigationDestination(for: AppNavigationView.self) { destination in
                            destination.view // This is your enum’s view property
                        }
                }
            }
            .onAppear {
                router.path.removeAll()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
