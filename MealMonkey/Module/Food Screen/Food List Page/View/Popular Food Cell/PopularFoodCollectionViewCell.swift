//
//  PopularFoodCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

// Custom collection view cell for displaying popular food items
class PopularFoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodRating: UILabel!  // Shows rating (e.g. 4.5)
    @IBOutlet weak var lblFoodType: UILabel!    // Shows type (e.g. Food, Beverages, Dessert)
    @IBOutlet weak var lblFoodName: UILabel!    // Shows food/product name
    @IBOutlet weak var imgfood: UIImageView!    // Shows food image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Configuration
    /// Configures the cell with a `ProductModel`
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodRating.text = "\(item.floatProductRating)"
        lblFoodType.text = item.objProductType.rawValue.capitalized
        
        // Load image safely, fallback to placeholder if image not found
        if let image = UIImage(named: item.strProductImage), !item.strProductImage.isEmpty {
            imgfood.image = image
        } else {
            imgfood.image = UIImage(named: "placeholder_food") // <- provide default asset
        }
    }
}
