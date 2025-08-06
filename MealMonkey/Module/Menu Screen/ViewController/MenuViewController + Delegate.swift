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
        
        if let imageName = items.imageName{
            cell.imgItem.image = UIImage(named: imageName)
            cell.imgItem.isHidden = false
        }
        else{
            cell.imgItem.isHidden = true
        }
        
        return cell
    }
    
}
