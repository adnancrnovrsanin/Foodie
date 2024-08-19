//
//  EarningsView.swift
//  Foodie
//
//  Created by Muhedin Alic on 19.08.24.
//

import SwiftUI

struct EarningsView: View {
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
        
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Earnings Report")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Divider()
                
                // Total earnings and lost earnings
                HStack(spacing: 30) {
                    VStack(alignment: .leading) {
                        Text("Total Earnings")
                            .font(.headline)
                            .foregroundStyle(Color.green)
                        Text(checkoutViewModel.totalEarnings.formatedAmount)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.green)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Lost Earnings")
                            .font(.headline)
                            .foregroundStyle(Color.red)
                        Text(checkoutViewModel.lostEarnings.formatedAmount)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Pie chart for order completion ratio
                Text("Order Completion Ratio")
                    .font(.headline)
                    .padding(.top, 10)
                
                EarningsPieChartView(successfulOrders: checkoutViewModel.successfulOrdersCount, canceledOrders: checkoutViewModel.canceledOrdersCount)
                    .frame(height: 200)
                    .padding(.horizontal)
                
                Divider()
                
                // Earnings history line chart
                Text("Earnings Over Time")
                    .font(.headline)
                    .padding(.top, 10)
                
                EarningsLineChartView(earningsData: checkoutViewModel.earningsOverTime)
                    .frame(height: 200)
                    .padding(.horizontal)
                
                Divider()
                
                // Order history
                Text("Order History")
                    .font(.headline)
                    .padding(.top, 10)
                
                ForEach(checkoutViewModel.completedCheckouts) { checkout in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Order ID: \(checkout.order.id)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text("Restaurant: \(checkout.restaurant.name)")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                            Text("Earnings: \(checkout.order.total_amount.formatedAmount)")
                                .font(.caption)
                                .foregroundStyle(checkout.status == .COMPLETED ? Color.green : Color.red)
                        }
                        Spacer()
                        Text(checkout.status.tag)
                            .font(.headline)
                            .foregroundStyle(checkout.status.color)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.theme.backgroundColor.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    EarningsView()
        .environmentObject(CheckoutViewModel(checkouts: [sampleCheckout]))
}
