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
        
        // Set category-specific image
        switch category {
        case .All:
            imgFoodCategory.image = UIImage(named: "ic_AppLogo")
        case .Punjabi:
            imgFoodCategory.image = UIImage(named: "ic_paneertikka")
        case .Chinese:
            imgFoodCategory.image = UIImage(named: "ic_hakkanoodles")
        case .Gujarati:
            imgFoodCategory.image = UIImage(named: "Ic_Khaman_Dhokla")
        case .SouthIndian:
            imgFoodCategory.image = UIImage(named: "ic_masaladosa")
        case .WesternFood:
            imgFoodCategory.image = UIImage(named: "ic_margherita_pizza")
        }
    }
}
