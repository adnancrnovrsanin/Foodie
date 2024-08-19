//
//  HomeView.swift
//  Foodie
//
//  Created by Muhedin Alic on 08.08.24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var path = NavigationPath()
    @State private var selectedCategory: FoodCategory? = nil
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack {
                        HStack {
                            Text("Categories")
                                .font(.title)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Button {
                                    selectedCategory = nil
                                } label: {
                                    VStack(alignment: .center) {
                                        if let selectedCategory = $selectedCategory.wrappedValue {
                                            
                                            Circle()
                                                .stroke(Color.theme.brandRed, lineWidth: 1)
                                                .frame(width: 56, height: 56)
                                        } else {
                                            Circle()
                                                .frame(width: 56, height: 56)
                                                .foregroundStyle(Color.theme.brandRed)
                                        }
                                        
                                        Text("All")
                                            .font(.body)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    }
                                }
                                ForEach(FoodCategory.allCases) { category in
                                    Button {
                                        selectedCategory = category
                                    } label: {
                                        VStack(alignment: .center) {
                                            if let selectedCategory = $selectedCategory.wrappedValue, category.rawValue == $selectedCategory.wrappedValue?.rawValue {
                                                Circle()
                                                    .overlay {
                                                        Image(category.imageName)
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                    .frame(width: 56, height: 56)
                                                    .foregroundStyle(Color.theme.brandRed)
                                            } else {
                                                Circle()
                                                    .stroke(Color.theme.brandRed, lineWidth: 1)
                                                    .frame(width: 56, height: 56)
                                                    .overlay {
                                                        Image(category.imageName)
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                            }
                                                
                                            Text(category.description)
                                                .font(.body)
                                                .foregroundStyle(Color.theme.primaryTextColor)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.all, 10)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 50)
                    
                    HStack {
                        Text("All restaurants")
                            .font(.title2)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading, 25)
                    ForEach(homeViewModel.restaurants.filter{ $0.categories.contains(where: { $0.rawValue == $selectedCategory.wrappedValue?.rawValue || $selectedCategory.wrappedValue == nil }) }) { restaurant in
                        NavigationLink(value: restaurant) {
                            RestaurantCard(restaurant: .constant(restaurant))
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationDestination(for: Restaurant.self) { restaurant in
                RestaurantView(restaurant: restaurant)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
