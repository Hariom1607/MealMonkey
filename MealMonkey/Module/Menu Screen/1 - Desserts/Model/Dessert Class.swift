//
//  Dessert Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

// MARK: - Product Model Class
// Represents a single food product (used for desserts in this case)
class Product: NSObject {
    
    // MARK: - Properties
    let imageName: String         // Name of the product image in Assets
    let productName: String       // Name of the product (e.g., French Apple Pie)
    let categoryName: String      // Category of the product (e.g., Desserts)
    let restaurantName: String    // Restaurant offering this product
    let rating: String            // Product rating (stored as string, e.g., "4.9")
    let imageShade: String        // Overlay/shade image name for product UI
    
    // MARK: - Initializer
    init(imageName: String, productName: String, categoryName: String, restaurantName: String, rating: String, imageShade: String) {
        self.imageName = imageName
        self.productName = productName
        self.categoryName = categoryName
        self.restaurantName = restaurantName
        self.rating = rating
        self.imageShade = imageShade
    }
    
    // MARK: - Sample Data
    // Provides a static list of products (can be used for demo or mock data)
    class func allProducts() -> [Product] {
        return [
            Product(imageName: "ic_FrenchApplePie",
                    productName: "French Apple Pie",
                    categoryName: "Desserts",
                    restaurantName: "Minute by tuk tuk",
                    rating: "4.9",
                    imageShade: "ic_shadeDesserts"),
            
            Product(imageName: "ic_DarkChocolateCake",
                    productName: "Dark Chocolate Cake",
                    categoryName: "Desserts",
                    restaurantName: "Minute by tuk tuk",
                    rating: "4.9",
                    imageShade: "ic_shadeDesserts"),
            
            Product(imageName: "ic_Street Shake",
                    productName: "Street Shake",
                    categoryName: "Desserts",
                    restaurantName: "Minute by tuk tuk",
                    rating: "4.9",
                    imageShade: "ic_shadeDesserts"),
            
            Product(imageName: "ic_Fudgy Chew Brownies",
                    productName: "Fudgy Chewy Brownies",
                    categoryName: "Desserts",
                    restaurantName: "Minute by tuk tuk",
                    rating: "4.9",
                    imageShade: "ic_shadeDesserts")
        ]
    }
}
