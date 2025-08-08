//
//  PaymentDetailsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewCardCell: UIView!
    @IBOutlet weak var btnDeleteCard: UIButton!
    @IBOutlet weak var lblCardNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        btnDeleteCard.layer.cornerRadius = btnDeleteCard.frame.size.height/2
        btnDeleteCard.layer.borderColor = UIColor.loginButton.cgColor
        btnDeleteCard.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDeleteCardAction(_ sender: Any) {
    }
    
}
