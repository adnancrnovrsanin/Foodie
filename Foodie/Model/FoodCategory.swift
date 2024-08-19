//
//  RestaurantCategory.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public enum FoodCategory: Int, CaseIterable, Identifiable, Codable {
    case grill
    case pizza
    case sandwich
    case fastFood
    case international
    case chicken
    case traditional
    case burgers
    case drinks
    case pasta
    case salads
    case breakfast
    case seafood
    
    public var id: Int { return rawValue }
    
    public var description: String {
        switch self {
        case .grill: return "Grill"
        case .pizza: return "Pizza"
        case .sandwich: return "Sandwich"
        case .fastFood: return "Fast Food"
        case .international: return "International"
        case .chicken: return "Chicken"
        case .traditional: return "Traditional"
        case .burgers: return "Burgers"
        case .drinks: return "Drinks"
        case .pasta: return "Pasta"
        case .salads: return "Salads"
        case .breakfast: return "Breakfast"
        case .seafood: return "Seafood"
        }
    }
    
    public var imageName: String {
        switch self {
        case .grill: return "grill"
        case .pizza: return "pizza"
        case .sandwich: return "sandwich"
        case .fastFood: return "fast-food"
        case .international: return "international"
        case .chicken: return "chicken"
        case .traditional: return "traditional"
        case .burgers: return "burgers"
        case .drinks: return "drinks"
        case .pasta: return "pasta"
        case .salads: return "salads"
        case .breakfast: return "breakfast"
        case .seafood: return "seafood"
        }
    }
}
