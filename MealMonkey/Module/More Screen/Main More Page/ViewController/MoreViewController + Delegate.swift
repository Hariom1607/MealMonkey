//
//  MoreViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

extension MoreViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        let item = arrTitles[indexPath.row]
        cell.lblTitleMore.text = item.title
        cell.imgIconMore.image = item.imgSection
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "PaymentDetailsViewController") as? PaymentDetailsViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("First row selected")
        case 1:
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let mlvc = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController {
                self.navigationController?.pushViewController(mlvc, animated: true)
            }
            print("Second row selected")
        case 2:
            print("Third row selected")
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Notifications
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        case 3:
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
            print("fourth row selected")
            
        case 4:
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("fifth row selected")
            
        case 5:
            let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .AboutUs
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("sixth row selected")
        default:
            print("Other row selected")
        }
    }
}
