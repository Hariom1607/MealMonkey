//
//  UI WishList .swift
//  MealMonkey
//
//  Created by Hariom Sharma on 15/08/25.
//

import Foundation

func saveWishlist(_ wishlist: [ProductModel], forUser user: String) {
    guard !user.isEmpty else { return }
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(wishlist) {
        UserDefaults.standard.set(encoded, forKey: "wishlist_\(user)")
        UserDefaults.standard.synchronize()
    }
}

func loadWishlist(forUser user: String) -> [ProductModel] {
    guard !user.isEmpty else { return [] }
    let decoder = JSONDecoder()
    if let data = UserDefaults.standard.data(forKey: "wishlist_\(user)"),
       let wishlist = try? decoder.decode([ProductModel].self, from: data) {
        return wishlist
    }
    return []
}
