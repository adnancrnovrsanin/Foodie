//
//  EarningsData.swift
//  Foodie
//
//  Created by Muhedin Alic on 19.08.24.
//

import Foundation

public struct EarningsData: Identifiable {
    public let id = UUID()
    public var date: Date
    public var earnings: Money
}
