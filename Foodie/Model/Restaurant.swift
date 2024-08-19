//
//  Restaurant.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public struct Restaurant : Codable, Hashable, Identifiable {
    public var id: String
    public var name: String
    public var deliveryTime: String
    public var restaurantImage: String
    public var rating: Double
    public var location: RestaurantLocation
    public var categories: [FoodCategory]
    public var meals: [Meal]
    
    public func returnMealsByCategory() -> [FoodCategory: [Meal]] {
        var mealsByCategory: [FoodCategory: [Meal]] = [:]
        
        for category in categories {
            let mealsInCategory = meals.filter { $0.category == category }
            mealsByCategory[category] = mealsInCategory
        }
        
        return mealsByCategory
    }
}

public struct RestaurantLocation: Codable, Hashable {
    public var address: String
    public var latitude: Double
    public var longitude: Double
    
    public init(address: String, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
