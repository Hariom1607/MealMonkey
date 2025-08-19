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
        Feature(imageName: "ic_1x_Find food you love",
                title: "Find Food You Love",
                subTitle: "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"),
        
        Feature(imageName: "ic_1x_Delivery vector",
                title: "Fast Delivery",
                subTitle: "Fast food delivery to your home, office wherever you are"),
        
        Feature(imageName: "ic_1x_Live tracking vector",
                title: "Live Tracking",
                subTitle: "Real time tracking of your food on the app once you placed the order")
    ]
}
