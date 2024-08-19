//
//  MapViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 14.08.24.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to generate polyline with error \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            completion(route)
        }
    }
}
