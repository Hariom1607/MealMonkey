//
//  DessertsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgShade: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnRatingStar: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none   // Removes default selection highlight for a cleaner UI
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Could add custom selection styling if needed
    }
    
    // MARK: - Configuration
    func configure(with product: ProductModel) {
        imgProduct.image = UIImage(named: product.strProductImage)
        lblCategoryName.text = product.objProductCategory.rawValue   // ✅ show readable string
        lblRestaurantName.text = "Meal Monkey" // Hardcoded → consider fetching from model later
        lblRating.text = String(format: "%.1f", product.floatProductRating)
        lblProductName.text = product.strProductName
        imgShade.image = UIImage(named: "ic_shadeDesserts")
        
        // Optional: Accessibility
        lblProductName.accessibilityLabel = "Dessert name: \(product.strProductName)"
        lblRating.accessibilityLabel = "Rating: \(product.floatProductRating) stars"
    }
}
