//
//  More Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

/// Model class representing items in the "More" section of the app.
/// Each item contains an image (system or asset-based) and a title.
class More: NSObject {
    
    // MARK: - Properties
    
    /// The icon for the menu item (can be from system symbols or asset catalog)
    let imgSection: UIImage?
    
    /// The title/label of the menu item
    let title: String
    
    // MARK: - Initializer
    
    /// Initializes a More menu item with image name and title
    /// - Parameters:
    ///   - imgSection: Image name (system symbol or asset name)
    ///   - title: Title of the menu item
    init(imgSection: String, title: String) {
        // Check if provided image name matches a system symbol (SF Symbol)
        if let systemImage = UIImage(systemName: imgSection) {
            // Use system symbol and set rendering mode to template (so tint color can be applied)
            self.imgSection = systemImage.withRenderingMode(.alwaysTemplate)
        } else {
            // Fallback to app asset image
            self.imgSection = UIImage(named: imgSection)
        }
        
        self.title = title
    }
    
    // MARK: - Static Items
    
    /// Predefined list of items displayed in the "More" section
    static var items: [More] {
        return [
            More(imgSection: Main.images.paymentDetails, title: Main.Labels.morePaymentDetails),
            More(imgSection: Main.images.myOrders, title: Main.Labels.moreMyOrders),
            More(imgSection: Main.images.notifications, title: Main.Labels.moreNotifications),
            More(imgSection: Main.images.inbox, title: Main.Labels.moreInbox),
            More(imgSection: Main.images.heartfill, title: Main.Labels.moreWishlist),
            More(imgSection: Main.images.aboutUs, title: Main.Labels.moreAboutUs),
            More(imgSection: Main.images.language, title: Main.Labels.moreLanguages),
            More(imgSection: Main.images.palette, title: Main.Labels.moreThemes) // NEW THEME ROW
        ]
    }

}
