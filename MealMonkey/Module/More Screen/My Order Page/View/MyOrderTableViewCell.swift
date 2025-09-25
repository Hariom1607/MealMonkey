//
//  MyOrderTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

// MARK: - UITableViewCell for displaying order details in My Orders screen
class MyOrderTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lblProductPrice: UILabel!   // Label for product price
    @IBOutlet weak var lblProductsName: UILabel!   // Label for product name
    @IBOutlet weak var lblProductQty: UILabel!     // Label for product quantity
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code (called after the cell is loaded from nib)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state (optional highlight styling)
    }
    
    func applyTheme() {
            let theme = ThemeManager.currentTheme
            
            lblProductsName.textColor = theme.primaryFontColor
            lblProductQty.textColor = theme.secondaryFontColor
            lblProductPrice.textColor = theme.primaryFontColor
            
            backgroundColor = theme.cellBackgroundColor
            contentView.backgroundColor = theme.cellBackgroundColor
        }
}
