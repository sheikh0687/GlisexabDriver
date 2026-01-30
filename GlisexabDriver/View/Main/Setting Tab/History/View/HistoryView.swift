//
//  ScheduleBookingView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 17/10/25.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
//            Color.linear
//                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                headerText
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        if viewModel.isLoading {
                            ProgressView("Loading history...")
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else if viewModel.rideHistory.isEmpty {
                            emptyState
                        } else {
                            ForEach(viewModel.rideHistory, id: \.id) { history in
                                HistoryCardView(history: history, viewModel: viewModel)
                            }
                        }
                    }
                }
            }
            .padding(.all, 16)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
               await viewModel.fetchRideHistory()
            }
        }
        .sheet(isPresented: $viewModel.isShowRideDetail) {
            if #available(iOS 16.0, *) {
                RideDetailView(strRequestiD: viewModel.requestiD)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var headerText: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("History")
                .font(.customfont(.semiBold, fontSize: 28))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Check your recent ride transactions")
                .font(.customfont(.regular, fontSize: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            
            Text("No rides yet")
                .font(.customfont(.medium, fontSize: 18))
                .foregroundColor(.black)
            
            Text("Your completed rides will appear here")
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

struct HistoryCardView: View {
    
    let history: Res_HistoryList
    let viewModel: HistoryViewModel
    
    private var topStripeColor: Color {
        switch history.status?.lowercased() {
        case "accept", "arrived", "start": return Color.yellow
        case "finish": return Color.green
        case "cancel": return Color.red
        default: return Color("colorFont")
        }
    }

    private var customerName: String {
        "\(history.driver_details?.first_name ?? "") \(history.driver_details?.last_name ?? "")"
    }
    
    private var ratingText: String {
        if let rating = history.rating, !rating.isEmpty, rating != "0" {
            return rating + " (0)" // feedback count not available
        }
        return "N/A"
    }
    
    private var amountText: String {
        "₦\(history.driver_amount ?? history.total_amount ?? "0.00")"
    }
    
    private var carType: String {
        history.vehicle_name ?? history.car_details?.vehicle ?? "Sedan"
    }
    
    private var carNumber: String {
        history.vehicle_id ?? "N/A"
    }
    
    private var dateText: String {
        let date = history.date ?? "N/A"
//        let time = history.time ?? ""
        return "\(date)"
    }
    
    private var statusTitle: String {
        history.status?.capitalized ?? "Active"
    }
    
    private var estimateLabel: String {
        "Driver: ₦\(history.driver_amount ?? "0")"
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(dateText) Instant")
                    .font(.customfont(.regular, fontSize: 12))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(statusTitle)
                    .font(Font.customfont(.medium, fontSize: 11))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background (
                        Capsule()
                            .fill(.white)
                    )
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(topStripeColor)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    HStack(spacing: 8) {
                        // Use driver_details image if available
                        AsyncImage(url: URL(string: history.driver_details?.image ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Image("user")
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(customerName)
                                .font(.customfont(.medium, fontSize: 14))
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 10))
                                Text(ratingText)
                                    .font(.customfont(.regular, fontSize: 11))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Divider()
                        .background(.black)
                    
                    Spacer()
                    
                    HStack(spacing: 24) {
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(amountText)
                                .font(.customfont(.semiBold, fontSize: 14))
                            Text(estimateLabel)
                                .font(.customfont(.regular, fontSize: 11))
                                .foregroundColor(.gray)
                        }
                        
                        Button {
                            print("Chat for ride ID: \(history.id ?? "")")
                        } label: {
                            Image("chat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                
                HStack(spacing: 12) {
                    // Car image from car_details
                    AsyncImage(url: URL(string: history.car_details?.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("sedan")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 90, height: 40)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(carType)
                            .font(.customfont(.medium, fontSize: 13))
                        Text(carNumber)
                            .font(.customfont(.regular, fontSize: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Button {
                    viewModel.requestiD = history.id ?? ""
                    viewModel.isShowRideDetail = true
                    print("View Info for ride ID: \(history.id ?? "")")
                } label: {
                    Text("View Info")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.colorNeavyBlue)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
            }
            .padding(12)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    HistoryView()
}

