//
//  OrderList ViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import Foundation
import UIKit
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        let order = orders[indexPath.row]
        let firstProductName = order.first?.strProductName ?? "No Product"
        
        // Total price
        let totalPrice = order.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        
        cell.lblOrderNo.text = "Order No : \(indexPath.row + 1)"
        cell.lblProductName.text = firstProductName
        cell.lblTotalPrice.text = "$\(String(format: "%.2f", totalPrice))"
        if let imgName = order.first?.strProductImage {
            cell.imgOrder.image = UIImage(named: imgName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
            detailVC.orderProducts = orders[indexPath.row] // Pass the selected order
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
