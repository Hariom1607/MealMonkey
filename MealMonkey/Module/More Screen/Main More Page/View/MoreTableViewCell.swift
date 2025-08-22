//
//  MoreTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

/// Custom cell used to display an item in the "More" section.
class MoreTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Container view holding the icon and title (used for styling background/corner radius)
    @IBOutlet weak var viewMoreItems: UIView!
    
    /// Title label for the menu item
    @IBOutlet weak var lblTitleMore: UILabel!
    
    /// Icon image view for the menu item
    @IBOutlet weak var imgIconMore: UIImageView!
    
    @IBOutlet weak var btnNavigate: UIButton!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners and optional borders to the container view
        let allViews = [viewMoreItems!]
        styleViews(allViews, cornerRadius: 7, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Make the icon circular
        imgIconMore.layer.cornerRadius = imgIconMore.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Default selection handling
        btnNavigate.layer.cornerRadius = btnNavigate.frame.size.width / 2
        btnNavigate.clipsToBounds = true
    }
    
    // MARK: - Configuration
    
    /// Configure cell with `More` model
    /// - Parameter item: `More` object containing icon and title
    func configure(with item: More) {
        lblTitleMore.text = item.title
        imgIconMore.image = item.imgSection
        imgIconMore.tintColor = .systemOrange // Example: apply tint to SF Symbols
    }
}
