//
//  DessertsViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows = number of filtered products
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredProducts.isEmpty {
            tableView.setEmptyView(
                animationName: Main.EmptyState.dessertsAnimation,
                message: Main.EmptyState.noItemsFound(for: "desserts") // <-- dynamic
            )
        } else {
            tableView.restore()
        }
        return filteredProducts.count
    }
    
    // Configure each cell
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Main.cells.menuDessertCell,
            for: indexPath
        ) as? DessertsTableViewCell else {
            return UITableViewCell() // Fallback in case of casting failure
        }
        
        let product = filteredProducts[indexPath.row]
        cell.configure(with: product)
        cell.applyTheme(ThemeManager.currentTheme) // ✅ Apply current theme
        return cell
    }
    
    // Handle row selection → open product detail
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        
        // ✅ Save to recent items
        RecentItemsHelper.shared.addProduct(selectedProduct)
        
        // ✅ Navigate to FoodDetailViewController
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(
            withIdentifier: Main.viewController.foodDetail
        ) as? FoodDetailViewController {
            
            detailVC.product = selectedProduct
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
