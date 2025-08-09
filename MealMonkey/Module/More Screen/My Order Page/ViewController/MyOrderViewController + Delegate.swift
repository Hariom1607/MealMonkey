//
//  MyOrderViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import Foundation
import UIKit

extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath) as! MyOrderTableViewCell
        
        return cell
    }
}
