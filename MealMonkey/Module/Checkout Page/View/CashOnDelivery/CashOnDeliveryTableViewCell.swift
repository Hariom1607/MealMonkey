//
//  CashOnDeliveryTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

/// Custom cell representing the "Cash on Delivery" payment option
class CashOnDeliveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCash: UIView!                       // Container view
    @IBOutlet weak var btnCashOnDeliverySelection: UIButton!   // Selection button
    
    /// Closure to notify the parent controller when this payment option is selected
    var onCashSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners & border styling to container
        styleViews([viewCash!],
                   cornerRadius: 6,
                   borderWidth: 1,
                   borderColor: UIColor.black.cgColor)
        
        // Configure selection button
        btnCashOnDeliverySelection.setImage(UIImage(systemName: "circle"), for: .normal)
        btnCashOnDeliverySelection.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnCashOnDeliverySelection.tintColor = .loginButton
        btnCashOnDeliverySelection.backgroundColor = .clear
        btnCashOnDeliverySelection.layer.cornerRadius = btnCashOnDeliverySelection.frame.height / 2
        btnCashOnDeliverySelection.clipsToBounds = true
        
        // Remove default gray cell highlight
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Default override — no custom behavior
    }
    
    /// Action when "Cash on Delivery" button is tapped
    @IBAction func btnCashOnDeliverySelectionAction(_ sender: Any) {
        onCashSelected?()  // Notify parent VC
    }
}
