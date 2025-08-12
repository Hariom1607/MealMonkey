//
//  FoodCategoryCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var imgFoodCategory: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        styleViews([imgFoodCategory], cornerRadius: 10, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }
    
    func configure(with category: ProductCategory) {
        lblFoodCategory.text = category.rawValue
        
        // Provide images for categories explicitly, e.g.:
        switch category {
        case .All:
            imgFoodCategory.image = UIImage(named: "ic_butternaan")
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
