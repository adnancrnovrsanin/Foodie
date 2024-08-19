//
//  AcceptDeliveriesView.swift
//  Foodie
//
//  Created by Muhedin Alic on 18.08.24.
//

import SwiftUI
import Kingfisher

struct AcceptDeliveriesView: View {
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var user: User?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                Text("Available deliveries")
                    .font(.title3)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                ForEach(checkoutViewModel.checkouts) { checkout in
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .center, spacing: 10) {
                            KFImage(URL(string: checkout.restaurant.restaurantImage))
                                .retry(maxCount: 3, interval: .seconds(5))
                                .resizable()
                                .frame(width: 64, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(checkout.restaurant.name)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.caption2)
                                    
                                    Text(checkout.restaurant.location.address)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.caption2)
                                }
                            }
                            .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        
                        if let user = user {
                            Rectangle()
                                .listRowInsets(EdgeInsets())
                                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.3)
                            HStack(alignment: .center, spacing: 10) {
                                ProfileImageView(imageUrl: user.profileImageUrl)
                                    .frame(width: 64, height: 64)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(user.fullname)
                                        .foregroundStyle(Color.theme.primaryTextColor)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    HStack {
                                        Image(systemName: "location.fill")
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                            .font(.caption2)
                                        
                                        Text(checkout.deliveryLocation.address)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                            .font(.caption2)
                                    }
                                }
                                .padding(.horizontal, 10)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        } else {
                            // Placeholder or loading state
                            ProgressView() // or any other placeholder
                                .onAppear {
                                    fetchUser(for: checkout.order.userId)
                                }
                        }
                        
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        // Delivery value
                        HStack {
                            Text("Delivery value: ")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.theme.primaryTextColor)
                            Text(checkout.order.total_amount.formatedAmount)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        Button {
                            checkoutViewModel.acceptDelivery(checkout: checkout)
                        } label: {
                            Text("Accept delivery")
                                .font(.body)
                                .fontWeight(.medium)
                            Image(systemName: "checkmark")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 10)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: UIScreen.main.bounds.width - 70, height: 40)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 8))
                        .padding(.bottom, 5)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 50)
                    .padding(.all, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.theme.primaryTextColor, lineWidth: 1)
                    )
                }
            }
        }
    }
    
    private func fetchUser(for userId: String) {
        UserService.fetchUser(withUid: userId) { fetchedUser in
            self.user = fetchedUser
        }
    }
}

#Preview {
    AcceptDeliveriesView()
        .environmentObject(CheckoutViewModel(checkouts: [sampleCheckout]))
        .environmentObject(AuthViewModel())
}
