//
//  UI Save Order.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 17/08/25.
//

import Foundation
import CoreData
import UIKit

// Save a new order for the current user
func saveOrder(for products: [Food_Items], totalPrice: Double) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    
    // Create new order
    let order = Order(context: context)
    order.order_no = Int32(Date().timeIntervalSince1970) // unique order number
    order.total_price = totalPrice
    order.product_name = products.map { $0.name ?? "" }.joined(separator: ", ")
    
    // Link products to order
    for product in products {
        order.addToProducts(product)
    }
    
    // Link order to current logged-in user
    let currentEmail = UserDefaults.standard.string(forKey: "currentUser")
    let request: NSFetchRequest<User> = User.fetchRequest()
    request.predicate = NSPredicate(format: "email == %@", currentEmail ?? "")
    
    do {
        let users = try context.fetch(request)
        if let user = users.first {
            order.users = user
            user.addToOrders(order)
        }
        try context.save()
        print("Order saved successfully for user: \(currentEmail ?? "")")
    } catch {
        print("Failed to save order: \(error.localizedDescription)")
    }
}

// Fetch all orders of the current logged-in user
func fetchOrdersForCurrentUser() -> [Order] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
    let context = appDelegate.persistentContainer.viewContext
    
    let request: NSFetchRequest<Order> = Order.fetchRequest()
    let currentEmail = UserDefaults.standard.string(forKey: "currentUser") ?? ""
    request.predicate = NSPredicate(format: "users.email == %@", currentEmail)
    
    do {
        let orders = try context.fetch(request)
        return orders
    } catch {
        print("Failed to fetch orders: \(error.localizedDescription)")
        return []
    }
}
