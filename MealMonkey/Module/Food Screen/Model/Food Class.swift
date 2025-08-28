////
//  Food Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
////

import Foundation

// Represents a product item (food, beverage, etc.)
class ProductModel: Codable {
    var intId: Int = 0                        // Unique ID for the product
    var strProductName: String = ""           // Product name
    var strProductDescription: String = ""    // Product description
    var floatProductRating: Float = 0.0       // Product rating (0-5)
    var doubleProductPrice: Double = 0.0      // Product price
    var strProductImage: String = ""          // Image name or path
    var intProductQty: Int? = nil             // Quantity (optional)
    var intTotalNumberOfRatings: Int = 0      // Total number of ratings
    var objProductCategory: ProductCategory = .Gujarati // Category type
    var objProductType: ProductType = .food   // Product type
    
    // Default initializer
    init() {}
    
    // Convenience initializer for manual creation
    init(
        intId: Int = 0,
        strProductName: String = "",
        strProductDescription: String = "",
        floatProductRating: Float = 0.0,
        doubleProductPrice: Double = 0.0,
        strProductImage: String = "",
        intProductQty: Int? = nil,
        intTotalNumberOfRatings: Int = 0,
        objProductCategory: ProductCategory = .Gujarati,
        objProductType: ProductType = .food
    ) {
        self.intId = intId
        self.strProductName = strProductName
        self.strProductDescription = strProductDescription
        self.floatProductRating = floatProductRating
        self.doubleProductPrice = doubleProductPrice
        self.strProductImage = strProductImage
        self.intProductQty = intProductQty
        self.intTotalNumberOfRatings = intTotalNumberOfRatings
        self.objProductCategory = objProductCategory
        self.objProductType = objProductType
    }
    
    // Codable initializer (for JSON decoding)
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.intId = try container.decode(Int.self, forKey: .intId)
        self.strProductName = try container.decode(String.self, forKey: .strProductName)
        self.strProductDescription = try container.decode(String.self, forKey: .strProductDescription)
        self.floatProductRating = try container.decode(Float.self, forKey: .floatProductRating)
        self.doubleProductPrice = try container.decode(Double.self, forKey: .doubleProductPrice)
        self.strProductImage = try container.decode(String.self, forKey: .strProductImage)
        self.intProductQty = try container.decodeIfPresent(Int.self, forKey: .intProductQty)
        self.intTotalNumberOfRatings = try container.decode(Int.self, forKey: .intTotalNumberOfRatings)
        self.objProductCategory = try container.decode(ProductCategory.self, forKey: .objProductCategory)
        self.objProductType = try container.decode(ProductType.self, forKey: .objProductType)
    }
    
    // Keys used for encoding/decoding
    enum CodingKeys: String, CodingKey {
        case intId, strProductName, strProductDescription, floatProductRating,
             doubleProductPrice, strProductImage, intProductQty, intTotalNumberOfRatings,
             objProductCategory, objProductType
    }
}

// Product type options
enum ProductType: String, Codable {
    case food
    case Beverages
    case Desserts
}

// Food categories available in app
enum ProductCategory: String, Codable, CaseIterable {
    case All
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}
