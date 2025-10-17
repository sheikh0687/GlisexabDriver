//
//  TrackingView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct TrackingView: View {
    
    @StateObject private var locationManager = LocationManager()
    @Binding var showingPopup: Bool
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: Map VIEW
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Top Address VIEW
            VStack {
                AddressSummaryView()
                Spacer()
            }
            .padding(.vertical, 40)
            
            // MARK: Bottom Ride Details VIEW
            VStack {
                Spacer()
                RideTrackingOuterView(showingPopup: $showingPopup)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            if showingPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showingPopup = false }
                    }
                // Your Popup Content
                PopUp(isShowing: $showingPopup)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showingPopup)
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
    TrackingView(showingPopup: .constant(false))
}

// MARK: Top Address Details VIEW
struct AddressSummaryView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("pinRed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 100)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Pickup Address")
                        .font(.customfont(.bold, fontSize: 14))
                    Text("1901 Thornridge Cir. Shiloh, Hawaii 81063 Indore 456789")
                        .font(.customfont(.medium, fontSize: 12))
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text("2 min away")
                            .font(.customfont(.medium, fontSize: 12))
                            .foregroundColor(.colorGreen)
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
                }
            }
        }
        .padding()
        .padding(.horizontal, 10)
        .background (
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(.separator), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
                .ignoresSafeArea(edges: .bottom)
        )
        .padding(.horizontal, 40)
    }
}

// MARK: Bottom Ride Outer VIEW
struct RideTrackingOuterView: View {
    @Binding var showingPopup: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            RideTrackingInnerView(showingPopup: $showingPopup)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background (
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(.separator), lineWidth: 0.5)
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.white)
                )
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

// MARK: Bottom Ride Inner VIEW
struct RideTrackingInnerView: View {
    
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 40
    @State var buttonOffset: CGFloat = 0
    @State var isAnimate: Bool = false
    @Binding var showingPopup: Bool
    
    @State var strStatus: String = "Notify Arrived"
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("userPlace")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 54, height: 54)
                Spacer().frame(width: 10)
                Text("Jerome Bell")
                    .font(.customfont(.medium, fontSize: 14))
                Spacer()
                Divider()
                    .frame(width: 1, height: 40)
                    .foregroundColor(Color.black)
                Spacer()
                VStack(spacing: 6) {
                    Text("Sedan")
                        .font(.customfont(.regular, fontSize: 12))
                        .foregroundColor(.gray)
                    Text("4893")
                        .font(.customfont(.medium, fontSize: 14))
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
                
                Menu {
                    CustomButtonAction(title: "Ride Details", color: .clear, titleColor: .black) {
                        router.push(to: .ridedetails)
                    }
                    
                } label : {
                    Image("editAddress")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
            }
            .padding(.horizontal, 10)
            
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
            
            ZStack {
                Capsule()
                    .fill(LinearGradient(colors: [.colorNeavyBlue, .colorLightNeavy], startPoint: .leading, endPoint: .trailing))
                
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 56, height: 56)
                            .shadow(color: Color.black.opacity(0.15), radius: 6, y: 2)
                        Image(systemName: "chevron.right.2")
                            .foregroundColor(.colorNeavyBlue)
                            .font(.system(size: 24, weight: .bold))
                    }
                    .offset(x: buttonOffset)
                    .gesture (
                        DragGesture()
                            .onChanged({ gesture in
                                let drag = gesture.translation.width
                                if drag > 0 && drag < buttonWidth - 60 {
                                    buttonOffset = drag
                                }
                            })
                            .onEnded({ _ in
                                if buttonOffset > buttonWidth / 2 {
                                    buttonOffset = buttonWidth - 60
                                    if strStatus == "Notify Arrived" {
                                        strStatus = "Start Pickup"
                                        buttonOffset = 0
                                    } else if strStatus == "Start Pickup" {
                                        strStatus = "Passenger Picked"
                                        buttonOffset = 0
                                    } else if strStatus == "Passenger Picked" {
                                        strStatus = "Start to Drop-off"
                                        buttonOffset = 0
                                    } else if strStatus == "Start to Drop-off" {
                                        strStatus = "Drop-off Completed"
                                        buttonOffset = 0
                                    } else {
                                        showingPopup = true
                                    }
                                } else {
                                    buttonOffset = 0
                                }
                            })
                    )
                    
                    Spacer()
                }
                .frame(width: buttonWidth - 16, height: 60)
                
                Text(strStatus)
                    .font(.customfont(.semiBold, fontSize: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: 20)
                
            }
            .frame(width: buttonWidth, height: 60)
            
            HStack {
                Spacer()
                CustomButtonAction(title: "Cancel", color: .red, titleColor: .white) {
                    print("cancel this")
                }
                Spacer()
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
