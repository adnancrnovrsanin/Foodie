//
//  CheckOut.swift
//  Foodie
//
//  Created by Muhedin Alic on 08.08.24.
//

import SwiftUI
import Kingfisher

struct OrderView: View {
    @State private var isSheetPresented = false
    @State private var selectedItem: OrderItem?
    @State private var isOrdered: Bool = false
    
    @EnvironmentObject var navBarViewModel: NavBarViewModel
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    let orderId: String
    
    var body: some View {
        if var order = restaurantViewModel.orders.first(where: { $0.id == orderId }) {
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    Text("Your order from:")
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.primaryTextColor)
                    Text(order.restaurant.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.primaryTextColor)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                VStack {
                    VStack(spacing: 25) {
                        ForEach(order.items, id: \.id) { item in
                            Button {
                                if !isSheetPresented {
                                    selectedItem = item
                                    isSheetPresented.toggle()
                                }
                            } label: {
                                HStack(alignment: .center, spacing: 15) {
                                    Text("\(item.quantity)")
                                        .frame(width: 40, height: 30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.theme.brandRed, lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.meal.name)
                                            .font(.subheadline)
                                        Text(item.total_amount.formatedAmount)
                                            .foregroundStyle(Color.theme.brandRed)
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    KFImage(URL(string: item.meal.imageUrl))
                                        .retry(maxCount: 3, interval: .seconds(5))
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                                .frame(maxWidth: UIScreen.main.bounds.width - 50)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .sheet(item: $selectedItem) { item in
                                OrderItemSheetView(orderItemId: item.id, orderId: order.id)
                                    .presentationDetents([.fraction(0.5)])
                                    .presentationDragIndicator(.visible)
                                    .presentationCornerRadius(16)
                                    .presentationBackgroundInteraction(.disabled)
                                    .onDisappear {
                                        isSheetPresented = false
                                    }
                            }
                        }
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    NavigationLink {
                        CheckoutView(orderId: order.id, isOrdered: $isOrdered)
                            .onDisappear {
                                if isOrdered {
                                    isOrdered = false
                                    dismiss()
                                }
                            }
                    } label: {
                        HStack(spacing: 20) {
                            Circle()
                                .overlay {
                                    Text("\(order.total_meal_count)")
                                        .foregroundStyle(Color.theme.brandRed)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 32, height: 32)
                                .padding(.leading, 20)
                            
                            Text("Go to checkout \(order.total_amount.formatedAmount)")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(Color.theme.brandRed)
                        .cornerRadius(20)
                        .padding(.bottom, 50)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.all, 10)
                }
            }
        }
    }
}

#Preview {
    OrderView(orderId: sampleOrder.id)
        .environmentObject(RestaurantViewModel())
        .environmentObject(NavBarViewModel())
}
