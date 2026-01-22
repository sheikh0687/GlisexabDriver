//
//  RatingView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 13/12/25.
//

import SwiftUI

struct RatingView: View {

    @EnvironmentObject private var router: NavigationRouter
    @StateObject private var viewModel = RatingViewModel()

    var useriD: String
    var requestiD: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {

                // Driver image
                if let uiImage = viewModel.profileImg {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    Image("user1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                }
                
                // Name + avg rating
                HStack(spacing: 4) {
                    Text(viewModel.userProfile?.first_name ?? "")
                        .font(.customfont(.semiBold, fontSize: 18))

                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 16))

                    Text("\(viewModel.userProfile?.rating ?? "0")(\(viewModel.userProfile?.rating_review_count ?? "0"))")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.gray)
                }

                // Question
                Text("How was your trip with \(viewModel.userProfile?.first_name ?? "") \(viewModel.userProfile?.last_name ?? "") ?")
                    .font(.customfont(.semiBold, fontSize: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                // Selectable 5 stars
                HStack(spacing: 20) {
                    CosmosRatingView(rating: $viewModel.rating) { newRate in
                        viewModel.rating = newRate
                    }
                }

                // Comment box with placeholder
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $viewModel.comment)
                        .frame(height: 150)
                        .padding(8)
                        .overlay (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )

                    if viewModel.comment.isEmpty {
                        Text("Enter comment")
                            .foregroundColor(.gray)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                            .allowsHitTesting(false)
                    }
                } // common TextEditor placeholder pattern[web:53][web:56]

                // Submit button
                Button {
                    // call API / pop screen
                } label: {
                    Text("Submit Review")
                        .font(.customfont(.semiBold, fontSize: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.colorNeavyBlue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)

                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton { router.popToRoot() }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
           Task {
               await viewModel.loadUserProfileDetail(useriD: useriD)
            }
        }
        .onChange(of: viewModel.ratingAdded) { isSuccess in
            if isSuccess {
                router.popToRoot()
            }
        }
        .onChange(of: viewModel.customError) { error in
            viewModel.showErrorBanner = error != nil
        }
        .alert(isPresented: $viewModel.showErrorBanner) { 
            Alert (
                title: Text(Constant.AppName),
                message: Text(viewModel.customError?.localizedDescription ?? "Something went wrong!"),
                dismissButton: .default(Text("Ok")) {
                    withAnimation {
                        viewModel.customError = nil
                    }
                }
            )
        }
    }
}

#Preview {
    RatingView(useriD: "1", requestiD: "1")
        .environmentObject(NavigationRouter())
}
