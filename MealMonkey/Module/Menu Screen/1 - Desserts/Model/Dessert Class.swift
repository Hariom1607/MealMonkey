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
    let imageName: String
    let productName: String
    let categoryName: String
    let restaurantName: String
    let rating: String
    let imageShade: String
    
    init(imageName: String, productName: String, categoryName: String, restaurantName: String, rating: String, imageShade: String) {
        self.imageName = imageName
        self.productName = productName
        self.categoryName = categoryName
        self.restaurantName = restaurantName
        self.rating = rating
        self.imageShade = imageShade
    }
    
    class func allProducts() -> [Product] {
        return [
            Product(imageName: Main.images.frenchApplePie,
                    productName: Main.ProductNames.frenchApplePie,
                    categoryName: Main.MenuCategories.desserts,
                    restaurantName: Main.Restaurants.minuteByTukTuk,
                    rating: Main.Ratings.defaultRating,
                    imageShade: Main.images.shadeDesserts),
            
            Product(imageName: Main.images.darkChocolateCake,
                    productName: Main.ProductNames.darkChocolateCake,
                    categoryName: Main.MenuCategories.desserts,
                    restaurantName: Main.Restaurants.minuteByTukTuk,
                    rating: Main.Ratings.defaultRating,
                    imageShade: Main.images.shadeDesserts),
            
            Product(imageName: Main.images.streetShake,
                    productName: Main.ProductNames.streetShake,
                    categoryName: Main.MenuCategories.desserts,
                    restaurantName: Main.Restaurants.minuteByTukTuk,
                    rating: Main.Ratings.defaultRating,
                    imageShade: Main.images.shadeDesserts),
            
            Product(imageName: Main.images.fudgyChewyBrownies,
                    productName: Main.ProductNames.fudgyChewyBrownies,
                    categoryName: Main.MenuCategories.desserts,
                    restaurantName: Main.Restaurants.minuteByTukTuk,
                    rating: Main.Ratings.defaultRating,
                    imageShade: Main.images.shadeDesserts)
        ]
    }
}
