//
//  FoodCategoryCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

// Cell to display food category in collection view
class FoodCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFoodCategory: UILabel!     // Label for category name
    @IBOutlet weak var imgFoodCategory: UIImageView! // Image for category
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Style category image
        styleViews([imgFoodCategory], cornerRadius: 10, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }
    
    // Configure cell with given product category
    func configure(with category: ProductCategory) {
        lblFoodCategory.text = category.rawValue
        
        switch category {
        case .All:
            imgFoodCategory.image = UIImage(named: Main.images.appLogo)
        case .Punjabi:
            imgFoodCategory.image = UIImage(named: Main.images.punjabi)
        case .Chinese:
            imgFoodCategory.image = UIImage(named: Main.images.chinese)
        case .Gujarati:
            imgFoodCategory.image = UIImage(named: Main.images.gujarati)
        case .SouthIndian:
            imgFoodCategory.image = UIImage(named: Main.images.southIndian)
        case .WesternFood:
            imgFoodCategory.image = UIImage(named: Main.images.westernFood)
        }
    }
}
