//
//  CheckoutViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import Foundation
import UIKit

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // COD cell
            return tableView.dequeueReusableCell(
                withIdentifier: "CashOnDeliveryTableViewCell",
                for: indexPath
            ) as! CashOnDeliveryTableViewCell
        case 1, 2, 3:
            // Card cells
            let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "CardTableViewCell",
                for: indexPath
            ) as! CardTableViewCell
            let cardIndex = indexPath.row - 1  // adjust index for arrCards
            if cardIndex < arrCards.count {
                cell.lblCardNumber.text = arrCards[cardIndex]
            }
            return cell
        case 4:
            // UPI cell
            return tableView.dequeueReusableCell(
                withIdentifier: "UpiTableViewCell",
                for: indexPath
            ) as! UpiTableViewCell
        default:
            return UITableViewCell()
        }
        
    }
}
