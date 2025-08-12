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
    
    func configure(with product: ProductModel){
        imgProduct.image = UIImage(named: product.strProductImage)
        lblCategoryName.text = "\(product.objProductCategory)"
        lblRestaurantName.text = "Meal Monkey" 
        lblRating.text = String(format: "%.1f", product.floatProductRating)
        lblProductName.text = product.strProductName
        imgShade.image = UIImage(named: "ic_shadeDesserts")
    }
    
}
