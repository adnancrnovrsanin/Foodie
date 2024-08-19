//
//  Meal.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public struct Meal: Codable, Hashable, Identifiable {
    public var id: String
    public var name: String
    public var description: String
    public var imageUrl: String
    public var price: Money
    public var category: FoodCategory
}
