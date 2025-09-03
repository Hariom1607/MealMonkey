//
//  Menu Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

/// Represents a menu category (e.g., Food, Beverages, Desserts)
class Menu {
    
    /// Optional image name for the menu item (e.g., icon in assets)
    let imageName: String?
    
    /// Display name of the menu item
    let strName: String
    
    /// Quantity description (e.g., "120 Items")
    let strQuantity: String
    
    /// Initializer
    init(imageName: String?, strName: String, strQuantity: String) {
        self.imageName = imageName
        self.strName = strName
        self.strQuantity = strQuantity
    }
    
    /// Returns a sample menu list (used to populate UI)
    class func populateMenu() -> [Menu] {
        return [
            Menu(imageName: Main.images.foodMenu,
                 strName: Main.MenuCategories.food,
                 strQuantity: Main.MenuCounts.food),
            
            Menu(imageName: Main.images.beveragesMenu,
                 strName: Main.MenuCategories.beverages,
                 strQuantity: Main.MenuCounts.beverages),
            
            Menu(imageName: Main.images.dessertsMenu,
                 strName: Main.MenuCategories.desserts,
                 strQuantity: Main.MenuCounts.desserts)
        ]
    }
}
