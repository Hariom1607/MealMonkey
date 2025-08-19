//
//  OrderListTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import UIKit

/// Custom table view cell used to display order details in a list
class OrderListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lblProductName: UILabel!   // Label to display product name
    @IBOutlet weak var lblTotalPrice: UILabel!    // Label to display total price of the order
    @IBOutlet weak var lblOrderNo: UILabel!       // Label to display order number
    @IBOutlet weak var imgOrder: UIImageView!     // Image view to display product/order image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Perform initial setup when the cell is loaded from nib/storyboard
        // Apply styling to the image view (rounded corners, etc.)
        styleViews([imgOrder!], cornerRadius: 14, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state (optional)
    }
}
