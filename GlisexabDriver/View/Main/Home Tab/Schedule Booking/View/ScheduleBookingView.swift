//
//  ScheduleBookingView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

enum BookingStatus: String, Codable {
    case pending = "Pending"
    case upcoming = "Upcoming"
    case inProgress = "In Progress"
}

struct ScheduleBookingView: View {
    
    @State private var selectedStatus: BookingStatus = .pending
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = ScheduleViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 24) {
                 HStack(spacing: 8) {
                    ForEach([BookingStatus.pending, .upcoming, .inProgress], id: \.self) { status in
                        Button {
                            selectedStatus = status
                            fetchSchedule()
                        } label: {
                            Text(status.rawValue)
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(selectedStatus == status ? .white : .colorNeavyBlue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(selectedStatus == status ? Color.colorNeavyBlue : Color(.systemGray6))
                        }
                    }
                }
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Finding ride")
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else if viewModel.arrayScheduleRide.isEmpty {
                        Spacer()
                        emptyState
                        Spacer()
                    } else {
                        ForEach(viewModel.arrayScheduleRide, id: \.id) { scheduleRide in
                            ScheduleRideView(obj: scheduleRide)
                        }
                    }
                }
            }
            .padding(.all, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            fetchSchedule()
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image("empty")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("No ride yet")
                .font(.customfont(.medium, fontSize: 18))
                .foregroundColor(.black)
            
            Text("Your rides will appear here")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    
    private func fetchSchedule() {
        Task {
            await viewModel.webGetScheduleRide(appState: appState, strPending: selectedStatus.rawValue)
        }
    }
}

struct ScheduleRideView: View {
    
    let obj: Res_ScheduleList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {

                AsyncImage(url: URL(string: obj.user_details?.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image("user")
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                
                Spacer().frame(width: 10)
                
                Text("\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")")
                    .font(.customfont(.medium, fontSize: 14))
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 54)
                    .foregroundColor(Color.black)
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("$\(obj.total_amount ?? "")")
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
                    Text("$\(obj.driver_amount ?? "")")
                        .font(.customfont(.medium, fontSize: 14))
                    Text("Driver Amount:")
                        .font(.customfont(.regular, fontSize: 12))
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 40) {
                HStack(spacing: 10) {
                    Text("Time:")
                        .font(.customfont(.semiBold, fontSize: 14))
                    Text(obj.time ?? "")
                        .font(.customfont(.regular, fontSize: 12))
                }
                
                HStack(spacing: 10) {
                    Text("Date:")
                        .font(.customfont(.semiBold, fontSize: 14))
                    Text(obj.date ?? "")
                        .font(.customfont(.regular, fontSize: 12))
                }
            }
            .padding(.horizontal, 40)
            
            Divider()
            
            // Pickup / Drop info
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin")
                        .foregroundColor(.red)
                        .font(.system(size: 18))
                    Text(obj.pick_address ?? "")
                        .font(.customfont(.medium, fontSize: 14))
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 18))
                    Text(obj.drop_address ?? "")
                        .font(.customfont(.medium, fontSize: 14))
                        .multilineTextAlignment(.leading)
                }
            }
            
//            HStack {
//                CustomButtonAction(title: "Accept", color: .colorGreen, titleColor: .white) {
//                    
//                }
//                
//                CustomButtonAction(title: "Send Counter", color: .colorNeavyBlue, titleColor: .white) {
//                    print("Accept request")
//                }
//                
//                CustomButtonAction(title: "Decline", color: .red, titleColor: .white) {
//                    print("Accept request")
//                }
//            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

#Preview {
    ScheduleBookingView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}

