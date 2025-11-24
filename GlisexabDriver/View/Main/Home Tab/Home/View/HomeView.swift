//
//  Home.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 15/10/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State var isOnline = false
    
    @State private var showMenu = false
    @State private var selectedTab = 0
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject var VM = HomeViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Top ADDRESS VIEW
            VStack {
                EarningsSummaryView
                Spacer()
            }
            .padding(.vertical, 40)
            
            // MARK: BOTTOM VIEW
            VStack {
                Spacer()
                BottomBarView
            }
            .edgesIgnoringSafeArea(.bottom)
            
            SideMenu(isShow: $showMenu) { selectedOption in
                switch selectedOption {
                case .home:
                    router.push(to: .home)
                case .myAccount:
                    router.push(to: .myAccount)
                case .myReview:
                    router.push(to: .myReview)
                case .wallet:
                    print("Navigate to wallet")
                case .history:
                    print("Navigate to history")
                case .inviteFriend:
                    print("Navigate to Invite Friend")
                case .privacyPolicy:
                    print("Navigate to Privacy")
                case .support:
                    print("Navigate to Support")
                case .logout:
                    router.popToRoot()
                }
            }
        }
        //        .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            VM.loadPendingRequests(appState: appState)
        }
    }
    
    // MARK: Top Earning VIEW
    @ViewBuilder
    private var EarningsSummaryView: some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text("$0.0")
                .font(.customfont(.bold, fontSize: 18))
            
            Text("Today Earning")
                .font(.customfont(.medium, fontSize: 16))
                .multilineTextAlignment(.center)
            
            Text("0 trip completed today")
                .font(.customfont(.medium, fontSize: 16))
                .multilineTextAlignment(.center)
        }
        .padding()
        .padding(.horizontal, 20)
        .background (
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.gray, lineWidth: 0.5)
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    // MARK: Bottom Outer Detail VIEW
    @ViewBuilder
    private var BottomBarView: some View {
        
        VStack(spacing: 0) {
            HStack {
                Button {
                    isOnline.toggle()
                } label: {
                    HStack {
                        Image(systemName: isOnline ? "checkmark.circle.fill" : "xmark.octagon.fill")
                            .foregroundColor(.white)
                        Text(isOnline ? "Online" : "Offline")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(isOnline ? Color.green : Color.red)
                    .cornerRadius(22)
                }
                
                Spacer()
                
                HStack(spacing: 10) {
                    Button {
                        print("Navigate to notify")
                    } label: {
                        ZStack {
                            Image("notification")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Circle()
                                .fill(isOnline ? Color.red : Color.clear)
                                .frame(width: 12, height: 12)
                                .offset(x: 6, y: -10)
                        }
                        .frame(width: 36, height: 36)
                    }
                    
                    Button {
                        router.push(to: .scheduleDetail)
                    } label: {
                        Image("schedule")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 36, height: 36)
                }
                .padding()
            }
            
            if !isOnline {
                HStack(spacing: 8) {
                    Text(isOnline ? "Finding rides" : "Your are currently offline")
                        .font(.customfont(.semiBold, fontSize: 16))
                    if isOnline {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            } else {
                BargainRequestCard
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(.separator), lineWidth: 0.5)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.white)
                )
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    // MARK: Bottom Inner Detail VIEW
    @ViewBuilder
    private var BargainRequestCard: some View {
        
        if let r = VM.selectedRequest {
            VStack(spacing: 15) {
                // Header
                HStack {
                    Text("New Bargain Request!")
                        .font(.customfont(.semiBold, fontSize: 16))
                    Spacer()
                    Text("Estimated trip: \(r.time_away ?? "") mins")
                        .font(.customfont(.regular, fontSize: 12))
                }
                
                // User info
                HStack {
                    
                    if let urlString = r.user_details?.image {
                        Utility.CustomWebImage(imageUrl: urlString, placeholder: Image(systemName: "placeholder"), width: 44, height: 44)
                    }
                    
                    Spacer().frame(width: 10)
                    
                    Text("\(r.user_details?.first_name ?? "") \(r.user_details?.last_name ?? "")")
                        .font(.customfont(.medium, fontSize: 14))
                    
                    Spacer()
                    
                    Divider()
                        .frame(width: 1, height: 54)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("$\(r.total_amount ?? "")")
                            .font(.customfont(.medium, fontSize: 14))
                        Text("Base fare:")
                            .font(.customfont(.regular, fontSize: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Divider()
                        .frame(width: 1, height: 54)
                        .foregroundColor(Color.black)
                    
                    VStack(spacing: 6) {
                        Text("$\(r.total_amount ?? "")")
                            .font(.customfont(.medium, fontSize: 14))
                        Text("Customer Offered:")
                            .font(.customfont(.regular, fontSize: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                // Date / Time
                HStack {
                    HStack(spacing: 4) {
                        Text("Time:")
                            .font(.customfont(.semiBold, fontSize: 14))
                        Text(r.time ?? "")
                            .font(.customfont(.regular, fontSize: 12))
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Text("Date:")
                            .font(.customfont(.semiBold, fontSize: 14))
                        Text(r.date ?? "")
                            .font(.customfont(.regular, fontSize: 12))
                    }
                }
                
                Divider()
                
                // Pickup / Drop info
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                            .font(.system(size: 18))
                        Text(r.pick_address ?? "")
                            .font(.customfont(.medium, fontSize: 14))
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 18))
                        Text(r.drop_address ?? "")
                            .font(.customfont(.medium, fontSize: 14))
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("2 mins left to accept the ride!")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.colorGreen)
                }
                
                HStack {
                    CustomButtonAction(title: "Accept", color: .colorGreen, titleColor: .white) {
                        router.push(to: .trackRide)
                    }
                    
                    CustomButtonAction(title: "Send Counter", color: .colorNeavyBlue, titleColor: .white) {
                        print("Accept request")
                    }
                    
                    CustomButtonAction(title: "Decline", color: .red, titleColor: .white) {
                        print("Accept request")
                    }
                }
            }
            .padding()
            .background (
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(.separator), lineWidth: 1)
                    .background (
                        RoundedRectangle(cornerRadius: 18).fill(Color.white)
                    )
            )
            
        } else {
            Text("No pending rides")
                .font(.customfont(.medium, fontSize: 14))
                .padding(.top, 8)
        }
    }
}

#Preview {
    HomeView()
}





