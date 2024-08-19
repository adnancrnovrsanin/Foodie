//
//  HomeViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseAuth
import SwiftUI

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var user: User?
    @Published var restaurants: [Restaurant] = []
    
    var didExecuteFetchDrivers = false
    var userLocation: CLLocationCoordinate2D?

    // MARK: - Lifecycle
    
    init() {
        fetchUser()
        fetchAndSeedRestaurants()
    }
}

// MARK: - Shared API

extension HomeViewModel {
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        UserService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
}

// MARK: - Fetch all restaurants and seed them if there are none

extension HomeViewModel {
    private func fetchAndSeedRestaurants() {
        COLLECTION_RESTAURANTS.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching restaurants: \(error.localizedDescription)")
                return
            }

            guard let snapshot = snapshot, snapshot.isEmpty else {
                // If there are restaurants already present, load them into the restaurants property
                self.restaurants = snapshot?.documents.compactMap { try? $0.data(as: Restaurant.self) } ?? []
                return
            }

            for restaurant in dbRestaurants {
                do {
                    let _ = try COLLECTION_RESTAURANTS.addDocument(from: restaurant)
                } catch {
                    print("Error seeding restaurant: \(error.localizedDescription)")
                }
            }
        }
    }
}

