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
        styleViews(allviews, cornerRadius: 6, borderWidth: 1, borderColor: UIColor.black.cgColor)    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnUpiAction(_ sender: Any) {
    }
}
