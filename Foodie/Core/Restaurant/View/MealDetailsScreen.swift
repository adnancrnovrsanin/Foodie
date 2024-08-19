//
//  MealDetailsScreen.swift
//  Foodie
//
//  Created by Muhedin Alic on 10.08.24.
//

import SwiftUI
import Kingfisher

struct MealDetailsScreen: View {
    @State private var quantity: Int = 1
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    let meal: Meal
    let restaurant: Restaurant
    
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if showToast {
                ToastView(toastMessage: $toastMessage)
                    .transition(.slide)
                    .zIndex(1)
            }
            
            VStack(alignment: .center) {
                KFImage(URL(string: meal.imageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .resizable()
                    .frame(width: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, -20)
            }
            .frame(width: UIScreen.main.bounds.width)
            
            HStack {
                Image(systemName: "storefront.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(restaurant.name)
                    .fontWeight(.semibold)
                    .font(.headline)
            }
            
            HStack{
                Text(meal.name)
                    .fontWeight(.semibold)
                    .font(.title3)
                Spacer()
                Text("\(meal.price.formatedAmount)")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundStyle(Color.theme.brandRed)
            }
            Text(meal.description)
                .padding(.top, 4)
            
            
            
            if let order = restaurantViewModel.orders.first(where: { order in order.restaurant.id == restaurant.id }) {
                if let itemFromOrder = order.items.first(where: { $0.meal.id == meal.id }) {
                    if itemFromOrder.quantity > 0 {
                        Spacer()
                        HStack(alignment: .top) {
                            Circle()
                                .overlay {
                                    Text("\(itemFromOrder.quantity)")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                }
                                .frame(width: 32, height: 32)
                                .padding(.leading, 20)
                                .foregroundStyle(Color.theme.brandRed)
                            Text("have already been added to the existing order")
                                .padding(.top, 4)
                                .foregroundStyle(Color.theme.primaryTextColor)
                            Spacer()
                        }
                    }
                }
            }
            
            Spacer()
            
            Rectangle()
                .listRowInsets(EdgeInsets())
                .frame(width: .infinity, height: 2)
                .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 0.943))
                .padding(.horizontal, -20)
            
            HStack{
                Button{
                    if quantity>1 { quantity-=1 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color.theme.brandRed)
                }
            
                    
                Text(quantity.description)
                    .fontWeight(.semibold)
                
                Button{
                    quantity+=1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color.theme.brandRed)
                }
                
                Button(
                    action: {
                        restaurantViewModel.addMealFromRestaurantToOrder(meal: meal, quantity: quantity, restaurant: restaurant)
                        toastMessage = "You successfully added \(quantity) \(meal.name) in the order!"
                        withAnimation {
                            showToast = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }, label: {
                        let individualPrice = NSDecimalNumber(decimal: meal.price.amount)
                        let quantityNSD = NSDecimalNumber(decimal: Decimal(quantity))
                        let price = individualPrice.multiplying(by: quantityNSD)

                        // Define the rounding behavior
                        let roundingBehavior = NSDecimalNumberHandler(
                            roundingMode: .plain,
                            scale: 2,
                            raiseOnExactness: false,
                            raiseOnOverflow: false,
                            raiseOnUnderflow: false,
                            raiseOnDivideByZero: false
                        )

                        // Apply rounding to the price
                        let roundedPrice = price.rounding(accordingToBehavior: roundingBehavior)

                        Text("Add to order \(roundedPrice.stringValue)$")
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
        .padding(.horizontal, 7)
    }
}

#Preview {
    MealDetailsScreen(meal: fakeRestaurant.meals[0], restaurant: fakeRestaurant)
        .environmentObject(RestaurantViewModel())
}
