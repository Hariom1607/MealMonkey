//
//  MyOrderViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import Foundation
import UIKit

// MARK: - TableView Delegate & DataSource for MyOrderViewController
extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Number of Rows
    /// Returns number of rows equal to the number of products in the order
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProducts.count
    }
    
    // MARK: - Configure Cell
    /// Configures each cell with product details (name, quantity, price)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.myOrderCell, for: indexPath) as! MyOrderTableViewCell
        
        // Fetch product for this row
        let product = orderProducts[indexPath.row]
        
        // Set product details in cell
        cell.lblProductsName.text = product.strProductName
        cell.lblProductQty.text = "x \(product.intProductQty ?? 1)"  // Show quantity (default to 1 if nil)
        cell.lblProductPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice * Double(product.intProductQty ?? 1)))"
        
        return cell
    }
}
