//
//  CartViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import Foundation
import UIKit

/// Handles table view display & delete actions for Cart
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Number of rows = cart items count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    /// Configure cart cell
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Main.cells.cartCell,
            for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let product = cartItems[indexPath.row]
        cell.configure(with: product)
        
        // Handle delete button
        cell.onDelete = { [weak self] in
            guard let self = self,
                  let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") else { return }
            
            // Delete item from Core Data
            CoreDataHelper.shared.deleteCartItem(
                productId: Int(product.id),
                userEmail: currentUserEmail
            )
            
            // Refresh cart after deletion
            self.cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
            self.updateEmptyLabel()
            self.tblCart.reloadData()
        }
        
        return cell
    }
}
