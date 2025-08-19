//
//  OffersViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

// Extension to handle UITableView delegate and data source methods
extension OffersViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Number of rows in table view (equal to number of offers in the array)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffers.count
    }
    
    // Configure each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell of type OffersTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
        // Get the corresponding offer from the array
        let offer = arrOffers[indexPath.row]
        // Configure the cell with the offer details
        cell.configure(with: offer)
        // Disable cell selection highlight
        cell.selectionStyle = .none
        return cell
    }
}
