//
//  PaymentDetailsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

// MARK: - Delegate Protocol
/// Used to notify the view controller when the delete button is tapped in a cell
protocol PaymentDetailsCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell)
}

// MARK: - PaymentDetailsTableViewCell
/// Custom cell that represents a saved payment card with a delete option
class PaymentDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var ViewCardCell: UIView!       // Container view for the card cell
    @IBOutlet weak var btnDeleteCard: UIButton!    // Button to delete the card
    @IBOutlet weak var lblCardNumber: UILabel!     // Label to display masked card number
    
    // MARK: - Delegate
    weak var delegate: PaymentDetailsCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style delete button (round with border)
        btnDeleteCard.layer.cornerRadius = btnDeleteCard.frame.size.height / 2
        btnDeleteCard.layer.borderColor = UIColor.loginButton.cgColor
        btnDeleteCard.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Keep default selection behavior
    }
    
    // MARK: - Actions
    /// Called when delete button is tapped, informs delegate
    @IBAction func btnDeleteCardAction(_ sender: Any) {
        delegate?.didTapDeleteButton(in: self)
    }
}
