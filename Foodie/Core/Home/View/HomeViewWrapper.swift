//
//  HomeView.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import SwiftUI

struct HomeViewWrapper: View {
    @Namespace var animation
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else if let user = authViewModel.user {
                NavBarView()
                    .environmentObject(RestaurantViewModel())
                    .environmentObject(NavBarViewModel())
                    .environmentObject(MapViewModel())
                    .environmentObject(CheckoutViewModel())
            }
        }
    }
}

#Preview {
    HomeViewWrapper()
        .environmentObject(AuthViewModel())
        .environmentObject(HomeViewModel())
}
