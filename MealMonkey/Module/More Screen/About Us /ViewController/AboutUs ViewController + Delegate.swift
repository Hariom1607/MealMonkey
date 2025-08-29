//
//  AboutUs ViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

// MARK: - Extension for AboutUsViewController to handle UITableView Delegate & DataSource
extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows in the table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count   // total items = count of arrCurrent
    }
    
    // Cell configuration for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable cell of type AboutUsTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.aboutUsCell, for: indexPath) as! AboutUsTableViewCell
        
        // Configure cell content based on objPagetype
        switch objPagetype {
        
        case .AboutUs:
            // Setup AboutUs cell UI
            cell.configureAboutUsCell(about: arrCurrent[indexPath.row])
            
        case .Notifications:
            // Setup Notification cell UI
            cell.configureNotificationCell(
                about: arrCurrent[indexPath.row]
            )
            
        case .Inbox:
            // Setup Inbox cell UI
            cell.configureInboxCell(about: arrCurrent[indexPath.row])
            
        default:
            break   // Do nothing for other cases
        }
        
        return cell   // Return configured cell
    }
}
