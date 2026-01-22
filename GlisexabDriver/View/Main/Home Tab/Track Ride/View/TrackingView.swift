//
//  TrackingView.swift
//  GlisexabDriver
//
//  Created by Techimmense Software Solutions on 16/10/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct TrackingView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: NavigationRouter
    
    @StateObject private var locationManager = LocationSearchViewModel()
    @StateObject private var viewModel = TrackingViewModel()
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 40
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimate: Bool = false
    @State private var showingPopup: Bool = false
    @State private var strStatus: String = "Notify Arrived"
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: Map VIEW
            CustomMapView (
                region: $locationManager.region,
                annotations: makeAnnotations(),
                routes: locationManager.route.map { [$0] } ?? []
            )
            
            // MARK: Top Address VIEW
            VStack {
                addressSummaryView
                Spacer()
            }
            .padding(.vertical, 40)
            
            // MARK: Bottom Ride Details VIEW
            VStack {
                Spacer()
                rideTrackingOuterView
            }
            .edgesIgnoringSafeArea(.bottom)
            
            if showingPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showingPopup = false }
                    }
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
                    viewModel.router?.popView()
                }
            }
        }
        .onChange(of: viewModel.customError) { newError in
            withAnimation {
                viewModel.showErrorBanner = newError != nil
            }
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
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            viewModel.router = router
           Task {
               await viewModel.loadDriverActiveReq(appState: appState)
            }
        }
        .onChange(of: viewModel.isSuccess) { isSuccess in
            if isSuccess, let obj = viewModel.resActiveReq {
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
                
                let status = obj.status ?? ""
                if status == "Accept" {
                    strStatus = "Notify Arrived"
                } else if status == "Arrived" {
                    strStatus = "Start Pickup"
                    
                    if viewModel.arrivalTimer == nil {
                        if let toLongTime = obj.to_long_time,
                           let timerFreeMinute = Int(obj.timer_free_minute ?? "0"),
                           let noShowFeeTime = obj.no_show_fee_time {
                            
                            let totalElapsedTime = TimeInterval(toLongTime)
                            let freeTimeInSeconds = TimeInterval(timerFreeMinute * 60)
                            let noShowFeeTimeInterval = TimeInterval(noShowFeeTime)
                            
                            viewModel.startArrivalTimer (
                                totalElapsedTime: totalElapsedTime,
                                freeTime: freeTimeInSeconds,
                                noShowFeeTime: noShowFeeTimeInterval
                            )
                        }
                    } else {
                        print("⏳ Arrival Timer Already Running — NOT restarting")
                    }
                    
                } else if status == "Start" {
                    strStatus = "Finish Ride"
                    viewModel.stopArrivalTimer()
                    viewModel.updateWaitingChargeWhenStart()
                }
            }
        }
//        .onChange(of: viewModel.isFinished) { isFinished in
//            if isFinished {
//                viewModel.stopArrivalTimer()
//                router.push(to: .rating(useriD: viewModel.resActiveReq?.user_details?.id ?? "", requestiD: viewModel.resActiveReq?.id ?? ""))
//            }
//        }
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

// MARK: - Subviews as builders
extension TrackingView {
    
