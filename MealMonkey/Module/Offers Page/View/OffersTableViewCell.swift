//
//  OffersTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    @IBOutlet weak var noOfRatings: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var imgCafe: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with offer: offer){
        imgCafe.image = UIImage(named: offer.imageCafe)
        cafeName.text = offer.strCafeName
        foodType.text = offer.strFoodType
        restaurantType.text = offer.strRestaurantType
        noOfRatings.text = offer.strNoOfRatings
    }
    
}
