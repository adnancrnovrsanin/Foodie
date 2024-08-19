//
//  RestaurantView.swift
//  Foodie
//
//  Created by Muhedin Alic on 10.08.24.
//

import SwiftUI
import Kingfisher

struct RestaurantView: View {
    var restaurant: Restaurant
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: restaurant.restaurantImage))
                .retry(maxCount: 3, interval: .seconds(5))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 200)
                .overlay(
                    Color.black.opacity(0.5)
                )
                .clipped()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack{
                    Text(restaurant.name)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundStyle(.white)
                        
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 16, height: 16)
                    Text(restaurant.rating.description)
                        .fontWeight(.medium)
                        .font(.caption)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 14)
                
                HStack {
                    Image(systemName: "location.square.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.white)
                    Text(restaurant.location.address)
                        .fontWeight(.medium)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                .padding(.leading, 10)
            }
            .clipShape(.rect(cornerRadius: 16))
            
            List {
                VStack(alignment: .leading) {
                    Text("Categories")
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .fontWeight(.bold)
                        .font(.headline)
                        .padding(.top, 4)
                    
                    Text("We've got \(restaurant.categories.count) categories for you!")
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .opacity(0.7)
                        .fontWeight(.medium)
                        .font(.caption)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(restaurant.categories) { category in
                                Group {
                                    Text(category.description)
                                        .foregroundStyle(Color.theme.brandRed)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .fontWeight(.medium)
                                        .font(.caption)
                                }
                                .background(Color.theme.brandRed.opacity(0.2))
                                .cornerRadius(10.0)
                                .padding(.vertical,8)
                            }
                        }
                    }
                    .frame(height: 15)
                    .padding(.top, 2)
                }
                
                ForEach(restaurant.returnMealsByCategory().sorted(by: { $0.key.rawValue < $1.key.rawValue }), id: \.key.rawValue) { category, meals in
                    Section(header: Text(category.description).fontWeight(.bold)) {
                        ForEach(meals, id: \.id) { meal in
                            NavigationLink(value: meal) {
                                MealCard(meal: meal)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                }
            }
            .offset(x: 0, y: 200)
            .ignoresSafeArea()
            .navigationDestination(for: Meal.self) { meal in
                MealDetailsScreen(meal: meal, restaurant: restaurant)
            }
        }
    }
}

#Preview {
    RestaurantView(restaurant: fakeRestaurant)
}
