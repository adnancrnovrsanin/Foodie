//
//  ToRestaurantSheetView.swift
//  Foodie
//
//  Created by Muhedin Alic on 18.08.24.
//

import SwiftUI
import Kingfisher

struct ToRestaurantSheetView: View {
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    
    @State private var showConfirmationDialog = false
    
    var body: some View {
        if let delivery = checkoutViewModel.myDelivery {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                HStack(alignment: .center, spacing: 10) {
                    KFImage(URL(string: delivery.restaurant.restaurantImage))
                        .retry(maxCount: 3, interval: .seconds(5))
                        .resizable()
                        .frame(width: 64, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(delivery.restaurant.name)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .font(.caption)
                            
                            Text(delivery.restaurant.location.address)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                Rectangle()
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .opacity(0.3)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Order id:")
                            .font(.caption)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Text(delivery.order.id)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                
                Rectangle()
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .opacity(0.3)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Utensils:")
                            .font(.caption)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Text("\(delivery.requestUtensils ? "Requested" : "Not requested")")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                
                if let deliveryInstructions = delivery.deliveryInstructions {
                    Rectangle()
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .opacity(0.3)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Additional instructions:")
                            .font(.caption)
                            .foregroundStyle(Color.theme.primaryTextColor)
                        
                        Text(deliveryInstructions)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.theme.primaryTextColor)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                }
                
                Rectangle()
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .opacity(0.3)
                
                Button {
                    checkoutViewModel.acceptThePackageFromRestaurant()
                } label: {
                    Text("I accepted the package from restaurant")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.green)
                .cornerRadius(12)
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                
                Button {
                    showConfirmationDialog = true
                } label: {
                    Text("Cancel the order")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .confirmationDialog("Are you sure you want to cancel this order?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                    Button("Yes", role: .destructive) {
                        checkoutViewModel.cancelTheDelivery()
                    }
                    Button("No", role: .cancel) {}
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ToRestaurantSheetView()
}
