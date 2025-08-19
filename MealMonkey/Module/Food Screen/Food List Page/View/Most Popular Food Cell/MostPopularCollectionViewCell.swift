//
//  MostPopularCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

// Custom collection view cell for displaying "Most Popular" food items
class MostPopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodName: UILabel!        // Displays product/food name
    @IBOutlet weak var lblRatings: UILabel!         // Displays product rating
    @IBOutlet weak var lblFoodCategory: UILabel!    // Displays product category
    @IBOutlet weak var imgMostPopularFood: UIImageView! // Displays food image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners & styling to food image
        styleViews([imgMostPopularFood], cornerRadius: 10, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }
    
    // MARK: - Configuration
    /// Configures the cell with a given product
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRatings.text = "\(item.floatProductRating)" // Convert rating to string
        imgMostPopularFood.image = UIImage(named: item.strProductImage) // Load image by name
    }
}
