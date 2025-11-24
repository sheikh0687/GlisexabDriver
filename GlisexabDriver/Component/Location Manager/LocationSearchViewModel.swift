//
//  LocationSearchViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import SwiftUI
import MapKit
internal import Combine

enum LocationError: Error {
    case permissionDenied
    case permissionRestricted
    case locationServicesDisabled
    case locationFetchFailed
    case unknownError
    case custom(message: String)
    
    var isRecoverable: Bool {
        switch self {
        case .locationServicesDisabled,
                .permissionDenied:
            return true
        case .permissionRestricted,
                .locationFetchFailed,
                .unknownError:
            return false
        case .custom:
            return false
        }
    }
    
    var userMessage: String {
        switch self {
        case .permissionDenied:
            return "Location access is denied. To continue, please enable it in Settings > Privacy & Security > Location Services, or tap HERE to go to Settings. You can also enter your location manually."
        case .permissionRestricted:
            return "Location access is restricted and cannot be changed. Please enter your location manually."
        case .locationServicesDisabled:
            return "Location services are turned off. Please enable it in Settings > Privacy & Security > Location Services, or tap HERE to go to Settings. You can also enter your location manually."
        case .locationFetchFailed:
            return "Failed to fetch location. Please tap the location button to retry or enter your location manually."
        case .unknownError:
            return "An unknown error occurred while getting your location. Please try again."
        case .custom(let message):
            return message
        }
    }
}

class LocationSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate, CLLocationManagerDelegate {
    @Published var pickupAddress: String = ""
    @Published var dropoffAddress: String = ""
    @Published var searchText: String = ""
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var route: MKRoute?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var pickupCoordinate: CLLocationCoordinate2D? {
        didSet { scheduleRouteUpdate() }
    }
    @Published var dropoffCoordinate: CLLocationCoordinate2D? {
        didSet { scheduleRouteUpdate() }
    }
    @Published var didSetInitialLocation = false

    private var completion: ((Result<LocationData, LocationError>) -> Void)?
    private var completer = MKLocalSearchCompleter()
    private var cancellables = Set<AnyCancellable>()
    private var locationManager = CLLocationManager()

    // For throttling route updates
    private var routeUpdateWorkItem: DispatchWorkItem?

    // Store ongoing directions requests to cancel if needed
    private var currentDirectionsRequest: MKDirections?

    override init() {
        super.init()
        completer.resultTypes = .address
        completer.delegate = self

        $searchText
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.completer.queryFragment = text
            }
            .store(in: &cancellables)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async { [weak self] in
            self?.searchResults = completer.results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Add error handling if needed
    }

