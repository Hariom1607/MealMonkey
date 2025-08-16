//
//  OrderListTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var imgOrder: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleViews([imgOrder!], cornerRadius: 14, borderWidth: 0, borderColor: UIColor.black.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
