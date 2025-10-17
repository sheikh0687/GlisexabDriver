//
//  RideDetailView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI
import MapKit

struct RideDetailView: View {
    
    // MARK: PROPERTIES
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: MAP VIEW
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                        
            // MARK: BOTTOM VIEW
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    // Address Details
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(spacing: 6) {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .font(.system(size: 18))
                            
                            Text("1901 Thornridge Cir. Shiloh, Hawaii 81063")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))

                            Text("2715 Ash Dr. San Jose, South Dakota 83475")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button {
                                print("Edit the selected address")
                            } label: {
                                Image("edit")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        
                        HStack(spacing: 6) {
                            Text("Booking ID :")
                                .font(.customfont(.medium, fontSize: 14))

                            Text("SFHSFFI")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(Color.gray)
                        }
                        
                        HStack(spacing: 6) {
                            Text("Date & Time :")
                                .font(.customfont(.medium, fontSize: 14))

                            Text("Today, 3:30PM")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(Color.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    
                    // Driver Details
                    HStack {
                        Image("userPlace")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                        Spacer().frame(width: 10)
                        VStack(spacing: 6) {
                            Text("Jerome Bell")
                                .font(.customfont(.medium, fontSize: 14))
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(Font.system(size: 14))
                                
                                Text("4.8 (9)")
                                    .font(.customfont(.regular, fontSize: 14))
                            }
                        }
                        Spacer()
                        Divider()
                            .frame(width: 1, height: 70)
                            .foregroundColor(Color.black)
                        Spacer()
                        VStack(spacing: 6) {
                            Text("$150.00")
                                .font(.customfont(.medium, fontSize: 14))
                            Text("Estimate")
                                .font(.customfont(.regular, fontSize: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button {
                                print("Call")
                            } label: {
                                Image("call")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            }
                            
                            Button {
                                print("Call")
                            } label: {
                                Image("fillChat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)

                    // Ride Preferences
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Ride Preference :")
                                    .font(.customfont(.medium, fontSize: 16))
                                    .foregroundColor(.black)
                                Text("luxury")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Number :")
                                    .font(.customfont(.medium, fontSize: 16))
                                    .foregroundColor(.black)
                                Text("4893")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Image("sedan")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 120)
                    }
                    .padding()
                    .frame(height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)

                    // Estimate Amount
                    HStack {
                        Text("Estimate :")
                            .font(.customfont(.medium, fontSize: 14))
                        
                        Spacer()
                        
                        Text("$150")
                            .font(.customfont(.medium, fontSize: 14))
                    }
                    .padding()
                    .frame(height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.bottom, 40)
                
                .background (
                    Color(.systemGray6)
                )
                .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
        }// ZSTACK
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
    RideDetailView()
}
