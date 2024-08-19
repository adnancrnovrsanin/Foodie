//
//  DeliveryView.swift
//  Foodie
//
//  Created by Muhedin Alic on 18.08.24.
//

import SwiftUI
import CoreLocation

struct DeliveryView: View {
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    
    var body: some View {
        Group {
            if checkoutViewModel.myDelivery == nil {
                AcceptDeliveriesView()
            } else if let delivery = checkoutViewModel.myDelivery {
                if delivery.status == .ACTIVE {
                    ToRestaurantDeliveryView()
                } else if delivery.status == .PACKAGE_ACCEPTED {
                    ToDeliveryLocationView()
                }
            }
        }
    }
}

#Preview {
    DeliveryView()
        .environmentObject(CheckoutViewModel())
}
