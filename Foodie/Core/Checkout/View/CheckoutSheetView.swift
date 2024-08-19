//
//  CheckoutSheetView.swift
//  Foodie
//
//  Created by Muhedin Alic on 15.08.24.
//

import SwiftUI
import Kingfisher

struct CheckoutSheetView: View {
    let orderId: String
    
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @EnvironmentObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isOrdered: Bool
    
    @State private var showInputDialog = false
    @State private var showPhoneInputDialog = false
    @State var deliveryInstructions: String = ""
    @State var utensilsRequested = false
    @State var contactPhoneNumber: String = ""
    
    var body: some View {
        if let order = restaurantViewModel.orders.first(where: { $0.id == orderId }), let currentUser = authViewModel.user {
            ZStack(alignment: .center) {
                VStack(alignment: .center) {
                    VStack {
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        HStack(alignment: .center, spacing: 10) {
                            KFImage(URL(string: order.restaurant.restaurantImage))
                                .retry(maxCount: 3, interval: .seconds(5))
                                .resizable()
                                .frame(width: 64, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(order.restaurant.name)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text("Delivery in \(order.restaurant.deliveryTime)")
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                    .font(.caption2)
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
                        
                        Button {
                            showInputDialog = true
                        } label: {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 5) {
                                    if deliveryInstructions.count > 0 {
                                        Text("Delivery instructions")
                                            .font(.caption)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        Text(deliveryInstructions)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    } else {
                                        Text("Add delivery instructions")
                                            .font(.caption)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        Text("Click to add delivery instructions")
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    }
                                }
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.theme.primaryTextColor)
                            }
                            .padding(.all, 10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        Toggle(isOn: $utensilsRequested) {
                            Text("Utensils needed")
                                .font(.caption)
                                .foregroundStyle(Color.theme.primaryTextColor)
                        }
                        .padding(.all, 10)
                        
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Delivery location")
                                    .font(.caption2)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                                
                                Text("Current location")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.theme.primaryTextColor)
                            }
                            Spacer()
                            
                            Image(systemName: "location.fill")
                                .foregroundStyle(Color.theme.primaryTextColor)
                        }
                        .padding(.all, 10)
                        
                        Rectangle()
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .opacity(0.3)
                        
                        Button {
                            showPhoneInputDialog = true
                        } label: {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 5) {
                                    if contactPhoneNumber.count > 0 {
                                        Text("Contact phone number")
                                            .font(.caption2)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        Text(contactPhoneNumber)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    } else if let phoneNumber = currentUser.phoneNumber {
                                        Text("Contact phone number")
                                            .font(.caption2)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        Text(phoneNumber)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    } else {
                                        Text("Add phone number")
                                            .font(.caption)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        Text("Click to add contact phone number")
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                    }
                                }
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.theme.primaryTextColor)
                            }
                            .padding(.all, 10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                    
                    Button {
                        if let phoneNumber = currentUser.phoneNumber, contactPhoneNumber.count == 0 {
                            checkoutViewModel.createNewCheckout(deliveryInstructions: deliveryInstructions, utensilsRequested: utensilsRequested, contactPhoneNumber: phoneNumber, order: order)
                        } else {
                            checkoutViewModel.createNewCheckout(deliveryInstructions: deliveryInstructions, utensilsRequested: utensilsRequested, contactPhoneNumber: contactPhoneNumber, order: order)
                            authViewModel.changeUserPhoneNumber(phoneNumber: contactPhoneNumber)
                        }
                        restaurantViewModel.deleteOrder(order: order)
                        isOrdered = true
                        dismiss()
                    } label: {
                        Text("Order now \(order.total_amount.formatedAmount)")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(Color.theme.brandRed)
                        .cornerRadius(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.all, 10)
                }
                .background(Color.theme.backgroundColor)
                
                if showInputDialog {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showInputDialog = false
                        }
                    
                    DeliveryInstructionsInputDialogView(isPresented: $showInputDialog, title: "Enter any special delivery instructions you have for the driver") { input in
                        deliveryInstructions = input
                    }
                    .transition(.scale)
                    .animation(.spring(), value: showInputDialog)
                }
                
                if showPhoneInputDialog {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showPhoneInputDialog = false
                        }
                    
                    DeliveryInstructionsInputDialogView(isPresented: $showPhoneInputDialog, title: "Enter your phone number so that driver can contact you to deliver the order") { input in
                        contactPhoneNumber = input
                    }
                    .transition(.scale)
                    .animation(.spring(), value: showPhoneInputDialog)
                }
            }
        }
    }
}

#Preview {
    CheckoutSheetView(orderId: sampleOrder.id, isOrdered: .constant(false))
        .environmentObject(RestaurantViewModel(orders: [sampleOrder]))
}
