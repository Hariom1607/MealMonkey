//
//  MenuTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

/// Custom cell used to display a menu item (Food, Beverages, Desserts, etc.)
class MenuTableViewCell: UITableViewCell {
    
    /// Right-side button (likely used for navigation/selection)
    @IBOutlet weak var btnRightClick: UIButton!
    
    /// Menu item name label (e.g., "Food")
    @IBOutlet weak var lblName: UILabel!
    
    /// Quantity label (e.g., "120 Items")
    @IBOutlet weak var lblQuantity: UILabel!
    
    /// Image representing the menu category
    @IBOutlet weak var imgItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code after cell is loaded from XIB/Storyboard
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure appearance when cell is selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make the right-side button perfectly circular
        btnRightClick.layer.cornerRadius = btnRightClick.frame.size.width / 2
        btnRightClick.clipsToBounds = true
    }
    
    func applyTheme(_ theme: Theme) {
        contentView.backgroundColor = .clear
        lblName.textColor = theme.labelColor
        lblQuantity.textColor = theme.secondaryFontColor
        btnRightClick.backgroundColor = theme.buttonColor
        btnRightClick.tintColor = .white
    }

    /// Action triggered when right button is tapped
    @IBAction func btnRightClickAction(_ sender: Any) {
        // TODO: Handle right-click button tap (e.g., navigate, open details)
    }
}
