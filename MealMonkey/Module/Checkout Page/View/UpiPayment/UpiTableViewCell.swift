//
//  UpiTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class UpiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewUpi: UIView!
    @IBOutlet weak var lblUpiId: UILabel!
    @IBOutlet weak var btnUpiSelection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let allviews = [viewUpi!]
        styleViews(allviews, cornerRadius: 6, borderWidth: 1, borderColor: UIColor.black.cgColor)
        
        btnUpiSelection.setImage(UIImage(systemName: "circle"), for: .normal)
        btnUpiSelection.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnUpiSelection.tintColor = .loginButton // Or whatever color you want
        btnUpiSelection.backgroundColor = .clear
        btnUpiSelection.layer.cornerRadius = btnUpiSelection.frame.height / 2
        btnUpiSelection.clipsToBounds = true
        
        self.selectionStyle = .none

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnUpiAction(_ sender: Any) {
    }
}
