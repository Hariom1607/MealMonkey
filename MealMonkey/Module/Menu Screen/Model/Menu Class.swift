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
            Menu(imageName: "ic_1x_FoodMenu",
                 strName: "Food",
                 strQuantity: "120 Items"),
            
            Menu(imageName: "ic_1x_BeveragesMenu",
                 strName: "Beverages",
                 strQuantity: "220 Items"),
            
            Menu(imageName: "ic_1x_DesertMenu",  // ⚠️ Typo? Should it be "DessertMenu"?
                 strName: "Desserts",
                 strQuantity: "155 Items")
        ]
    }
}
