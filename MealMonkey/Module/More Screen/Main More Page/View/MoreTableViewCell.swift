//
//  MoreTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMoreItems: UIView!
    @IBOutlet weak var lblTitleMore: UILabel!
    @IBOutlet weak var imgIconMore: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let allViews = [viewMoreItems!]
        styleViews(allViews, cornerRadius: 7, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        imgIconMore.layer.cornerRadius = imgIconMore.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
