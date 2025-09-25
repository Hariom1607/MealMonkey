//
//  FeatureCollectionViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

// Custom UICollectionViewCell to display a feature's image
class FeatureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgFeature: UIImageView!   // Image view to display the feature
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        // Initialization code (called after the cell is loaded from nib)
    }
    
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        contentView.backgroundColor = theme.secondaryFontColor.withAlphaComponent(0.1)
        imgFeature.tintColor = theme.iconTintColor   // if using template images
    }
    
    // MARK: - Configuration
    /// Configures the cell with a Feature model
    /// - Parameter model: Feature object containing imageName, title, and subtitle
    func configure(with model: Feature){
        imgFeature.image = UIImage(named: model.imageName) // Set the feature image
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
}
