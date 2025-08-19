//
//  MenuViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

/// Handles table view delegate & datasource methods for `MenuViewController`
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Number of rows = number of menu categories (Food, Beverages, Desserts)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    /// Configure each menu cell (category name, quantity, image)
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell",
                                                 for: indexPath) as! MenuTableViewCell
        
        let items = menuItems[indexPath.row]
        
        // Set menu title (Food, Beverages, Desserts)
        cell.lblName.text = items.strName
        
        // Set number of items (e.g., "120 Items")
        cell.lblQuantity.text = items.strQuantity
        
        // Keep background clear to match design
        cell.backgroundColor = .clear
        
        // Disable default selection highlight
        cell.selectionStyle = .none
        
        // Load category image if available, otherwise hide image view
        if let imageName = items.imageName {
            cell.imgItem.image = UIImage(named: imageName)
            cell.imgItem.isHidden = false
        } else {
            cell.imgItem.isHidden = true
        }
        
        return cell
    }
    
    /// Handle category selection → navigate to `DessertsViewController`
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController")
            as? DessertsViewController {
            
            // Assign correct category based on row tapped
            switch indexPath.row {
            case 0: vc.selectedCategory = .food
            case 1: vc.selectedCategory = .Beverages
            case 2: vc.selectedCategory = .Desserts
            default: return
            }
            
            // Push to product listing screen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
