//
//  Checkout.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public struct Checkout: Codable, Identifiable, Hashable {
    public var id: String
    public var order: Order
    public var restaurant: Restaurant
    public var requestUtensils: Bool
    public var deliveryLocation: DeliveryLocation
    public var deliveryInstructions: String?
    public var appointedDeliverer: User?
    public var status: Status = .CREATED
    public var contactPhoneNumber: String
    public var timestamp: Date
    
    // Implementacija za Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(order)
        hasher.combine(restaurant)
        hasher.combine(requestUtensils)
        hasher.combine(deliveryLocation)
        hasher.combine(deliveryInstructions)
        hasher.combine(appointedDeliverer)
        hasher.combine(status)
        hasher.combine(contactPhoneNumber)
        hasher.combine(timestamp)
    }
    
    // Implementacija za Ekvivalentnost
    public static func == (lhs: Checkout, rhs: Checkout) -> Bool {
        return lhs.id == rhs.id &&
               lhs.order == rhs.order &&
               lhs.restaurant == rhs.restaurant &&
               lhs.requestUtensils == rhs.requestUtensils &&
               lhs.deliveryLocation == rhs.deliveryLocation &&
               lhs.deliveryInstructions == rhs.deliveryInstructions &&
               lhs.appointedDeliverer == rhs.appointedDeliverer &&
               lhs.status == rhs.status &&
               lhs.contactPhoneNumber == rhs.contactPhoneNumber &&
               lhs.timestamp == rhs.timestamp
    }
    
    // Inicijalizator
    public init(id: String = UUID().uuidString,
                order: Order,
                restaurant: Restaurant,
                requestUtensils: Bool,
                deliveryLocation: DeliveryLocation,
                deliveryInstructions: String? = nil,
                appointedDeliverer: User? = nil,
                status: Status = .CREATED,
                contactPhoneNumber: String,
                timestamp: Date = Date()) {
        self.id = id
        self.order = order
        self.restaurant = restaurant
        self.requestUtensils = requestUtensils
        self.deliveryLocation = deliveryLocation
        self.deliveryInstructions = deliveryInstructions
        self.appointedDeliverer = appointedDeliverer
        self.status = status
        self.contactPhoneNumber = contactPhoneNumber
        self.timestamp = timestamp
    }
}

public struct DeliveryLocation: Codable, Hashable {
    public var address: String
    public var latitude: Double
    public var longitude: Double
    
    public init(address: String, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
