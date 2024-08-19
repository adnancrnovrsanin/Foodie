//
//  RestaurantViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 11.08.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RestaurantViewModel: ObservableObject {
    @Published public var orders: [Order]
    
    public init(orders: [Order]) {
        self.orders = orders
    }
    
    public init() {
        self.orders = []
        fetchOrders()
    }

    public func addMealFromRestaurantToOrder(meal: Meal, quantity: Int, restaurant: Restaurant) -> Void {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        // Check if there is an existing order from this restaurant
        if var existingOrder = orders.first(where: { order in order.restaurant.id == restaurant.id }), let existingOrderIndex = orders.firstIndex(where: { order in order.restaurant.id == restaurant.id }) {
            // Update the quantity of the existing meal or add it if it's not in the order yet
            if let index = existingOrder.items.firstIndex(where: { $0.meal.id == meal.id }) {
                var existingItem = existingOrder.items[index]
                existingItem.quantity += quantity
                
                // If the quantity is zero or less, remove the item
                if existingItem.quantity <= 0 {
                    existingOrder.items.remove(at: index)
                } else {
                    existingOrder.items[index] = existingItem
                }
            } else {
                // If the meal is not already in the order, add it
                let newItem = OrderItem(
                    id: UUID().uuidString,
                    meal: meal,
                    quantity: quantity
                )
                existingOrder.items.append(newItem)
            }
            orders[existingOrderIndex] = existingOrder
        } else {
            let newItem = OrderItem(
                id: UUID().uuidString,
                meal: meal,
                quantity: quantity
            )
            self.orders.append(Order(
                id: UUID().uuidString,
                userId: currentUserId,
                items: [newItem],
                restaurant: restaurant
            ))
        }
        
        for order in self.orders {
            guard let encodedOrder = try? Firestore.Encoder().encode(order) else { return }

            COLLECTION_ORDERS.document(order.id).setData(encodedOrder) { error in
                if let error = error {
                    print("DEBUG: Failed to save order \(error.localizedDescription)")
                }
            }
        }
        fetchOrders()
    }
    
    public func deleteOrder(order: Order) {
        guard let orderIndex = orders.firstIndex(where: { $0.id == order.id }) else { return }
        
        // Remove the order from Firestore
        COLLECTION_ORDERS.document(order.id).delete { error in
            if let error = error {
                print("DEBUG: Failed to delete order \(error.localizedDescription)")
            } else {
                // Remove the order from the local list
                self.orders.remove(at: orderIndex)
            }
        }
    }
        
    public func deleteOrderItemFromOrder(orderItem: OrderItem, order: Order) {
        guard let orderIndex = orders.firstIndex(where: { $0.id == order.id }),
              let itemIndex = orders[orderIndex].items.firstIndex(where: { $0.id == orderItem.id }) else { return }

        // Remove the item from the order
        orders[orderIndex].items.remove(at: itemIndex)
        
        // If the order has no more items, delete the entire order
        if orders[orderIndex].items.isEmpty {
            deleteOrder(order: orders[orderIndex])
        } else {
            // Update the order in Firestore
            guard let encodedOrder = try? Firestore.Encoder().encode(orders[orderIndex]) else { return }
            COLLECTION_ORDERS.document(order.id).setData(encodedOrder) { error in
                if let error = error {
                    print("DEBUG: Failed to update order \(error.localizedDescription)")
                }
            }
        }
    }

    public func fetchOrders() {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_ORDERS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user's orders \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, !snapshot.isEmpty else { return }
            
            let userOrders = snapshot.documents.compactMap { try? $0.data(as: Order.self) }.filter { order in
                return order.userId == currentUser && order.status == Status.ACTIVE
            }
            
            self.orders = userOrders
        }
    }
}