    @ViewBuilder
    private var addressSummaryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image("pinRed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 100)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Pickup Address")
                        .font(.customfont(.bold, fontSize: 14))
                    Text(
                        viewModel.resActiveReq?.status == "Accept" ?
                        (viewModel.resActiveReq?.pick_address ?? "") :
                            (viewModel.resActiveReq?.drop_address ?? "")
                    )
                    .font(.customfont(.medium, fontSize: 12))
                    .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("\(viewModel.resActiveReq?.time_away ?? "") minutes,\(viewModel.resActiveReq?.distance_away ?? "") miles")
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
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
                .ignoresSafeArea(edges: .bottom)
        )
        .padding(.horizontal, 40)
    }
    
    @ViewBuilder
    private var rideTrackingOuterView: some View {
        VStack(spacing: 0) {
            rideTrackingInnerView
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
    
    @ViewBuilder
    private var rideTrackingInnerView: some View {
        VStack(spacing: 20) {
            // Top user + fare row
            HStack {
                if let urlString = viewModel.resActiveReq?.user_details?.image {
                    Utility.CustomWebImage (
                        imageUrl: urlString,
                        placeholder: Image(systemName: "person.crop.circle.fill"),
                        width: 44,
                        height: 44
                    )
                    .clipShape(.circle)
                    .frame(width: 44, height: 44)
                }
                
                Spacer().frame(width: 10)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.resActiveReq?.user_details?.first_name ?? "")
                        .font(.customfont(.medium, fontSize: 14))
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                            .font(Font.system(size: 14))
                        
                        Text("\(viewModel.resActiveReq?.user_details?.rating ?? "") (\(viewModel.resActiveReq?.user_details?.rating_count ?? "0"))")
                            .font(.customfont(.regular, fontSize: 14))
                    }
                }
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 40)
                    .foregroundColor(Color.black)
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Estimate")
                        .font(.customfont(.regular, fontSize: 12))
                        .foregroundColor(.gray)
                    Text("$\(viewModel.resActiveReq?.driver_amount ?? "")")
                        .font(.customfont(.medium, fontSize: 14))
                }
                
                Spacer()
                
                HStack(spacing: 10) {
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
                        viewModel.router?.push(to: .ridedetails)
                    }
                    CustomButtonAction(title: "Cancel", color: .clear, titleColor: .black) {
                        // handle cancel
                    }
                } label: {
                    Image("editAddress")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal, 10)
            
            if viewModel.showWaitingCharge {
                Text("Waiting charges may apply")
                    .font(.customfont(.medium, fontSize: 12))
                    .foregroundColor(.red)
            }
            
            if viewModel.strDriverStatus == "Finish" && viewModel.strPaymentStatus == "Pending" {
                Button {
                    self.showingPopup = true
                } label: {
                    Text("Payment received?")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(.colorNeavyBlue)
                        .cornerRadius(24)
                        .shadow(radius: 2)
                }
            } else {
                HStack(spacing: 12) {
                    if viewModel.resActiveReq?.status == "Arrived" {
                        arrivalTime
                            .frame(width: 40, height: 40)   // fixed circle size
                    }
                    
                    sliderView
                        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60) // flexible width
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    @ViewBuilder
    private var arrivalTime: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 6)
            
            Circle()
                .trim(from: 0, to: viewModel.arrivalProgress)
                .stroke(viewModel.showWaitingCharge ? Color.red : Color.green, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: viewModel.arrivalProgress)
            
            Text(viewModel.formattedArrivalTime)
                .font(.customfont(.medium, fontSize: 10))
        }
    }
    
    @ViewBuilder
    private var sliderView: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ZStack {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.colorNeavyBlue, .colorLightNeavy],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
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
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let drag = gesture.translation.width
                                if drag > 0 && drag < width - 60 {
                                    buttonOffset = drag
                                }
                            }
                            .onEnded { _ in
                                if buttonOffset > width / 2 {
                                    buttonOffset = width - 60
                                    handleStatusProgression()
                                } else {
                                    buttonOffset = 0
                                }
                            }
                    )
                    
                    Spacer()
                }
                
                Text(strStatus)
                    .font(.customfont(.semiBold, fontSize: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: 20)
            }
        }
        .frame(height: 60)
    }
    
    private func handleStatusProgression() {
        switch viewModel.strDriverStatus {
        case "Accept":
           Task {
               await viewModel.loadChangeRequest(appState: appState, strStatus: "Arrived")
            }
            buttonOffset = 0
        case "Arrived":
           Task {
               await viewModel.loadChangeRequest(appState: appState, strStatus: "Start")
            }
            buttonOffset = 0
        case "Start":
           Task {
               await viewModel.loadChangeRequest(appState: appState, strStatus: "Finish")
            }
            buttonOffset = 0
        default: break
        }
    }
}

#Preview {
    TrackingView()
        .environmentObject(AppState())
        .environmentObject(NavigationRouter())
}


