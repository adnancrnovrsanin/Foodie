//
//  OrderItemSheetView.swift
//  Foodie
//
//  Created by Muhedin Alic on 12.08.24.
//

import SwiftUI
import Kingfisher

struct OrderItemSheetView: View {
    var orderItemId: String
    var orderId: String
    
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if let order = restaurantViewModel.orders.first(where: { $0.id == orderId }), let orderItem = order.items.first(where: { $0.id == orderItemId }) {
            VStack {
                KFImage(URL(string: orderItem.meal.imageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .resizable()
                    .frame(width: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 10)
                
                HStack {
                    Text(orderItem.meal.name)
                        .fontWeight(.semibold)
                        .font(.title2)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack{
                    Button{
                        restaurantViewModel.addMealFromRestaurantToOrder(meal: orderItem.meal, quantity: -1, restaurant: order.restaurant)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.theme.brandRed)
                    }
                
                        
                    Text(orderItem.quantity.description)
                        .fontWeight(.semibold)
                    
                    Button{
                        restaurantViewModel.addMealFromRestaurantToOrder(meal: orderItem.meal, quantity: 1, restaurant: order.restaurant)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color.theme.brandRed)
                    }
                    
                    Button(
                        action: {
                            restaurantViewModel.deleteOrderItemFromOrder(orderItem: orderItem, order: order)
                            dismiss.callAsFunction()
                        }, label: {
                            Text("Remove all \(orderItem.total_amount.formatedAmount)")
                                .font(.body)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .foregroundColor(.white)
                                .background(Color.theme.brandRed)
                                .cornerRadius(20)
                        }
                    )
                    .padding(.leading, 4)
                }
                .padding(.top, 6)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    OrderItemSheetView(orderItemId: sampleOrder.items[0].id, orderId: sampleOrder.id)
        .environmentObject(RestaurantViewModel())
}
