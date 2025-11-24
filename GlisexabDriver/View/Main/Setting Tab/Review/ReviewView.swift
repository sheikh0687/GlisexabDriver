//
//  Review.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 28/10/25.
//

import SwiftUI

struct Review: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let comment: String
    let imageName: String // Your local asset name
}

struct ReviewView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    
    let reviews: [Review] = [
        Review(name: "Rahul S.", rating: 4.9, comment: "Very polite and professional driver. Car was clean and ride was smooth. Reached on time. Highly recommended!", imageName: "user1"),
        Review(name: "Arya.T", rating: 5.0, comment: "Good experience overall. Driver was friendly and knew the best route. Just a little late for pickup but managed well.", imageName: "user2"),
        Review(name: "Jolly.R", rating: 5.0, comment: "Excellent service! Felt safe throughout the ride. Driver followed traffic rules and kept good communication.", imageName: "user3"),
        Review(name: "Aditya. Y", rating: 5.0, comment: "Reached destination on time. Driver helped with luggage and was very courteous. Would book again.", imageName: "userPlace")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("5.0")
                            .font(.customfont(.semiBold, fontSize: 24))
                        HStack {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .font(.custom("HelveticaNeue-Light", size: 36))
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding()
                    
                    VStack(spacing: 0) {
                        ForEach(reviews) { review in
                            VStack(alignment: .leading,spacing: 10) {
                                HStack(alignment: .center,spacing: 10) {
                                    Image(review.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 36, height: 36)
                                        .clipShape(Circle())
                                    Text(review.name)
                                        .font(.customfont(.medium, fontSize: 14))
                                    Spacer()
                                    HStack(spacing: 4) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 16))
                                        Text(String(format: "%.1f", review.rating))
                                            .font(.customfont(.regular, fontSize: 14))
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                Text(review.comment)
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.gray)
                                    .lineSpacing(2)
                            }
                            .padding(.vertical, 16)
                            
                            if review.id != reviews.last!.id { // Divider between reviews
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding([.horizontal, .bottom], 16)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
}

#Preview {
    ReviewView()
}
