//
//  MenuViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let items = menuItems[indexPath.row]
        cell.lblName.text = items.strName
        cell.lblQuantity.text = items.strQuantity
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if let imageName = items.imageName{
            cell.imgItem.image = UIImage(named: imageName)
            cell.imgItem.isHidden = false
        }
        else{
            cell.imgItem.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
            
            switch indexPath.row {
            case 0:
                vc.selectedCategory = .food
            case 1:
                vc.selectedCategory = .Beverages
            case 2:
                vc.selectedCategory = .Desserts
            default:
                return
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
