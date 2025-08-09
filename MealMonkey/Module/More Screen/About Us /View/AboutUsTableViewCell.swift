//
//  AboutUsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var widthLblDate: NSLayoutConstraint!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureAboutUsCell(about: AboutModel) {
        lblTitle.text = about.strText
        lblDate.isHidden = true
        lblSubTitle.isHidden = true
        btnStar.isHidden = true
        widthLblDate.constant = 0
    }
    
    func configureNotificationCell(about: AboutModel) {
        lblTitle.text = about.strText
        lblSubTitle.text = about.strTimezone
        lblDate.isHidden = true
        btnStar.isHidden = true
        widthLblDate.constant = 0
    }
    
    func configureInboxCell(about: AboutModel) {
        lblTitle.text = about.strText
        lblSubTitle.text = about.strText2
        lblDate.text = about.strRightSideText
        btnStar.isHidden = false
    }
    
}

enum PageType {
    case Notifications
    case Inbox
    case AboutUs
}
