import Foundation

// Save the current cart (array of product dictionaries) to UserDefaults
func saveCartToUserDefaults(cartArray: [[String: Any]]) {
    UserDefaults.standard.set(cartArray, forKey: "SavedCart")
}

// Load the saved cart from UserDefaults
func loadCartFromUserDefaults() -> [[String: Any]] {
    return UserDefaults.standard.array(forKey: "SavedCart") as? [[String: Any]] ?? []
}

// Convert ProductModel → Dictionary (so it can be stored in UserDefaults)
func productToDict(_ product: ProductModel) -> [String: Any] {
    return [
        "intId": product.intId,
        "strProductName": product.strProductName,
        "strProductImage": product.strProductImage,
        "strProductDescription": product.strProductDescription,
        "doubleProductPrice": product.doubleProductPrice,
        "floatProductRating": product.floatProductRating,
        "intTotalNumberOfRatings": product.intTotalNumberOfRatings,
        "objProductType": product.objProductType.rawValue,
        "objProductCategory": product.objProductCategory.rawValue,
        "intProductQty": product.intProductQty ?? 1
    ]
}

// Convert Dictionary → ProductModel (for loading saved products back into objects)
func dictToProduct(_ dict: [String: Any]) -> ProductModel {
    return ProductModel(
        intId: dict["intId"] as? Int ?? 0,
        strProductName: dict["strProductName"] as? String ?? "",
        strProductDescription: dict["strProductDescription"] as? String ?? "",
        floatProductRating: Float(dict["floatProductRating"] as? Double ?? 0.0),
        doubleProductPrice: dict["doubleProductPrice"] as? Double ?? 0.0,
        strProductImage: dict["strProductImage"] as? String ?? "",
        intProductQty: dict["intProductQty"] as? Int,
        intTotalNumberOfRatings: dict["intTotalNumberOfRatings"] as? Int ?? 0,
        objProductCategory: ProductCategory(rawValue: dict["objProductCategory"] as? String ?? "") ?? .Gujarati,
        objProductType: ProductType(rawValue: dict["objProductType"] as? String ?? "") ?? .food
    )
}

// Save a list of orders (each order is an array of products) to UserDefaults
func saveOrdersToUserDefaults(_ orders: [[ProductModel]]) {
    let ordersArray = orders.map { order in
        order.map { product in
            productToDict(product)
        }
    }
    UserDefaults.standard.set(ordersArray, forKey: "orders")
}

// Load saved orders (restore them back into [[ProductModel]])
func loadOrdersFromUserDefaults() -> [[ProductModel]] {
    guard let savedOrders = UserDefaults.standard.array(forKey: "orders") as? [[[String: Any]]] else {
        return []
    }
    return savedOrders.map { orderDictArray in
        orderDictArray.map { dictToProduct($0) }
    }
}