//struct TrackingView: View {
//
//    @EnvironmentObject private var router: NavigationRouter
//    @EnvironmentObject private var appState: AppState
//
//    @StateObject private var locationManager = LocationManager()
//    @StateObject private var viewModel = TrackingViewModel()
//
//    var body: some View {
//
//        ZStack(alignment: .top) {
//            // MARK: Map VIEW
//            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
//                .edgesIgnoringSafeArea(.all)
//
//            // MARK: Top Address VIEW
//            VStack {
//                AddressSummaryView(vM: viewModel)
//                Spacer()
//            }
//            .padding(.vertical, 40)
//
//            // MARK: Bottom Ride Details VIEW
//            VStack {
//                Spacer()
//                RideTrackingOuterView(showingPopup: $viewModel.showingPopup, vM: viewModel)
//            }
//            .edgesIgnoringSafeArea(.bottom)
//
//            if viewModel.showingPopup {
//                Color.black.opacity(0.4)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation { viewModel.showingPopup = false }
//                    }
//                // Your Popup Content
//                PopUp(isShowing: $viewModel.showingPopup)
//                    .transition(.scale)
//                    .zIndex(1)
//            }
//        }
//        .animation(.easeInOut, value: viewModel.showingPopup)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                BackButton {
//                    router.popView()
//                }
//            }
//        }
//        .onAppear {
//            UINavigationBar.setTitleColor(.white)
//            viewModel.loadDriverActiveReq(appState: appState)
//        }
//    }
//}
//
//// MARK: Top Address Details VIEW
//struct AddressSummaryView: View {
//
//    let vM: TrackingViewModel
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack(spacing: 10) {
//                Image("pinRed")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 24, height: 100)
//
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Pickup Address")
//                        .font(.customfont(.bold, fontSize: 14))
//                    Text (
//                        vM.resActiveReq?.status == "Accept" ?
//                        vM.resActiveReq?.pick_address ?? "" :
//                            vM.resActiveReq?.drop_address ?? ""
//                    )
//                    .font(.customfont(.medium, fontSize: 12))
//                    .multilineTextAlignment(.leading)
//                    HStack {
//                        Text("\(vM.resActiveReq?.time_away ?? "") minutes,\(vM.resActiveReq?.distance_away ?? "") miles")
//                            .font(.customfont(.medium, fontSize: 12))
//                            .foregroundColor(.colorGreen)
//
//                        Spacer()
//
//                        Button {
//                            print("Edit the selected address")
//                        } label: {
//                            Image("edit")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 24, height: 24)
//                        }
//                    }
//                }
//            }
//        }
//        .padding()
//        .padding(.horizontal, 10)
//        .background (
//            RoundedRectangle(cornerRadius: 18)
//                .stroke(Color(.separator), lineWidth: 1)
//                .background(
//                    RoundedRectangle(cornerRadius: 18)
//                        .fill(Color.white)
//                )
//                .ignoresSafeArea(edges: .bottom)
//        )
//        .padding(.horizontal, 40)
//    }
//}
//
//// MARK: Bottom Ride Outer VIEW
//struct RideTrackingOuterView: View {
//    @Binding var showingPopup: Bool
//    let vM: TrackingViewModel
//
//    var body: some View {
//
//        VStack(spacing: 0) {
//            RideTrackingInnerView(showingPopup: $showingPopup, vM: vM)
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background (
//            RoundedRectangle(cornerRadius: 18)
//                .stroke(Color(.separator), lineWidth: 0.5)
//                .background (
//                    RoundedRectangle(cornerRadius: 18)
//                        .fill(.white)
//                )
//                .ignoresSafeArea(edges: .bottom)
//        )
//    }
//}
//
//// MARK: Bottom Ride Inner VIEW
//struct RideTrackingInnerView: View {
//
//    @State var buttonWidth: Double = UIScreen.main.bounds.width - 40
//    @State var buttonOffset: CGFloat = 0
//    @State var isAnimate: Bool = false
//    @Binding var showingPopup: Bool
//
//    @State var strStatus: String = "Notify Arrived"
//    @EnvironmentObject private var router: NavigationRouter
//
//    let vM: TrackingViewModel
//
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack {
//                if let urlString = vM.resActiveReq?.user_details?.image {
//                    Utility.CustomWebImage(imageUrl: urlString, placeholder: Image(systemName: "person.crop.circle.fill"), width: 44, height: 44)
//                        .clipShape(.circle)
//                        .frame(width: 44, height: 44)
//                }
//                Spacer().frame(width: 10)
//                VStack(alignment: .leading, spacing: 6) {
//                    Text(vM.resActiveReq?.user_details?.first_name ?? "")
//                        .font(.customfont(.medium, fontSize: 14))
//                    HStack {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(Color.yellow)
//                            .font(Font.system(size: 14))
//
//                        Text("\(vM.resActiveReq?.user_details?.rating ?? "0")(\(vM.resActiveReq?.user_details?.rating_count ?? "0"))")
//                            .font(.customfont(.regular, fontSize: 14))
//                    }
//                }
//                Spacer()
//                Divider()
//                    .frame(width: 1, height: 40)
//                    .foregroundColor(Color.black)
//                Spacer()
//                VStack(spacing: 6) {
//                    Text("Estimate")
//                        .font(.customfont(.regular, fontSize: 12))
//                        .foregroundColor(.gray)
//                    Text("$\(vM.resActiveReq?.driver_amount ?? "")")
//                        .font(.customfont(.medium, fontSize: 14))
//                }
//                Spacer()
//
//                HStack(spacing: 10) {
//
////                    Button {
////                        print("Call")
////                    } label: {
////                        Image("call")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 32, height: 32)
////                    }
//
//                    Button {
//                        print("Call")
//                    } label: {
//                        Image("fillChat")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 32, height: 32)
//                    }
//                }
//
//                Menu {
//                    CustomButtonAction(title: "Ride Details", color: .clear, titleColor: .black) {
//                        router.push(to: .ridedetails)
//                    }
//
//                    CustomButtonAction(title: "Cancel", color: .clear,titleColor: .black) {
//
//                    }
//
//                } label : {
//                    Image("editAddress")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                }
//
//            }
//            .padding(.horizontal, 10)
//
////            VStack(alignment: .leading, spacing: 14) {
////                HStack(spacing: 4) {
////                    Image(systemName: "mappin")
////                        .foregroundColor(.red)
////                        .font(.system(size: 18))
////                    Text("1901 Thornridge Cir. Shiloh, Hawaii 81063")
////                        .font(.customfont(.medium, fontSize: 14))
////                        .multilineTextAlignment(.leading)
////                }
////
////                HStack(spacing: 4) {
////                    Image(systemName: "mappin.circle.fill")
////                        .foregroundColor(.green)
////                        .font(.system(size: 18))
////                    Text("2715 Ash Dr. San Jose, South Dakota 83475")
////                        .font(.customfont(.medium, fontSize: 14))
////                        .multilineTextAlignment(.leading)
////                }
////            }
//
//            ZStack {
//                Capsule()
//                    .fill(LinearGradient(colors: [.colorNeavyBlue, .colorLightNeavy], startPoint: .leading, endPoint: .trailing))
//
//                HStack {
//                    ZStack {
//                        Circle()
//                            .fill(Color.white)
//                            .frame(width: 56, height: 56)
//                            .shadow(color: Color.black.opacity(0.15), radius: 6, y: 2)
//                        Image(systemName: "chevron.right.2")
//                            .foregroundColor(.colorNeavyBlue)
//                            .font(.system(size: 24, weight: .bold))
//                    }
//                    .offset(x: buttonOffset)
//                    .gesture (
//                        DragGesture()
//                            .onChanged({ gesture in
//                                let drag = gesture.translation.width
//                                if drag > 0 && drag < buttonWidth - 60 {
//                                    buttonOffset = drag
//                                }
//                            })
//                            .onEnded({ _ in
//                                if buttonOffset > buttonWidth / 2 {
//                                    buttonOffset = buttonWidth - 60
//                                    if strStatus == "Notify Arrived" {
//                                        strStatus = "Start Pickup"
//                                        buttonOffset = 0
//                                    } else if strStatus == "Start Pickup" {
//                                        strStatus = "Passenger Picked"
//                                        buttonOffset = 0
//                                    } else if strStatus == "Passenger Picked" {
//                                        strStatus = "Start to Drop-off"
//                                        buttonOffset = 0
//                                    } else if strStatus == "Start to Drop-off" {
//                                        strStatus = "Drop-off Completed"
//                                        buttonOffset = 0
//                                    } else {
//                                        showingPopup = true
//                                    }
//                                } else {
//                                    buttonOffset = 0
//                                }
//                            })
//                    )
//
//                    Spacer()
//                }
//                .frame(width: buttonWidth - 16, height: 60)
//
//                Text(strStatus)
//                    .font(.customfont(.semiBold, fontSize: 16))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .offset(x: 20)
//
//            }
//            .frame(width: buttonWidth, height: 60)
//
////            HStack {
////                Spacer()
////                CustomButtonAction(title: "Cancel", color: .red, titleColor: .white) {
////                    print("cancel this")
////                }
////                Spacer()
////            }
//
//
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//    }
//}
