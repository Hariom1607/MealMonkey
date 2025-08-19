//
//  UI Recent Items.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 11/08/25.
//

import Foundation

// Helper class to manage recently viewed products
class RecentItemsHelper {
    
    // Singleton instance
    static let shared = RecentItemsHelper()
    
    // Private init to prevent multiple instances
    private init() {}
    
    // List of recent products (most recent at index 0)
    private var recentItems: [ProductModel] = []
    
    // Maximum number of items to keep
    private let maxItems = 7
    
    // Add a product to recent items
    func addProduct(_ product: ProductModel) {
        // Remove existing product if already in list
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            recentItems.remove(at: existingIndex)
        }
        // Insert at the front (most recent)
        recentItems.insert(product, at: 0)
        
        // Keep only up to maxItems
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    // Get all recent items (most recent first)
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    
    // Clear all recent items
    func clear() {
        recentItems.removeAll()
    }
}
