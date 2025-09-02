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
        return filteredMenuItems.count
    }
    
    /// Configure each menu cell (category name, quantity, image)
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.menuCell,
                                                 for: indexPath) as! MenuTableViewCell
        
        let items = filteredMenuItems[indexPath.row]   // Use filtered
        
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
        let selected = filteredMenuItems[indexPath.row]  // ✅ Use filtered
        
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Main.viewController.desserts)
            as? DessertsViewController {
            
            // Assign correct category based on row tapped
            switch selected.strName.lowercased() {
            case "food": vc.selectedCategory = .food
            case "beverages": vc.selectedCategory = .Beverages
            case "desserts": vc.selectedCategory = .Desserts
            default: return
            }
            
            // Push to product listing screen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateEmptyState() {
        if filteredMenuItems.isEmpty {
            tblMenu.setEmptyView(animationName: "Menu",
                                 message: "No results found 🔍")
        } else {
            tblMenu.restore()
        }
    }
}
