//
//  Money.swift
//  Foodie
//
//  Created by Muhedin Alic on 09.08.24.
//

import Foundation

public struct Money: Codable, Hashable {
    public enum Currency: String, Codable {
      case USD, EUR, GBP, CNY // supported currencies here
    }
    public var amount: Decimal
    public var currency: Currency
    public var formatedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        // Convert Decimal to NSDecimalNumber for formatting
        let nsDecimal = NSDecimalNumber(decimal: amount)
        
        return formatter.string(from: nsDecimal) ?? "\(currency.rawValue)\(amount)"
    }
    
    public init(amount: Decimal, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
}
