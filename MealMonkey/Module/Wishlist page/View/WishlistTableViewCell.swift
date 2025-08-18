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
    var onWishlistToggle: (() -> Void)?   // 🔥 callback to VC
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnWishListAction(_ sender: Any) {
        onWishlistToggle?()
    }
}
