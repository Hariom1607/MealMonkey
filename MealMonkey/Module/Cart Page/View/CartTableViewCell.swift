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
    
    func configure(with cartItem: CartItem) {
        lblFoodName.text = cartItem.name
        imgProduct.image = UIImage(named: cartItem.image ?? "")
        lblFoodPrice.text = "$\(String(format: "%.2f", cartItem.price))"
        lblQty.text = "QTY: \(cartItem.quantity)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteCartAction(_ sender: Any) {
        onDelete?()
    }
}
