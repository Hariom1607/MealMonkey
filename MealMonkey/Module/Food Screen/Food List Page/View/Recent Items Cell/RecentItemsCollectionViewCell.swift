//
//  RecentItemsCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

/// Custom collection view cell for displaying recently ordered or viewed food items
class RecentItemsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodRating: UILabel!        // Displays product rating
    @IBOutlet weak var lblTotalNoOfRatings: UILabel!  // Displays total number of ratings (e.g. "120 ratings")
    @IBOutlet weak var lblFoodType: UILabel!          // Displays product type (Food, Beverage, etc.)
    @IBOutlet weak var lblFoodName: UILabel!          // Displays food/product name
    @IBOutlet weak var imgFood: UIImageView!          // Displays food image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add rounded corners / styling to image for consistency
        styleViews([imgFood], cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    }
    
    // MARK: - Configuration
    /// Configures the cell with a `ProductModel`
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodType.text = item.objProductCategory.rawValue.capitalized
        
        lblFoodRating.text = String(format: "%.1f", item.floatProductRating)
        lblTotalNoOfRatings.text = "\(item.intTotalNumberOfRatings) ratings"
        
        if let image = UIImage(named: item.strProductImage), !item.strProductImage.isEmpty {
            imgFood.image = image
        } else {
            imgFood.image = UIImage(named: Main.images.placeholder)
        }
    }
}
