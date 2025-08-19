//
//  CartViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import Foundation
import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartTableViewCell",
            for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let product = cartItems[indexPath.row]
        cell.configure(with: product)
        
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") else { return }

            CoreDataHelper.shared.deleteCartItem(productId: Int(product.id), userEmail: currentUserEmail)

            // Refresh from Core Data
            self.cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
            self.updateEmptyLabel()
            self.tblCart.reloadData()
        }
        
        return cell
    }
    
}
