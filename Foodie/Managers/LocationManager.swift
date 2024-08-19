//
//  LocationManager.swift
//  Foodie
//
//  Created by Muhedin Alic on 14.08.24.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    static let shared = LocationManager()
    
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        locationManager.stopUpdatingLocation() // Stop updates if you only need one location fix
        print("User location: \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        
        switch status {
        case .notDetermined:
            print("Location permission not determined")
        case .restricted, .denied:
            print("Location permission denied/restricted")
            // Handle the case where location permission is denied or restricted
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission granted")
            locationManager.startUpdatingLocation() // Start location updates
        @unknown default:
            print("Unknown location authorization status")
        }
    }
}

// MARK: - Reverse Geocoding of user current location

extension LocationManager {
    func reverseGeocode(completion: @escaping (String) -> Void) {
        guard let userLocation = self.userLocation else {
            completion("Trouble finding the address")
            return
        }
        
        geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error in reverse geocoding: \(error.localizedDescription)")
                    completion("Trouble finding the address")
                    return
                }

                if let placemark = placemarks?.first {
                    let formattedAddress = [
                        placemark.name,
                        placemark.locality,
                        placemark.administrativeArea,
                        placemark.country
                    ].compactMap { $0 }.joined(separator: ", ")

                    completion(formattedAddress.isEmpty ? "Address not found." : formattedAddress)
                } else {
                    completion("Trouble finding the address")
                }
            }
        }
    }
}

