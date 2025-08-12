//
//  MostPopularCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var imgMostPopularFood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleViews([imgMostPopularFood], cornerRadius: 10, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRatings.text = "\(item.floatProductRating)"
        imgMostPopularFood.image = UIImage(named: item.strProductImage)
    }

}
