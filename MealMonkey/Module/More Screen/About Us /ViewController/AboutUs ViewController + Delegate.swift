//
//  AboutUs ViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
        switch objPagetype {
            
        case .AboutUs:
            cell.configureAboutUsCell(about: arrCurrent[indexPath.row])
            
        case .Notifications:
            cell.configureNotificationCell(
                about: arrCurrent[indexPath.row]
                
            )
            
        case .Inbox:
            cell.configureInboxCell(about: arrCurrent[indexPath.row])
            
        default:
            break
        }
        return cell
    }
}
