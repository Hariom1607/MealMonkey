//
//  CardTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

/// Custom table view cell for displaying a saved card
class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!                // Container view for card UI
    @IBOutlet weak var btnCardSelection: UIButton!      // Button to select card
    @IBOutlet weak var lblCardNumber: UILabel!          // Label to show masked card number
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners & border styling to card container
        let allviews = [viewCard!]
        styleViews(allviews,
                   cornerRadius: 6,
                   borderWidth: 1,
                   borderColor: UIColor.black.cgColor)
        
        // Configure selection button with two states: normal & selected
        btnCardSelection.setImage(UIImage(systemName: Main.images.circle)?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnCardSelection.setImage(UIImage(systemName: Main.images.circleFill)?.withRenderingMode(.alwaysTemplate), for: .selected)
        btnCardSelection.backgroundColor = .clear
        btnCardSelection.layer.cornerRadius = btnCardSelection.frame.height / 2
        btnCardSelection.clipsToBounds = true
        
        // Disable default gray selection highlight of UITableViewCell
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Default override → no custom behavior
    }
    
    func applyTheme() {
        let theme = ThemeManager.currentTheme
        viewCard.backgroundColor = theme.cellBackgroundColor
        lblCardNumber.textColor = theme.primaryFontColor
        btnCardSelection.tintColor = theme.buttonColor
    }
    
    /// Action for selecting a card
    @IBAction func btnCardSelectionAction(_ sender: Any) {
        // TODO: Handle card selection (notify controller or update UI)
    }
}
