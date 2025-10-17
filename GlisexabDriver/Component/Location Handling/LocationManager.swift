//
//  LocationManager.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import Foundation
import CoreLocation
import MapKit
internal import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    var objectWillChange: ObservableObjectPublisher
    
    private let manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // ✅ Delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
}
