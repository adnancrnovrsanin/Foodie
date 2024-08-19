//
//  RestaurantCard.swift
//  Foodie
//
//  Created by Muhedin Alic on 10.08.24.
//

import SwiftUI
import Kingfisher

struct RestaurantCard: View {
    @Binding var restaurant: Restaurant
    
    var body: some View {
        VStack(spacing: 10) {
            KFImage(URL(string: restaurant.restaurantImage))
                .retry(maxCount: 3, interval: .seconds(5))
                .resizable()
                .frame(maxWidth: .infinity)
            
            VStack(spacing: 5) {
                HStack {
                    Text(restaurant.name)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color.theme.primaryTextColor)
                    Spacer()
                }
                
                HStack {
                    Text(restaurant.deliveryTime)
                        .font(.caption2)
                        .foregroundStyle(Color.theme.primaryTextColor)
                    Spacer()
                }
                
                HStack {
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            if index <= Int(restaurant.rating) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.theme.brandRed)
                                    .frame(width: 20, height: 20)
                            } else if Double(index) - restaurant.rating <= 0.5 {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(Color.theme.brandRed)
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding(.all, 10)
        }
        .background(Color.theme.backgroundColor)
        .frame(width: UIScreen.main.bounds.width - 50, height: 250)
        .cornerRadius(10)
    }
}

#Preview {
    RestaurantCard(restaurant: .constant(fakeRestaurant))
}
