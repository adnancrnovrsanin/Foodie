//
//  OrdersView.swift
//  Foodie
//
//  Created by Muhedin Alic on 13.08.24.
//

import SwiftUI
import Kingfisher

struct OrdersView: View {
    @State private var path = NavigationPath()
    @State private var showConfirmationDialog = false
    
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    Text("All your orders")
                        .font(.title3)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    // MARK: - Checkouts
                    ForEach(checkoutViewModel.checkouts) { checkout in
                        VStack(spacing: 10) {
                            HStack(alignment: .center, spacing: 10) {
                                KFImage(URL(string: checkout.restaurant.restaurantImage))
                                    .retry(maxCount: 3, interval: .seconds(5))
                                    .resizable()
                                    .frame(width: 64, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(checkout.restaurant.name)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    Text("Delivery in \(checkout.restaurant.deliveryTime)")
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.caption2)
                                }
                                .padding(.horizontal, 10)
                                
                                Spacer()
                                
                                // State tag
                                Text(checkout.status.tag)
                                    .font(.caption)
                                    .foregroundStyle(checkout.status.color)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 10)
                            
                            Rectangle()
                                .listRowInsets(EdgeInsets())
                                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.3)
                            
                            HStack {
                                Text("Order status:")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                
                                Text(checkout.status.description)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            
                            
                            Rectangle()
                                .listRowInsets(EdgeInsets())
                                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.3)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 10) {
                                    ForEach(checkout.order.items) { item in
                                        KFImage(URL(string: item.meal.imageUrl))
                                            .retry(maxCount: 3, interval: .seconds(5))
                                            .resizable()
                                            .frame(width: 64, height: 64)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            
                            Rectangle()
                                .listRowInsets(EdgeInsets())
                                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.3)
                            
                            HStack {
                                Text("Item subtotal")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                
                                Text(checkout.order.total_amount.formatedAmount)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width - 50)
                        .padding(.all, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.theme.primaryTextColor, lineWidth: 1)
                        )
                    }
                    
                    // MARK: - Orders
                    ForEach(restaurantViewModel.orders) { order in
                        VStack(spacing: 10) {
                            HStack(alignment: .center, spacing: 10) {
                                KFImage(URL(string: order.restaurant.restaurantImage))
                                    .retry(maxCount: 3, interval: .seconds(5))
                                    .resizable()
                                    .frame(width: 64, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(order.restaurant.name)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    Text("Delivery in \(order.restaurant.deliveryTime)")
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.caption2)
                                }
                                .padding(.horizontal, 10)
                                
                                Spacer()
                                
                                Button {
                                    showConfirmationDialog = true
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                        .frame(width: 16, height: 16)
                                }
                                .confirmationDialog("Are you sure you want to delete this order?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                                    Button("Delete", role: .destructive) {
                                        restaurantViewModel.deleteOrder(order: order)
                                    }
                                    Button("Cancel", role: .cancel) {}
                                }
                            }
                            .padding(.horizontal, 10)
                            
                            
                            Rectangle()
                                .listRowInsets(EdgeInsets())
                                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.3)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 10) {
                                    ForEach(order.items) { item in
                                        KFImage(URL(string: item.meal.imageUrl))
                                            .retry(maxCount: 3, interval: .seconds(5))
                                            .resizable()
                                            .frame(width: 64, height: 64)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Item subtotal")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                
                                Text(order.total_amount.formatedAmount)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            
                            NavigationLink(value: order) {
                                Text("View order")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .foregroundColor(.white)
                                    .background(Color.theme.brandRed)
                                    .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.vertical, 5)
                            .padding(.horizontal, 5)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width - 50)
                        .padding(.all, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.theme.primaryTextColor, lineWidth: 1)
                        )
                    }
                    // MARK: - Completed Checkouts
                    if checkoutViewModel.completedCheckouts.count > 0 {
                        Text("Order history")
                            .font(.title3)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        ForEach(checkoutViewModel.completedCheckouts) { checkout in
                            VStack(spacing: 10) {
                                HStack(alignment: .center, spacing: 10) {
                                    KFImage(URL(string: checkout.restaurant.restaurantImage))
                                        .retry(maxCount: 3, interval: .seconds(5))
                                        .resizable()
                                        .frame(width: 64, height: 50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(checkout.restaurant.name)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                        
                                        Text("Delivery in \(checkout.restaurant.deliveryTime)")
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                            .font(.caption2)
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    Spacer()
                                    
                                    // State tag
                                    Text(checkout.status.tag)
                                        .font(.caption)
                                        .foregroundStyle(checkout.status.color)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal, 10)
                                
                                Rectangle()
                                    .listRowInsets(EdgeInsets())
                                    .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .opacity(0.3)
                                
                                HStack {
                                    Text("Order status:")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                    
                                    Text(checkout.status.description)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 10)
                                
                                
                                Rectangle()
                                    .listRowInsets(EdgeInsets())
                                    .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .opacity(0.3)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center, spacing: 10) {
                                        ForEach(checkout.order.items) { item in
                                            KFImage(URL(string: item.meal.imageUrl))
                                                .retry(maxCount: 3, interval: .seconds(5))
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 10)
                                
                                Rectangle()
                                    .listRowInsets(EdgeInsets())
                                    .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .opacity(0.3)
                                
                                HStack {
                                    Text("Item subtotal")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                    
                                    Text(checkout.order.total_amount.formatedAmount)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 10)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                            .padding(.all, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.theme.primaryTextColor, lineWidth: 1)
                            )
                        }
                    }
                    Spacer()
                }
            }
            .navigationDestination(for: Order.self) { order in
                OrderView(orderId: order.id)
            }
        }
    }
}

#Preview {
    OrdersView()
        .environmentObject(RestaurantViewModel(orders: [sampleOrder]))
        .environmentObject(CheckoutViewModel(checkouts: [sampleCheckout]))
}
