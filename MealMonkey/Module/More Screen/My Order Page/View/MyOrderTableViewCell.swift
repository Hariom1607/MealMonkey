//
//  MyOrderTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblBillProductPrice: UIStackView!
    @IBOutlet weak var lblBillProductName: UIStackView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
