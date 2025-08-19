//
//  CartTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

/// Custom UITableViewCell for displaying cart items
class CartTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnDeleteFoodItem: UIButton!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    /// Closure called when delete button is tapped
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initial setup after loading cell from nib
    }
    
    /// Configure cell with cart item data
    func configure(with cartItem: CartItem) {
        lblFoodName.text = cartItem.name
        imgProduct.image = UIImage(named: cartItem.image ?? "")
        lblFoodPrice.text = "$\(String(format: "%.2f", cartItem.price))"
        lblQty.text = "QTY: \(cartItem.quantity)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optional: customize selection style
    }
    
    // MARK: - Actions
    
    /// Delete button tapped → trigger callback
    @IBAction func btnDeleteCartAction(_ sender: Any) {
        onDelete?()
    }
}
