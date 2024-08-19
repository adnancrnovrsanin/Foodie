//
//  NavigationView.swift
//  Foodie
//
//  Created by Muhedin Alic on 08.08.24.
//

import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @EnvironmentObject var navBarViewModel: NavBarViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView(selection: $navBarViewModel.selection) {
            if let user = authViewModel.user, user.isDriver {
                DeliveryView().tabItem {
                    VStack {
                        Image(systemName: "bag.circle.fill")
                        Text("Deliveries")
                    }
                }.tag(1)
                EarningsView().tabItem {
                    VStack {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Earnings")
                    }
                }.tag(2)
                SettingsView().tabItem {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    
                }.tag(3)
            } else {
                HomeView().tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }.tag(1)
                
                OrdersView().tabItem {
                    VStack {
                        Image(systemName: "bag.fill")
                        Text("Orders")
                    }
                }.tag(2)
                
                SettingsView().tabItem {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    
                }.tag(3)
            }
        }
        .tint(Color.theme.brandRed)
    }
}

#Preview {
    NavBarView()
        .environmentObject(HomeViewModel())
        .environmentObject(RestaurantViewModel())
        .environmentObject(NavBarViewModel())
}
