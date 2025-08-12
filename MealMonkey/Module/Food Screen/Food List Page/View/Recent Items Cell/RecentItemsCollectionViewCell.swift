//
//  RecentItemsCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class RecentItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblTotalNoOfRatings: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodType.text = item.objProductType.rawValue
        lblFoodRating.text = "\(item.floatProductRating)"
        lblTotalNoOfRatings.text = "\(item.intTotalNumberOfRatings)"
        imgFood.image = UIImage(named: item.strProductImage)
    }
    
}
