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
        // Initialization code (called after the cell is loaded from nib)
    }
    
    // MARK: - Configuration
    /// Configures the cell with a Feature model
    /// - Parameter model: Feature object containing imageName, title, and subtitle
    func configure(with model: Feature){
        imgFeature.image = UIImage(named: model.imageName) // Set the feature image
    }
}
