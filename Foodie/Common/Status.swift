//
//  Status.swift
//  Foodie
//
//  Created by Muhedin Alic on 11.08.24.
//

import Foundation
import SwiftUI

public enum Status: Int, CaseIterable, Identifiable, Codable {
    case CREATED
    case ACTIVE
    case PACKAGE_ACCEPTED
    case COMPLETED
    case CANCELED
    
    public var id: Int { return rawValue }
    
    public var description: String {
        switch self {
        case .CREATED: return "Waiting for confirmation..."
        case .ACTIVE: return "Your order is being prepared"
        case .PACKAGE_ACCEPTED: return "Order is coming your way!"
        case .CANCELED: return "Oops! There was a problem with your delivery."
        case .COMPLETED: return "Package delivered! Hope you are happy!"
        }
    }
    
    public var tag: String {
        switch self {
        case .CREATED: return "WAITING"
        case .ACTIVE: return "ACTIVE"
        case .PACKAGE_ACCEPTED: return "ACTIVE"
        case .CANCELED: return "CANCELED"
        case .COMPLETED: return "COMPLETED"
        }
    }
    
    public var color: Color {
        switch self {
        case .CREATED: return Color.gray
        case .ACTIVE: return Color.blue
        case .PACKAGE_ACCEPTED: return Color.blue
        case .CANCELED: return Color.red
        case .COMPLETED: return Color.green
        }
    }
}
