//
//  OffersViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

extension OffersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
        let offer = arrOffers[indexPath.row]
        cell.configure(with: offer)
        cell.selectionStyle = .none
        return cell
    }
}
