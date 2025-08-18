//
//  Wishlist viewController + delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 15/08/25.
//

import Foundation
import UIKit

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as! WishlistTableViewCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let product = wishlistItems[indexPath.row]
        
        cell.product = product
        cell.lblProductName.text = product.strProductName
        cell.lblCategory.text = product.objProductCategory.rawValue
        cell.lblPrice.text = "\(product.doubleProductPrice)"
        cell.imgProduct.image = UIImage(named: product.strProductImage)
        cell.btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.btnWishlist.tintColor = .red
        
        cell.onWishlistToggle = { [weak self] in
            guard let self = self else { return }
            self.wishlistItems.remove(at: indexPath.row)
            if let user = UserDefaults.standard.string(forKey: "currentUser") {
                saveWishlist(self.wishlistItems, forUser: user)
            }
            self.tblWishlist.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return cell
    }
    
    func loadWishlistFromUserDefaults() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        wishlistItems = appDelegate.arrWishlist
    }
    
}
