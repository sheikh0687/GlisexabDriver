//
//  OnbaordingView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI

struct OnboardingItem {
    let imageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    
    let onboardingData: [OnboardingItem] = [
        .init(imageName: "Slide1", title: "Drive on your own schedule", description: "Accept rides when you want and earn money with complete flexibility."),
        .init(imageName: "Slide2", title: "Your safety is our priority", description: "Track every trip in real-time, verified customers, and 24/7 support."),
        .init(imageName: "Slide3", title: "Earn more, grow more", description: "Get consistent ride requests, maximize your income, and build trust with customers.")
    ]
    
    @State private var currentPage = 0
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ZStack {
            // Background color
            LinearGradient (
                gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                
                Spacer()
                // Main content
                VStack(spacing: 40) {
                    Image(onboardingData[currentPage].imageName) // 3D car model
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .rotationEffect(.degrees(-5))
                        .padding(.top, 40)
                    
                    VStack(spacing: 16) {
                        Text(onboardingData[currentPage].title)
                            .font(.customfont(.semiBold, fontSize: 28))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text(onboardingData[currentPage].description)
                            .font(.customfont(.regular, fontSize: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
                
                Spacer()
                
                // Bottom controls
                VStack(spacing: 32) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(currentPage == 0 ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 12, height: 12)
                        
                        ForEach(1..<onboardingData.count, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.black : Color.gray.opacity(0.3))
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        // Skip button
                        Text("Skip")
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.gray)
                            .onTapGesture {
                                router.push(to: .login)
                            }
                        
                        Spacer()
                        
                        // Next button
                        Button {
                            if currentPage < onboardingData.count - 1 {
                                withAnimation(.spring()) {
                                    currentPage += 1
                                }
                            } else {
                                router.push(to: .login)
                            }
                        } label: {
                            HStack(spacing: 12) {
                                Text("Next")
                                    .font(.customfont(.semiBold, fontSize: 16))
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 60)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UINavigationBar.appearance().isHidden = true
        }
        .onDisappear {
            UINavigationBar.appearance().isHidden = false
        }
    }
}

#Preview {
    OnboardingView()
}
