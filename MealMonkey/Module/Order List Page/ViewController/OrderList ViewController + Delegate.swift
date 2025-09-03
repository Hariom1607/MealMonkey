//
//  OrderList ViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import Foundation
import UIKit
import CoreData

// MARK: - UITableView Delegate & DataSource Implementation
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table (equal to number of orders)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    /// Configures and returns a cell for each row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.orderListCell, for: indexPath) as! OrderListTableViewCell
        
        // Get the specific order (array of products) for this row
        let order = orders[indexPath.row]
        
        // Combine all product names into a single string (comma separated)
        let allProductNames = order.map { $0.strProductName }.joined(separator: ", ")
        
        // Calculate total price of the order (price × quantity)
        let totalPrice = order.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
        
        // Configure cell labels
        cell.lblOrderNo.text = Main.Labels.orderNoPrefix + "\(indexPath.row + 1)"
        cell.lblProductName.text = allProductNames
        cell.lblTotalPrice.text = Main.Labels.currencySymbol + "\(String(format: "%.2f", totalPrice))"
        
        // Display first product's image as the order preview image
        if let imgName = order.first?.strProductImage {
            cell.imgOrder.image = UIImage(named: imgName)
        }
        
        return cell
    }
    
    /// Handles selection of a table row (navigates to order details screen)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.myOrder) as? MyOrderViewController {
            // Pass selected order (all its products) to the detail screen
            detailVC.orderProducts = orders[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // MARK: - Core Data Fetch
    
    /// Fetches orders belonging to the current logged-in user from Core Data
    func fetchOrdersForCurrentUser() -> [Order] {
        // Get Core Data context from AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        
        // Get current user email from UserDefaults
        guard let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) else { return [] }
        
        // Create fetch request for Order entity, filtered by user email
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        request.predicate = NSPredicate(format: "users.email == %@", currentUserEmail)
        request.sortDescriptors = [NSSortDescriptor(key: "order_no", ascending: true)] // sort by order number
        
        do {
            let orders = try context.fetch(request)
            return orders
        } catch {
            print("❌ Failed to fetch orders: \(error.localizedDescription)")
            return []
        }
    }
}
