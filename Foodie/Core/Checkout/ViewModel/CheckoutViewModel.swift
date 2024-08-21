//
//  CheckoutViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 15.08.24.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI
import Combine

class CheckoutViewModel: ObservableObject {
    @Published public var checkouts: [Checkout] = []
    @Published public var completedCheckouts: [Checkout] = []
    @Published public var user: User?
    @Published public var myDelivery: Checkout?
    
    // MARK: - Helper properties
    
    var totalEarnings: Money {
        let totalAmount = completedCheckouts.filter { $0.status == .COMPLETED }
            .reduce(Decimal(0)) { $0 + $1.order.total_amount.amount }
        return Money(amount: totalAmount, currency: .USD)
    }
    
    var lostEarnings: Money {
        let lostAmount = completedCheckouts.filter { $0.status == .CANCELED }
            .reduce(Decimal(0)) { $0 + $1.order.total_amount.amount }
        return Money(amount: lostAmount, currency: .USD)
    }
    
    var successfulOrdersCount: Int {
        completedCheckouts.filter { $0.status == .COMPLETED }.count
    }
    
    var canceledOrdersCount: Int {
        completedCheckouts.filter { $0.status == .CANCELED }.count
    }
    
    var earningsOverTime: [EarningsData] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return completedCheckouts
            .filter { $0.status == .COMPLETED }
            .map { checkout in
                EarningsData(date: formatter.date(from: formatter.string(from: checkout.timestamp))!, earnings: checkout.order.total_amount)
            }
    }

    private var cancellables: Set<AnyCancellable> = []
    
    public init(checkouts: [Checkout]) {
        self.checkouts = checkouts
    }

    public init() {
        fetchUser()
        $user
            .compactMap { $0 }
            .sink { [weak self] u in
                guard let self = self, u != nil else { return }
                if u.isDriver {
                    self.listenForCreatedCheckoutsForDriver(user: u)
                    self.listenForCompletedCheckoutsForDriver(user: u)
                    self.listenForMyCurrentDelivery(user: u)
                } else {
                    self.listenForActiveAndUpdatedCheckoutsForUser(user: u)
                    self.listenForCompletedCheckoutsForUser(user: u)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Create a New Checkout
        public func createNewCheckout(deliveryInstructions: String, utensilsRequested: Bool, contactPhoneNumber: String, order: Order) {
            guard let currentUser = Auth.auth().currentUser?.uid,
                  let userLocation = LocationManager.shared.userLocation else {
                print("DEBUG: Location or user is missing.")
                return
            }
            
            LocationManager.shared.reverseGeocode { [weak self] address in
                guard let self = self else { return }
                
                let newCheckout = Checkout(
                    order: order,
                    restaurant: order.restaurant,
                    requestUtensils: utensilsRequested,
                    deliveryLocation: DeliveryLocation(address: address, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), 
                    deliveryInstructions: deliveryInstructions,
                    contactPhoneNumber: contactPhoneNumber
                )
                
                guard let encodedCheckout = try? Firestore.Encoder().encode(newCheckout) else {
                    print("DEBUG: Failed to encode checkout data.")
                    return
                }
                
                COLLECTION_CHECKOUTS.document(newCheckout.id).setData(encodedCheckout) { error in
                    if let error = error {
                        print("DEBUG: Failed to save checkout: \(error.localizedDescription)")
                    }
                }
            }
        }

    // MARK: - Real-Time Slušanje za Korisnika (naručioca)
    private func listenForActiveAndUpdatedCheckoutsForUser(user: User) {
        COLLECTION_CHECKOUTS
            .whereField("order.userId", isEqualTo: user.id)
            .whereField("status", in: [Status.ACTIVE.rawValue, Status.PACKAGE_ACCEPTED.rawValue, Status.CREATED.rawValue])
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching active checkouts: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                // Kada se dokument promeni, ažuriraj korisnikov niz `checkouts`
                self.checkouts = documents.compactMap { try? $0.data(as: Checkout.self) }
            }
    }

    private func listenForCompletedCheckoutsForUser(user: User) {
        COLLECTION_CHECKOUTS
            .whereField("order.userId", isEqualTo: user.id)
            .whereField("status", in: [Status.COMPLETED.rawValue, Status.CANCELED.rawValue])
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching completed checkouts: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                self.completedCheckouts = documents.compactMap { try? $0.data(as: Checkout.self) }
            }
    }

    // MARK: - Real-Time Slušanje za Dostavljača
    private func listenForCreatedCheckoutsForDriver(user: User) {
        COLLECTION_CHECKOUTS
            .whereField("status", isEqualTo: Status.CREATED.rawValue)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching created checkouts: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                
                // Filtriraj na strani klijenta
                self.checkouts = documents.compactMap { doc in
                    let checkout = try? doc.data(as: Checkout.self)
                    return checkout?.appointedDeliverer == nil ? checkout : nil
                }
                self.listenForMyCurrentDelivery(user: user)
            }
    }


    private func listenForCompletedCheckoutsForDriver(user: User) {
        COLLECTION_CHECKOUTS
            .whereField("appointedDeliverer.email", isEqualTo: user.email)
            .whereField("status", in: [Status.COMPLETED.rawValue, Status.CANCELED.rawValue])
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching completed checkouts for driver: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                self.completedCheckouts = documents.compactMap { try? $0.data(as: Checkout.self) }
            }
    }

    private func listenForMyCurrentDelivery(user: User) {
        COLLECTION_CHECKOUTS
            .whereField("appointedDeliverer.email", isEqualTo: user.email)
            .whereField("status", in: [Status.CREATED.rawValue, Status.ACTIVE.rawValue, Status.PACKAGE_ACCEPTED.rawValue])
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching current delivery: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                self.myDelivery = documents.compactMap { try? $0.data(as: Checkout.self) }.first
            }
    }

    // MARK: - Helper Methods for Checkout Status Updates
    public func acceptDelivery(checkout: Checkout) {
        guard let currentUser = Auth.auth().currentUser?.uid, let user = self.user, let checkoutIndex = self.checkouts.firstIndex(where: { $0.id == checkout.id }) else { return }
        
        if checkout.appointedDeliverer == nil, checkout.status == .CREATED, user.isDriver {
            var newCheckout = checkout
            newCheckout.status = .ACTIVE
            newCheckout.appointedDeliverer = user
            
            self.checkouts[checkoutIndex] = newCheckout
            self.myDelivery = newCheckout
            
            saveCheckoutsToFirestore()
        }
    }

    public func acceptThePackageFromRestaurant() {
        updateMyDeliveryStatus(to: .PACKAGE_ACCEPTED)
    }
    
    public func deliverThePackage() {
        updateMyDeliveryStatus(to: .COMPLETED)
    }
    
    public func cancelTheDelivery() {
        updateMyDeliveryStatus(to: .CANCELED)
    }

    private func updateMyDeliveryStatus(to newStatus: Status) {
        guard var delivery = self.myDelivery else { return }
        
        delivery.status = newStatus
        
        guard let encodedCheckout = try? Firestore.Encoder().encode(delivery) else { return }
        
        COLLECTION_CHECKOUTS.document(delivery.id).setData(encodedCheckout) { error in
            if let error = error {
                print("DEBUG: Failed to save order changes: \(error.localizedDescription)")
            } else {
                if newStatus == .COMPLETED || newStatus == .CANCELED {
                    self.myDelivery = nil
                } else {
                    self.myDelivery = delivery
                }
            }
        }
    }

    private func saveCheckoutsToFirestore() {
        for checkout in self.checkouts {
            guard let encodedCheckout = try? Firestore.Encoder().encode(checkout) else { return }
            
            COLLECTION_CHECKOUTS.document(checkout.id).setData(encodedCheckout) { error in
                if let error = error {
                    print("DEBUG: Failed to save order changes: \(error.localizedDescription)")
                }
            }
        }
    }

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user's orders \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, !snapshot.isEmpty else { return }
            
            self.user = snapshot.documents.compactMap { try? $0.data(as: User.self) }.first { $0.id == uid }
        }
    }
}