    func selectCompletion(_ completion: MKLocalSearchCompletion, isPickup: Bool) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate,
                  let placemark = response?.mapItems.first?.placemark else { return }
            let fullAddress = [placemark.name,
                               placemark.subThoroughfare,
                               placemark.thoroughfare,
                               placemark.locality,
                               placemark.administrativeArea,
                               placemark.postalCode,
                               placemark.country]
                .compactMap { $0 }
                .joined(separator: ", ")
            DispatchQueue.main.async {
                if isPickup {
                    self?.pickupAddress = fullAddress
                    self?.pickupCoordinate = coordinate
                } else {
                    self?.dropoffAddress = fullAddress
                    self?.dropoffCoordinate = coordinate
                }
            }
        }
    }

    // Defer route calculation for 0.5s after last coordinate update to throttle multi changes
    private func scheduleRouteUpdate() {
        routeUpdateWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.updateRoute()
        }
        routeUpdateWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }

    func updateRoute() {
        guard let pickupCoordinate = pickupCoordinate,
              let dropoffCoordinate = dropoffCoordinate,
              !pickupCoordinate.latitude.isNaN && !pickupCoordinate.longitude.isNaN,
              !dropoffCoordinate.latitude.isNaN && !dropoffCoordinate.longitude.isNaN else { return }

        // Cancel ongoing request if any
        currentDirectionsRequest?.cancel()

        let pickupPlacemark = MKPlacemark(coordinate: pickupCoordinate)
        let dropoffPlacemark = MKPlacemark(coordinate: dropoffCoordinate)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: pickupPlacemark)
        directionRequest.destination = MKMapItem(placemark: dropoffPlacemark)
        directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)
        currentDirectionsRequest = directions

        directions.calculate { [weak self] response, error in
            guard let route = response?.routes.first else { return }
            DispatchQueue.main.async {
                self?.route = route
                self?.region = MKCoordinateRegion(center: pickupCoordinate,
                                                  span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                self?.currentDirectionsRequest = nil
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate

        DispatchQueue.main.async { [weak self] in
            self?.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            guard let self = self else { return }

            if !self.didSetInitialLocation {
                self.didSetInitialLocation = true
                self.pickupCoordinate = coordinate

                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let placemark = placemarks?.first {
                        let address = [placemark.name,
                                       placemark.subThoroughfare,
                                       placemark.thoroughfare,
                                       placemark.locality,
                                       placemark.administrativeArea,
                                       placemark.country]
                            .compactMap { $0 }
                            .joined(separator: ", ")
                        DispatchQueue.main.async {
                            self.pickupAddress = address
                        }
                    }
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }

    func getLocation(completion: @escaping (Result<LocationData, LocationError>) -> Void) {
        self.completion = completion

        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                DispatchQueue.main.async {
                    completion(.failure(.locationServicesDisabled))
                }
                return
            }

            let status = self.locationManager.authorizationStatus
            DispatchQueue.main.async {
                switch status {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    completion(.failure(.permissionRestricted))
                case .denied:
                    completion(.failure(.permissionDenied))
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.requestLocation()
                @unknown default:
                    completion(.failure(.unknownError))
                }
            }
        }
    }
}


//class LocationSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate, CLLocationManagerDelegate {
//    @Published var pickupAddress: String = ""
//    @Published var dropoffAddress: String = ""
//    @Published var searchText: String = ""
//    @Published var searchResults: [MKLocalSearchCompletion] = []
//    @Published var route: MKRoute?
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    @Published var pickupCoordinate: CLLocationCoordinate2D?
//    @Published var dropoffCoordinate: CLLocationCoordinate2D?
//    @Published var didSetInitialLocation = false
//    
//    private var completion: ((Result<LocationData, LocationError>) -> Void)?
//    private var completer = MKLocalSearchCompleter()
//    private var cancellables = Set<AnyCancellable>()
//    private var locationManager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        completer.resultTypes = .address
//        completer.delegate = self
//        
//        $searchText
//            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
//            .sink { [weak self] text in
//                self?.completer.queryFragment = text
//            }
//            .store(in: &cancellables)
//        
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        DispatchQueue.main.async { [weak self] in
//            self?.searchResults = completer.results
//        }
//    }
//    
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        // Optional: Add error handling logic here if required
//    }
//    
//    func selectCompletion(_ completion: MKLocalSearchCompletion, isPickup: Bool) {
//        let searchRequest = MKLocalSearch.Request(completion: completion)
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { [weak self] response, error in
//            guard let coordinate = response?.mapItems.first?.placemark.coordinate,
//                  let placemark = response?.mapItems.first?.placemark else { return }
//            let fullAddress = [placemark.name,
//                               placemark.subThoroughfare,
//                               placemark.thoroughfare,
//                               placemark.locality,
//                               placemark.administrativeArea,
//                               placemark.postalCode,
//                               placemark.country]
//                .compactMap { $0 }
//                .joined(separator: ", ")
//            DispatchQueue.main.async {
//                if isPickup {
//                    self?.pickupAddress = fullAddress
//                    self?.pickupCoordinate = coordinate
//                } else {
//                    self?.dropoffAddress = fullAddress
//                    self?.dropoffCoordinate = coordinate
//                }
//                self?.updateRoute()
//            }
//        }
//    }
//    
//    func updateRoute() {
//        guard let pickupCoordinate = pickupCoordinate,
//              let dropoffCoordinate = dropoffCoordinate,
//              !pickupCoordinate.latitude.isNaN && !pickupCoordinate.longitude.isNaN,
//              !dropoffCoordinate.latitude.isNaN && !dropoffCoordinate.longitude.isNaN else { return }
//        let pickupPlacemark = MKPlacemark(coordinate: pickupCoordinate)
//        let dropoffPlacemark = MKPlacemark(coordinate: dropoffCoordinate)
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = MKMapItem(placemark: pickupPlacemark)
//        directionRequest.destination = MKMapItem(placemark: dropoffPlacemark)
//        directionRequest.transportType = .automobile
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate { [weak self] response, error in
//            guard let route = response?.routes.first else { return }
//            DispatchQueue.main.async {
//                self?.route = route
//                self?.region = MKCoordinateRegion(center: pickupCoordinate,
//                                                  span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
//            }
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let coordinate = location.coordinate
//        DispatchQueue.main.async { [weak self] in
//            self?.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            if !(self?.didSetInitialLocation ?? true) {
//                self?.didSetInitialLocation = true
//                self?.pickupCoordinate = coordinate
//                let geocoder = CLGeocoder()
//                geocoder.reverseGeocodeLocation(location) { placemarks, error in
//                    if let placemark = placemarks?.first {
//                        let address = [placemark.name,
//                                       placemark.subThoroughfare,
//                                       placemark.thoroughfare,
//                                       placemark.locality,
//                                       placemark.administrativeArea,
//                                       placemark.country]
//                            .compactMap { $0 }
//                            .joined(separator: ", ")
//                        DispatchQueue.main.async {
//                            self?.pickupAddress = address
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to get location: \(error.localizedDescription)")
//    }
//    
//    func getLocation(completion: @escaping (Result<LocationData, LocationError>) -> Void) {
//        self.completion = completion
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard CLLocationManager.locationServicesEnabled() else {
//                DispatchQueue.main.async {
//                    completion(.failure(.locationServicesDisabled))
//                }
//                return
//            }
//            let status = self.locationManager.authorizationStatus
//            DispatchQueue.main.async {
//                switch status {
//                case .notDetermined:
//                    self.locationManager.requestWhenInUseAuthorization()
//                case .restricted:
//                    completion(.failure(.permissionRestricted))
//                case .denied:
//                    completion(.failure(.permissionDenied))
//                case .authorizedWhenInUse, .authorizedAlways:
//                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                    self.locationManager.requestLocation()
//                @unknown default:
//                    completion(.failure(.unknownError))
//                }
//            }
//        }
//    }
//}
