//
//  MapViewRepresentable.swift
//  Foodie
//
//  Created by Muhedin Alic on 14.08.24.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    let mapView = MKMapView()
    let coordinate: CLLocationCoordinate2D?
    let bottomM: Int
    
    @EnvironmentObject var mapViewModel: MapViewModel
    
    // MARK: - Protocol Functions
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.isRotateEnabled = false
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Clear the map before updating
        context.coordinator.clearMapView()
        
        if let coordinate = coordinate, let userLocation = context.coordinator.userLocation {
            context.coordinator.addAnnotationAndGeneratePolyline(withCoordinate: coordinate)
        } else {
            // If user location is not available, consider showing a loading indicator or a message
            print("User location is not yet available")
        }
    }

    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self, bottomM: bottomM)
    }
}

extension MapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        let parent: MapViewRepresentable
        var currentRegion: MKCoordinateRegion?
        var userLocation: MKUserLocation?
        let bottomM: Int
        
        // MARK: - Lifecycle
        
        init(parent: MapViewRepresentable, bottomM: Int) {
            self.parent = parent
            self.bottomM = bottomM
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocation = userLocation
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
            
            // Generate polyline once the user location is available
            if let coordinate = parent.coordinate {
                addAnnotationAndGeneratePolyline(withCoordinate: coordinate)
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = .red // You can customize the color
            polylineRenderer.lineWidth = 6
            return polylineRenderer
        }
        
        func addAnnotationAndGeneratePolyline(withCoordinate coordinate: CLLocationCoordinate2D) {
            // Clear existing annotations and overlays
            clearMapView()

            // Add the new annotation
            addAndSelectAnnotation(withCoordinate: coordinate)
            
            // Generate and add the polyline
            configurePolyline(withDestinationCoordinate: coordinate)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocation = self.userLocation else { return }
            
            self.parent.mapViewModel.getDestinationRoute(from: userLocation.coordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                               edgePadding: .init(top: 64, left: 32, bottom: CGFloat(self.bottomM), right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.parent.mapView.addAnnotation(annotation)
            self.parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func clearMapView() {
            // Remove existing annotations and overlays
            let nonUserAnnotations = parent.mapView.annotations.filter { !($0 is MKUserLocation) }
            parent.mapView.removeAnnotations(nonUserAnnotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            // Reset the region if needed
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}

#Preview {
    MapViewRepresentable(coordinate: CLLocationCoordinate2D(latitude: sampleOrder.restaurant.location.latitude, longitude: sampleOrder.restaurant.location.longitude), bottomM: 500)
        .environmentObject(MapViewModel())
}

