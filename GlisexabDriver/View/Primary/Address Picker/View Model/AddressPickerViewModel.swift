//
//  AddressPickerViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//


import Foundation
import MapKit
internal import Combine

protocol Address {
    func didSelectAddress(result: Result<LocationData, LocationError>)
}

class AddressSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var queryFragment: String = "" {
        didSet {
            completer.queryFragment = queryFragment
        }
    }
    
    @Published var results: [MKLocalSearchCompletion] = []
    var delegate: Address?

    private var completer: MKLocalSearchCompleter

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error fetching autocomplete results: \(error.localizedDescription)")
    }
        
    func selectAddress(_ completion: MKLocalSearchCompletion, handler: (()->())?) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            if let placemark = response?.mapItems.first?.placemark {
                
                let state = placemark.administrativeArea
                let city = placemark.locality ?? placemark.subAdministrativeArea
                let coordinate = placemark.coordinate
                
                let objLocationData = LocationData(address: completion.subtitle,
                                                   city: city,
                                                   state: state,
                                                   latitude: coordinate.latitude,
                                                   longitude: coordinate.longitude)
                self?.delegate?.didSelectAddress(result: .success(objLocationData))
                handler?()
            } else {
                print("Location not found: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
