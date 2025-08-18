//
//  MyOrderViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import Foundation
import UIKit

extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath) as! MyOrderTableViewCell
        
        let product = orderProducts[indexPath.row]
        cell.lblProductsName.text = product.strProductName
        cell.lblProductQty.text = "x \(product.intProductQty ?? 1)"
        cell.lblProductPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice * Double(product.intProductQty ?? 1)))"
        
        return cell
    }
}
