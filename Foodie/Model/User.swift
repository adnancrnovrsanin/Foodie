//
//  User.swift
//  Foodie
//
//  Created by Muhedin Alic on 06.08.24.
//

import Foundation
import Firebase

public struct User: Codable, Identifiable, Hashable {
    public var id: String
    public var fullname: String
    public let email: String
    public var phoneNumber: String?
    public var profileImageUrl: String?
    public var homeLocation: SavedLocation?
    public var workLocation: SavedLocation?
    public var isDriver: Bool = false
    public var coordinates: GeoPoint
    public var isActive: Bool
}

public struct SavedLocation: Codable, Hashable {
    public let title: String
    public let address: String
    public let latitude: Double
    public let longitude: Double
}
