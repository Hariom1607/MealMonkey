//
//  DessertsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgShade: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnRatingStar: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with product: Product){
        imgProduct.image = UIImage(named: product.imageName)
        lblCategoryName.text = product.categoryName
        lblRestaurantName.text = product.restaurantName
        lblRating.text = product.rating
        lblProductName.text = product.productName
        imgShade.image = UIImage(named: product.imageShade)
    }
    
}
