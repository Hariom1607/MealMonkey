//
//  MoreViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

// MARK: - UITableView Delegate & DataSource for MoreViewController
extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows in More screen (based on arrTitles count)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitles.count
    }
    
    // Configure each cell in the More screen table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        let item = arrTitles[indexPath.row]
        
        // Set title and icon for the current More item
        cell.lblTitleMore.text = item.title
        cell.imgIconMore.image = item.imgSection
        cell.imgIconMore.tintColor = .loginLabel
        
        return cell
    }
    
    // Handle row selection in More screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0: // Payment Details
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "PaymentDetailsViewController") as? PaymentDetailsViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("First row selected")
            
        case 1: // My Orders
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let mlvc = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController {
                self.navigationController?.pushViewController(mlvc, animated: true)
            }
            print("Second row selected")
            
        case 2: // Notifications
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Notifications
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Third row selected")
            
        case 3: // Inbox
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Fourth row selected")
            
        case 4: // Wishlist
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Fifth row selected")
            
        case 5: // About Us
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .AboutUs
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Sixth row selected")
            
        default: // Any other rows
            print("Other row selected")
        }
    }
}
