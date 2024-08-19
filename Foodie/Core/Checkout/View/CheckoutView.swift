//
//  CheckoutView.swift
//  Foodie
//
//  Created by Muhedin Alic on 14.08.24.
//

import SwiftUI
import CoreLocation

struct CheckoutView: View {
    
    let orderId: String
    @State private var showSheet = false
    
    @Binding var isOrdered: Bool
    
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    
    var body: some View {
        if let order = restaurantViewModel.orders.first(where: { $0.id == orderId }) {
            ZStack {
                MapViewRepresentable(coordinate: CLLocationCoordinate2D(latitude: order.restaurant.location.latitude, longitude: order.restaurant.location.longitude), bottomM: 500)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    if showSheet {
                        CheckoutSheetView(orderId: orderId, isOrdered: $isOrdered)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
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


#Preview {
    CheckoutView(orderId: sampleOrder.id, isOrdered: .constant(false))
}
