//
//  CashOnDeliveryTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class CashOnDeliveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCash: UIView!
    @IBOutlet weak var btnCashOnDeliverySelection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let allviews = [viewCash!]
        styleViews(allviews, cornerRadius: 6, borderWidth: 1, borderColor: UIColor.black.cgColor)
        
        btnCashOnDeliverySelection.setImage(UIImage(systemName: "circle"), for: .normal)
        btnCashOnDeliverySelection.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnCashOnDeliverySelection.tintColor = .loginButton // Or whatever color you want
        btnCashOnDeliverySelection.backgroundColor = .clear
        btnCashOnDeliverySelection.layer.cornerRadius = btnCashOnDeliverySelection.frame.height / 2
        btnCashOnDeliverySelection.clipsToBounds = true
        
        self.selectionStyle = .none

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func btnAddNewCardAction(_ sender: Any) {
    }
    
}
