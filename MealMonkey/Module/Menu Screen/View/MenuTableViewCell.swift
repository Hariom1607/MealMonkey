//
//  MenuTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnRightClick: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnRightClick.layer.cornerRadius = btnRightClick.frame.size.width / 2
        btnRightClick.clipsToBounds = true
    }
    
    @IBAction func btnRightClickAction(_ sender: Any) {
        
    }
}
