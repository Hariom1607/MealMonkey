//
//  WishlistTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 15/08/25.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var product: ProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnWishListAction(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let product = product else { return }
        
        if let index = appDelegate.arrWishlist.firstIndex(where: { $0.intId == product.intId }) {
            // Remove
            appDelegate.arrWishlist.remove(at: index)
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            // Add
            appDelegate.arrWishlist.append(product)
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        saveWishlist(appDelegate.arrWishlist)
    }
}
