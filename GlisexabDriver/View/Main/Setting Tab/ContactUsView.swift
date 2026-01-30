//
//  ContactUsView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 28/01/26.
//

import SwiftUI

struct ContactUsView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: NavigationRouter
    @StateObject private var viewModel = ContactUsViewModel()
    @State private var showSuccessBanner: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                Image("complaintimage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 240)
                
                VStack(alignment: .leading, spacing: 16) {
                    messageField
                    emailField
                    submitButton
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            
            SimpleToastView (
                message: "We will contact to you soon",
                isPresented: showSuccessBanner
            )
        }
        .alert(item: $viewModel.customError) { error in
            Alert (
                title: Text(Constant.AppName),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Ok")) {
                    withAnimation {
                        viewModel.customError = nil
                    }
                }
            )
        }
        .onChange(of: viewModel.isConnected) { isConnect in
            if isConnect {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.showSuccessBanner = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showSuccessBanner = false
                    }
                    
                    router.popToRoot()
                }
            }
        }
    }
    
    private var messageField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $viewModel.comment)
                .frame(height: 150)
                .padding(8)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )

            if viewModel.comment.isEmpty {
                Text("Enter Message")
                    .foregroundColor(.gray)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .allowsHitTesting(false)
            }
        }
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Please enter email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .font(.customfont(.regular, fontSize: 14))
                .padding(.horizontal, 12)
                .frame(height: 50)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
        }
    }
    
    private var submitButton: some View {
        Button {
            Task {
               await viewModel.webToContactAdmin(appState: appState)
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                } else {
                    Text("Submit")
                        .font(.customfont(.regular, fontSize: 14))
                }
            }
            .foregroundColor(.yellow)
            .shadow(radius: 2)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
        }
        .background (.colorNeavyBlue)
        .cornerRadius(10)
        .disabled(viewModel.isLoading)
        .padding(.top, 16)
    }
}

#Preview {
    ContactUsView()
        .environmentObject(AppState())
        .environmentObject(NavigationRouter())
}
