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
        styleViews([imgProduct!], cornerRadius: 7, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }
    
    /// Configure cell with cart item data
    func configure(with cartItem: CartItem) {
        lblFoodName.text = cartItem.name
        imgProduct.image = UIImage(named: cartItem.image ?? "")
        lblFoodPrice.text = "$\(String(format: "%.2f", cartItem.price))"
        lblQty.text = "QTY: \(cartItem.quantity)"
        
        // ✅ Show Category using Enum
        if let categoryString = cartItem.category,
           let category = ProductCategory(rawValue: categoryString) {
            lblFoodCategory.text = category.rawValue
        } else {
            lblFoodCategory.text = Main.Labels.unknown
        }
        
        // ✅ Show Type using Enum
        if let typeString = cartItem.type,
           let type = ProductType(rawValue: typeString) {
            lblFoodType.text = type.rawValue
        } else {
            lblFoodType.text = Main.Labels.unknown
        }
        applyTheme(ThemeManager.currentTheme)
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
    
    func applyTheme(_ theme: Theme) {
        lblFoodName.textColor = theme.primaryFontColor
        lblFoodPrice.textColor = theme.primaryFontColor
        lblQty.textColor = theme.primaryFontColor
        lblFoodCategory.textColor = theme.secondaryFontColor
        lblFoodType.textColor = theme.secondaryFontColor
        btnDeleteFoodItem.tintColor = theme.buttonColor
    }
}
