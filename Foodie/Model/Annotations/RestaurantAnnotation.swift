//
//  RestaurantAnnotation.swift
//  Foodie
//
//  Created by Muhedin Alic on 14.08.24.
//

import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var id: String
    
    init(coordinate: CLLocationCoordinate2D, id: String) {
        self.coordinate = coordinate
        self.id = id
    }
    
    func updatePosition(withCoordinate coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.2) {
            self.coordinate = coordinate
        }
    }
}
