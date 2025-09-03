//
//  Feature Data.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

// Model class to represent a feature in the onboarding / info screen
class Feature: NSObject{
    
    // MARK: - Properties
    let imageName: String   // Name of the image asset
    let title: String       // Feature title (headline)
    let subTitle: String    // Short description of the feature
    
    // MARK: - Initializer
    init(imageName: String, title: String, subTitle: String) {
        self.imageName = imageName
        self.title = title
        self.subTitle = subTitle
    }
    
    // MARK: - Static Data Source
    // Example features used to populate onboarding screens or feature highlights
    static let features: [Feature] = [
        Feature(imageName: Main.images.featureFindFood,
                title: Main.FeatureTexts.findFoodTitle,
                subTitle: Main.FeatureTexts.findFoodSubTitle),
        
        Feature(imageName: Main.images.featureFastDelivery,
                title: Main.FeatureTexts.fastDeliveryTitle,
                subTitle: Main.FeatureTexts.fastDeliverySubTitle),
        
        Feature(imageName: Main.images.featureLiveTracking,
                title: Main.FeatureTexts.liveTrackingTitle,
                subTitle: Main.FeatureTexts.liveTrackingSubTitle)
    ]
}
