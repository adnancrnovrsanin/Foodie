//
//  ToRestaurantDeliveryView.swift
//  Foodie
//
//  Created by Muhedin Alic on 18.08.24.
//

import SwiftUI
import CoreLocation

struct ToRestaurantDeliveryView: View {
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        Group {
            if let delivery = checkoutViewModel.myDelivery {
                ZStack {
                    MapViewRepresentable(coordinate: CLLocationCoordinate2DMake(delivery.restaurant.location.latitude, delivery.restaurant.location.longitude), bottomM: 400)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        if showSheet {
                            ToRestaurantSheetView()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                                .background(Color.theme.backgroundColor)
                                .cornerRadius(20, corners: [.topLeft, .topRight]) // Apply rounded corners to the top edges
                                .shadow(radius: 10) // Optional: Add shadow for better visual appearance
                                .transition(.move(edge: .bottom)) // Use transition for the appearance animation
                                .animation(.spring(), value: showSheet) // Apply spring animation
                        }
                    }
                }
                .onAppear {
                    withAnimation {
                        showSheet = true
                    }
                }
            }
        }
    }
}

#Preview {
    ToRestaurantDeliveryView()
}
