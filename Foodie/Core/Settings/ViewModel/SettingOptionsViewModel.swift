//
//  SettingOptionsViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 17.08.24.
//

import SwiftUI

protocol SettingsViewModelProtocol: CaseIterable {
    var title: String { get }
    var imageName: String { get }
    var imageBackgroundColor: UIColor { get }
}

enum AccountOptionsViewModel: Int, SettingsViewModelProtocol {
    case makeMoneyDriving
    case earnings
    case signout
    
    var title: String {
        switch self {
        case .makeMoneyDriving: return "Make money driving"
        case .earnings: return "Your earnings"
        case .signout: return "Sign out"
        }
    }
    
    var imageName: String {
        switch self {
        case .makeMoneyDriving, .earnings: return "dollarsign.square.fill"
        case .signout: return "arrow.left.square.fill"
        }
    }
    
    var imageBackgroundColor: UIColor {
        switch self {
        case .makeMoneyDriving, .earnings: return .systemGreen
        case .signout: return .systemRed
        }
    }
    
    static func optionsForUser(_ user: User) -> [AccountOptionsViewModel] {
        if user.isDriver {
            return [.earnings, .signout]
        } else {
            return [.makeMoneyDriving, .signout]
        }
    }
}
