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
            Color.colorNeavyBlue
                .ignoresSafeArea()
            
            // TabView with white rounded background on each page
            TabView(selection: $currentPage) {
                ForEach(onboardingData.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        
                        Image(onboardingData[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: .screenWidth * 0.85)
                            .padding(.top, 20)
                        
                        Text(onboardingData[index].title)
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40)
                        
                        Text(onboardingData[index].description)
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                        
                        Spacer()
                        
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                HStack {
                    // Page Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<onboardingData.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.colorNeavyBlue : Color.gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 24)
                    
                    Spacer()
                    
                    // Next Button Overlay
                    ZStack {
                        // Blue arc cut effect
                        Circle()
                            .fill(Color.colorNeavyBlue)
                            .frame(width: 120, height: 120) // slightly bigger for effect
                            .offset(x: 30) // pushes half outside
                            .overlay {
                                Button {
                                    withAnimation {
                                        if currentPage < onboardingData.count - 1 {
                                            currentPage += 1
                                        } else {
                                            router.push(to: .login)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(width: 100, height: 100)
                                }
                            }
                    }
                    .padding(.trailing, -20) // aligns with edge
                    .padding(.bottom, 60)
                }
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
