//
//  CardTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var btnCardSelection: UIButton!
    @IBOutlet weak var lblCardNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let allviews = [viewCard!]
        styleViews(allviews, cornerRadius: 6, borderWidth: 1, borderColor: UIColor.black.cgColor)
        
        btnCardSelection.setImage(UIImage(systemName: "circle"), for: .normal)
        btnCardSelection.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnCardSelection.tintColor = .loginButton // Or whatever color you want
        btnCardSelection.backgroundColor = .clear
        btnCardSelection.layer.cornerRadius = btnCardSelection.frame.height / 2
        btnCardSelection.clipsToBounds = true

        self.selectionStyle = .none

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnCardSelectionAction(_ sender: Any) {
    }
}
