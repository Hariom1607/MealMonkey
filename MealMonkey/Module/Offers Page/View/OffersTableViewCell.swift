//
//  OffersTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class OffersTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblRestaurantType: UILabel!
    @IBOutlet weak var lblNoOfRatings: UILabel!
    @IBOutlet weak var lblCafeName: UILabel!
    @IBOutlet weak var imgCafe: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Optional: make image rounded or styled here if needed
        imgCafe.layer.cornerRadius = 10
        imgCafe.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        lblCafeName.textColor = theme.primaryFontColor
        lblFoodType.textColor = theme.secondaryFontColor
        lblRestaurantType.textColor = theme.secondaryFontColor
        lblNoOfRatings.textColor = theme.secondaryFontColor
        
        backgroundColor = theme.cellBackgroundColor
        contentView.backgroundColor = theme.cellBackgroundColor
    }
    
    // MARK: - Configure Cell
    func configure(with offer: Offer) {
        imgCafe.image = UIImage(named: offer.imageCafe)
        lblCafeName.text = offer.cafeName
        lblFoodType.text = offer.foodType
        lblRestaurantType.text = offer.restaurantType
        lblNoOfRatings.text = offer.noOfRatings
    }
}
