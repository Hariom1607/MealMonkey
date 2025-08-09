//
//  Dessert Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

class Product: NSObject{
    
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
