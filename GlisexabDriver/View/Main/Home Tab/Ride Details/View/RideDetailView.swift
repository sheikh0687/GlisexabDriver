//
//  RideDetailView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI
internal import MapKit

struct RideDetailView: View {
    
    // MARK: PROPERTIES
    @StateObject private var locationManager = LocationSearchViewModel()
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var viewModel = RideDetailViewModel()
    
    @State var strRequestiD: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            // MARK: MAP VIEW
            CustomMapView (
                region: $locationManager.region,
                annotations: makeAnnotations(),
                routes: locationManager.route.map { [$0] } ?? []
            )

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
                            
                            Text(viewModel.rideDtls?.pick_address ?? "")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))

                            Text(viewModel.rideDtls?.drop_address ?? "")
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

                            Text("#\(viewModel.rideDtls?.id ?? "")")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(Color.gray)
                        }
                        
                        HStack(spacing: 6) {
                            Text("Date & Time :")
                                .font(.customfont(.medium, fontSize: 14))

                            Text(viewModel.rideDtls?.date_time ?? "")
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
                        if let urlString = viewModel.rideDtls?.user_details?.image {
                            Utility.CustomWebImage(imageUrl: urlString, placeholder: Image(systemName: "placeholder"), width: 70, height: 70)
                        }
                        Spacer().frame(width: 10)
                        VStack(spacing: 6) {
                            Text("\(viewModel.rideDtls?.user_details?.first_name ?? "") \(viewModel.rideDtls?.user_details?.last_name ?? "")")
                                .font(.customfont(.medium, fontSize: 14))
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(Font.system(size: 14))
                                
                                Text(viewModel.rideDtls?.driver_details?.rating ?? "")
                                    .font(.customfont(.regular, fontSize: 14))
                            }
                        }
                        Spacer()
                        Divider()
                            .frame(width: 1, height: 70)
                            .foregroundColor(Color.black)
                        Spacer()
                        VStack(spacing: 6) {
                            Text("$ \(viewModel.rideDtls?.total_amount ?? "")")
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
                                Text(viewModel.rideDtls?.vehicle_name ?? "")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Number :")
                                    .font(.customfont(.medium, fontSize: 16))
                                    .foregroundColor(.black)
                                Text(viewModel.rideDtls?.user_details?.registration_no ?? "")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        if let urlString = viewModel.rideDtls?.car_details?.image {
                            Utility.CustomWebImage(imageUrl: urlString, placeholder: Image(systemName: "placeholder"), width: 60, height: 60)
                        }
                    }
                    .padding()
                    .frame(height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)

                    // Estimate Amount
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
           Task {
               await viewModel.loadRideDetails(appState: appState, requestiD: strRequestiD)
            }
        }
        .onChange(of: viewModel.rideDtls != nil) { isSuccess in
            if isSuccess {
                if let obj = viewModel.rideDtls {
                    if let pickLat = Double(obj.pickup_lat ?? ""),
                       let pickLon = Double(obj.pickup_lon ?? ""),
                       let dropLat = Double(obj.dropoff_lat ?? ""),
                       let dropLon = Double(obj.dropoff_lon ?? "") {
                        
                        let pickupCoord = CLLocationCoordinate2D(latitude: pickLat, longitude: pickLon)
                        let dropoffCoord = CLLocationCoordinate2D(latitude: dropLat, longitude: dropLon)
                        
                        locationManager.pickupCoordinate = pickupCoord
                        locationManager.dropoffCoordinate = dropoffCoord
                    } else {
                        print("Invalid coordinates received")
                    }
                }
            }
        }
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var result: [MKPointAnnotation] = []
        if let pickup = locationManager.pickupCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = pickup
            ann.title = "Pickup"
            result.append(ann)
        }
        if let drop = locationManager.dropoffCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = drop
            ann.title = "Drop-off"
            result.append(ann)
        }
        return result
    }
}

#Preview {
    RideDetailView(strRequestiD: "1")
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
