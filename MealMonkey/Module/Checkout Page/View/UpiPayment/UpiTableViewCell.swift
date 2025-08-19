//
//  UpiTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

/// Custom cell representing a UPI payment option
class UpiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewUpi: UIView!                  // Container view
    @IBOutlet weak var lblUpiId: UILabel!                // Displays UPI ID
    @IBOutlet weak var btnUpiSelection: UIButton!        // Selection button
    
    /// Closure to notify parent VC when UPI option is selected
    var onUpiSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style the container view
        styleViews([viewUpi!],
                   cornerRadius: 6,
                   borderWidth: 1,
                   borderColor: UIColor.black.cgColor)
        
        // Configure UPI selection button
        btnUpiSelection.setImage(UIImage(systemName: "circle"), for: .normal)
        btnUpiSelection.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnUpiSelection.tintColor = .loginButton
        btnUpiSelection.backgroundColor = .clear
        btnUpiSelection.layer.cornerRadius = btnUpiSelection.frame.height / 2
        btnUpiSelection.clipsToBounds = true
        
        // Disable gray selection highlight
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Default override — no extra customization
    }
    
    /// Action when UPI option is tapped
    @IBAction func btnUpiAction(_ sender: Any) {
        onUpiSelected?()  // Notify parent VC
    }
}
