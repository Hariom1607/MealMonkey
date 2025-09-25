//
//  AboutUsTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

/// A reusable table view cell that adapts to different sections of the app:
/// - About Us
/// - Notifications
/// - Inbox
class AboutUsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewCellBack: UIView!
    /// Constraint for controlling date label width dynamically
    @IBOutlet weak var widthLblDate: NSLayoutConstraint!
    
    /// Subtitle label (used for notification time or inbox description)
    @IBOutlet weak var lblSubTitle: UILabel!
    
    /// Star button (visible only for inbox messages)
    @IBOutlet weak var btnStar: UIButton!
    
    /// Date label (used in inbox for "6th July" etc.)
    @IBOutlet weak var lblDate: UILabel!
    
    /// Main title label (used across all cell types)
    @IBOutlet weak var lblTitle: UILabel!
    
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        
        // Listen for theme change
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(themeChanged),
                name: NSNotification.Name("themeChanged"),
                object: nil
            )
    }
    
    @objc private func themeChanged() {
        applyTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view when the cell is selected
    }
    
    func applyTheme() {
        let theme = ThemeManager.currentTheme
        contentView.backgroundColor = theme.backgroundColor
        viewCellBack.backgroundColor = theme.cellBackgroundColor // use cellBackgroundColor here
        lblTitle.textColor = theme.primaryFontColor
        lblSubTitle.textColor = theme.secondaryFontColor
        lblDate.textColor = theme.labelColor
        btnStar.tintColor = theme.buttonColor
    }

    // MARK: - Configuration Methods
    
    /// Configures the cell for **About Us** screen
    func configureAboutUsCell(about: AboutModel) {
        lblTitle.text = about.strText
        
        // Hide unused UI elements
        lblDate.isHidden = true
        lblSubTitle.isHidden = true
        btnStar.isHidden = true
        widthLblDate.constant = 0
        applyTheme()

    }
    
    /// Configures the cell for **Notifications** screen
    func configureNotificationCell(about: AboutModel) {
        lblTitle.text = about.strText
        lblSubTitle.text = about.strTimezone
        
        // Hide unused UI elements
        lblDate.isHidden = true
        btnStar.isHidden = true
        widthLblDate.constant = 0
        applyTheme()

    }
    
    /// Configures the cell for **Inbox** screen
    func configureInboxCell(about: AboutModel) {
        lblTitle.text = about.strText
        lblSubTitle.text = about.strText2
        lblDate.text = about.strRightSideText
        
        // Show star button for inbox messages
        btnStar.isHidden = false
        applyTheme()

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
}

/// Enum used to distinguish which type of page/cell is being displayed
enum PageType {
    case Notifications
    case Inbox
    case AboutUs
}
