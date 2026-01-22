//
//  Review.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 28/10/25.
//

import SwiftUI

struct ReviewView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var viewModel = RatingReviewViewModel()
    
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
                        
                        if viewModel.isLoading {
                            ProgressView("Loading Reviews")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else if viewModel.arrayOfReview.isEmpty {
                            Text("No reviews available.")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(viewModel.arrayOfReview, id: \.id) { review in
                                VStack(alignment: .leading,spacing: 10) {
                                    HStack(alignment: .center,spacing: 10) {
                                        // Avatar with proper sizing
                                        Group {
                                            let baseUrl = Router.BASE_IMAGE_URL
                                            let img = review.form_details?.image ?? ""
                                            
                                            if !img.contains(baseUrl) {
                                                let urlString = "\(baseUrl)\(img)"
                                                if !urlString.isEmpty {
                                                    Utility.CustomWebImage (
                                                        imageUrl: urlString,
                                                        placeholder: Image(systemName: "person.circle.fill"),
                                                        width: 36,
                                                        height: 36
                                                    )
                                                    .clipShape(Circle())
                                                } else {
                                                    Image(systemName: "person.circle.fill")
                                                        .font(.system(size: 36))
                                                        .foregroundColor(.gray)
                                                }
                                            } else {
                                                if !img.isEmpty {
                                                    Utility.CustomWebImage (
                                                        imageUrl: img,
                                                        placeholder: Image(systemName: "person.circle.fill"),
                                                        width: 36,
                                                        height: 36
                                                    )
                                                    .clipShape(Circle())
                                                } else {
                                                    Image(systemName: "person.circle.fill")
                                                        .font(.system(size: 36))
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }
                                        .frame(width: 36, height: 36)

                                        Text("By \(review.form_details?.first_name ?? "") \(review.form_details?.last_name ?? "")")
                                            .font(.customfont(.medium, fontSize: 14))
                                        Spacer()
                                        HStack(spacing: 4) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 16))
                                            
                                            Text(review.rating ?? "")
                                                .font(.customfont(.regular, fontSize: 14))
                                                .foregroundColor(.black)
                                        }
                                    }
                                    
                                    Text(review.feedback ?? "")
                                        .font(.customfont(.medium, fontSize: 14))
                                        .foregroundColor(.gray)
                                        .lineSpacing(2)
                                }
                                .padding(.vertical, 16)
                                
                                if review.id != viewModel.arrayOfReview.last!.id { // Divider between reviews
                                    Divider()
                                }
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
           Task {
               await viewModel.ratingReviewList(appState: appState)
            }
        }
    }
}

#Preview {
    ReviewView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
