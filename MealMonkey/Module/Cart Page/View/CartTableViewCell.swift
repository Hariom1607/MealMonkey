//
//  CartTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnDeleteFoodItem: UIButton!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with product: ProductModel) {
        lblFoodName.text = product.strProductName
        imgProduct.image = UIImage(named: product.strProductImage)
        lblFoodPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblFoodType.text = product.objProductType.rawValue.capitalized
        lblFoodCategory.text = product.objProductCategory.rawValue
        lblQty.text = "QTY: \(product.intProductQty ?? 1)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteCartAction(_ sender: Any) {
        onDelete?()
    }
}
