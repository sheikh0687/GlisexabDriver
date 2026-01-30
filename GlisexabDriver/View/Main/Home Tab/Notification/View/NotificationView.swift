//
//  NotificationView.swift
//  GlisexabDriver
//
//  Created by Arbaz  on 18/01/26.
//

import SwiftUI

struct NotificationView: View {
    
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 24) {
                
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading notification...")
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else if viewModel.arrayNotificationList.isEmpty {
                        VStack(spacing: 200) {
                            Spacer()
                            emptyState
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(viewModel.arrayNotificationList, id: \.id) { objNotify in
                            NotificationViewList(obj_Notify: objNotify)
                        }
                    }
                }
            }
            .padding(.all, 16)
        }
        .onAppear {
            Task {
               await viewModel.fetchNotificationList(appState: appState)
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image("empty")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("No notification yet")
                .font(.customfont(.medium, fontSize: 18))
                .foregroundColor(.black)
            
            Text("Your rides notification will appear here")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    
}

struct NotificationViewList: View {
    
    let obj_Notify: Res_NotificationList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(spacing: 6) {
                Text(obj_Notify.title ?? "")
                    .font(.customfont(.semiBold, fontSize: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(obj_Notify.message ?? "")
                    .font(.customfont(.regular, fontSize: 12))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Spacer()
                    Text(obj_Notify.date_time ?? "")
                        .font(.customfont(.regular, fontSize: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(16)
        .background (
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray6), lineWidth: 1.5)
                .background(Color.white)
                .shadow(radius: 2)
        )
        .cornerRadius(10)
    }
}

#Preview {
    NotificationView()
        .environmentObject(AppState())
}
