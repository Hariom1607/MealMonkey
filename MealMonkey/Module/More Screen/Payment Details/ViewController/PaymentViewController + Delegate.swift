//
//  PaymentViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import Foundation
import UIKit

extension PaymentDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        
        return cell
    }
}
