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
    
    var body: some View {
        ZStack {
            VStack {
                 HStack(spacing: 8) {
                    ForEach([BookingStatus.pending, .upcoming, .inProgress], id: \.self) { status in
                        Button {
                            selectedStatus = status
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
                .padding()
                
                // Booking Card
                 VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image("userPlace")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        Spacer().frame(width: 10)
                        
                        Text("Jerome Bell")
                            .font(.customfont(.medium, fontSize: 14))
                        
                        Spacer()
                        
                        Divider()
                            .frame(width: 1, height: 54)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        VStack(spacing: 6) {
                            Text("$100")
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
                            Text("$80")
                                .font(.customfont(.medium, fontSize: 14))
                            Text("Customer Offered:")
                                .font(.customfont(.regular, fontSize: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack(spacing: 40) {
                        HStack(spacing: 10) {
                            Text("Time:")
                                .font(.customfont(.semiBold, fontSize: 14))
                            Text("5:00 PM")
                                .font(.customfont(.regular, fontSize: 12))
                        }
                        
                        HStack(spacing: 10) {
                            Text("Date:")
                                .font(.customfont(.semiBold, fontSize: 14))
                            Text("29/09/2025")
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
                            Text("1901 Thornridge Cir. Shiloh, Hawaii 81063")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))
                            Text("2715 Ash Dr. San Jose, South Dakota 83475")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    HStack {
                        CustomButtonAction(title: "Accept", color: .colorGreen, titleColor: .white) {
                            
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
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 4)
                .padding()
                
                 Spacer()
            }
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
        }
    }
}

#Preview {
    ScheduleBookingView()
}

