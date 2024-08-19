//
//  Order.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public struct Order: Codable, Identifiable, Hashable {
    public var id: String
    public var userId: String
    public var items: [OrderItem]
    public var restaurant: Restaurant
    public var total_amount: Money {
        get {
            var sum: Decimal = 0.0;
            for item in items {
                sum += item.total_amount.amount
            }
            return Money(amount: sum, currency: .USD)
        }
    }
    public var total_meal_count: Int {
        get {
            var sum: Int = 0
            for item in items {
                sum += item.quantity
            }
            return sum
        }
    }
    public var status: Status = Status.ACTIVE
}

public struct OrderItem: Codable, Identifiable, Hashable {
    public var id: String
    public var meal: Meal
    public var quantity: Int
    public var total_amount: Money{
        get{
            let individualPrice = NSDecimalNumber(decimal: meal.price.amount)
            let quantityNSD = NSDecimalNumber(decimal: Decimal(quantity))
            let nsdec = individualPrice.multiplying(by:quantityNSD)
            return Money(amount: nsdec.decimalValue, currency: .USD)
        }
    }
}
