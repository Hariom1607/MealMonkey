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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.morePageCell, for: indexPath) as! MoreTableViewCell
        let item = arrTitles[indexPath.row]
        
        // Force language row to always fetch latest localized string
        if indexPath.row == 6 {
            cell.lblTitleMore.text = Localized("label_more_languages")
        } else {
            cell.lblTitleMore.text = item.title
        }
        cell.imgIconMore.image = item.imgSection
        cell.imgIconMore.tintColor = .loginLabel
        
        return cell
    }
    
    // Handle row selection in More screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0: // Payment Details
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.paymentDetails) as? PaymentDetailsViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("First row selected")
            
        case 1: // My Orders
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let mlvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.orderList) as? OrderListViewController {
                self.navigationController?.pushViewController(mlvc, animated: true)
            }
            print("Second row selected")
            
        case 2: // Notifications
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.aboutUs) as? AboutUsViewController {
                plvc.objPagetype = .Notifications
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Third row selected")
            
        case 3: // Inbox
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.aboutUs) as? AboutUsViewController {
                plvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Fourth row selected")
            
        case 4: // Wishlist
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.wishlist) as? WishlistViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Fifth row selected")
            
        case 5: // About Us
            let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.aboutUs) as? AboutUsViewController {
                plvc.objPagetype = .AboutUs
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Sixth row selected")
            
        case 6: // Languages
            let langVC = LanguageSelectionViewController()
            let nav = UINavigationController(rootViewController: langVC)
            nav.modalPresentationStyle = .pageSheet // iOS 15 bottom sheet style
            self.present(nav, animated: true)
            
        default: // Any other rows
            print("Other row selected")
        }
    }
}
