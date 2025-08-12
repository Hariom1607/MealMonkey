//
//  PopularFoodCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class PopularFoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgfood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodRating.text = "\(item.floatProductRating)"
        lblFoodType.text = "\(item.objProductType.rawValue)"
        imgfood.image = UIImage(named: item.strProductImage)
    }
    
}
