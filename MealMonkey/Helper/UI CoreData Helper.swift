import Foundation
import CoreData
import UIKit

// Helper class to manage Core Data operations
class CoreDataHelper {
    // Singleton instance
    static let shared = CoreDataHelper()
    private init() {}
    
    // Context for Core Data operations
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // Persistent container reference
    private var persistentContainer: NSPersistentContainer {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    // Save changes in Core Data
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Core Data changes saved")
            } catch {
                print("❌ Failed to save context: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - USER FUNCTIONS
    
    // Save a new user (returns false if already exists)
    func saveUser(name: String, email: String, password: String, address: String, mobile: String) -> Bool {
        if fetchUser(byEmail: email) != nil {
            return false
        }
        
        let user = User(context: context)
        user.name = name
        user.email = email
        user.password = password
        user.address = address
        user.mobile = mobile
        user.id = UUID()
        
        do {
            try context.save()
            print("✅ User saved: \(email)")
            return true
        } catch {
            print("❌ Failed to save user: \(error)")
            return false
        }
    }
    
    // Verify user credentials
    func verifyUser(email: String, password: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to verify user: \(error)")
            return nil
        }
    }
    
    // Fetch user by email
    func fetchUser(byEmail email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return try? context.fetch(request).first
    }
    
    // Update user details (including profile image)
    func updateUser(email: String,
                    name: String?,
                    mobile: String?,
                    address: String?,
                    password: String?,
                    imageData: Data?) -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            if let user = try context.fetch(request).first {
                if let name = name { user.name = name }
                if let mobile = mobile { user.mobile = mobile }
                if let address = address { user.address = address }
                if let password = password { user.password = password }
                if let imageData = imageData { user.imageData = imageData }
                
                try context.save()
                print("✅ User updated: \(email)")
                return true
            }
        } catch {
            print("❌ Failed to update user: \(error.localizedDescription)")
        }
        return false
    }
    
    // Fetch user by email (duplicate function with logging)
    func fetchUser(email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - WISHLIST FUNCTIONS
    
    // Fetch wishlist products for a user
    func fetchWishlistProducts(for userEmail: String) -> [ProductModel] {
        let fetchRequest: NSFetchRequest<Wishlist_Item> = Wishlist_Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        
        do {
            let wishlistItems = try context.fetch(fetchRequest)
            let productIds = wishlistItems.map { Int($0.productId) }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.allProducts.filter { productIds.contains($0.intId) }
        } catch {
            print("❌ Failed to fetch wishlist products: \(error.localizedDescription)")
            return []
        }
    }
    
    // Check if product is in wishlist
    func isInWishlist(productId: Int, userEmail: String) -> Bool {
        let fetchRequest: NSFetchRequest<Wishlist_Item> = Wishlist_Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@ AND productId == %d", userEmail, productId)
        
        do {
            return try context.count(for: fetchRequest) > 0
        } catch {
            print("❌ Error checking wishlist: \(error)")
            return false
        }
    }
    
    // Add product to wishlist
    func addToWishlist(productId: Int, userEmail: String) {
        if isInWishlist(productId: productId, userEmail: userEmail) { return }
        
        let wishlistItem = Wishlist_Item(context: context)
        wishlistItem.productId = Int64(productId)
        wishlistItem.userEmail = userEmail
        
        saveContext()
        print("✅ Added to wishlist: \(productId) for \(userEmail)")
    }
    
    // Remove product from wishlist
    func removeFromWishlist(productId: Int, userEmail: String) {
        let fetchRequest: NSFetchRequest<Wishlist_Item> = Wishlist_Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@ AND productId == %d", userEmail, productId)
        
        do {
            let results = try context.fetch(fetchRequest)
            for obj in results {
                context.delete(obj)
            }
            saveContext()
            print("✅ Removed from wishlist: \(productId) for \(userEmail)")
        } catch {
            print("❌ Error removing from wishlist: \(error)")
        }
    }
    
    // Fetch wishlist product IDs for a user
    func fetchWishlistProductIds(userEmail: String) -> [Int] {
        let fetchRequest: NSFetchRequest<Wishlist_Item> = Wishlist_Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        
        do {
            return try context.fetch(fetchRequest).map { Int($0.productId) }
        } catch {
            print("❌ Failed to fetch wishlist IDs: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - CART FUNCTIONS
    
    // Add product to cart (increase qty if already exists)
    func addCartItem(product: ProductModel, quantity: Int, userEmail: String) {
        let context = context
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", userEmail)
        
        do {
            guard let user = try context.fetch(request).first else { return }
            
            if let existingItem = user.cartItems?.allObjects.first(where: {
                ($0 as? CartItem)?.id ?? 0 == product.intId
            }) as? CartItem {
                existingItem.quantity += Int64(quantity)
            } else {
                let cartItem = CartItem(context: context)
                cartItem.id = Int64(product.intId)
                cartItem.name = product.strProductName
                cartItem.price = product.doubleProductPrice
                cartItem.image = product.strProductImage
                cartItem.quantity = Int64(quantity)
                cartItem.category = product.objProductCategory.rawValue
                cartItem.type = product.objProductType.rawValue
                cartItem.user = user
            }
            
            try context.save()
        } catch {
            print("❌ Failed to add to cart: \(error.localizedDescription)")
        }
    }
    
    // Fetch cart items for a user
    func fetchCart(for userEmail: String) -> [CartItem] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user.email == %@", userEmail)
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch cart: \(error.localizedDescription)")
            return []
        }
    }
    
    // Delete a single cart item
    func deleteCartItem(productId: Int, userEmail: String) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user.email == %@ AND id == %d", userEmail, productId)
        
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("❌ Failed to delete cart item: \(error.localizedDescription)")
        }
    }
    
    // Clear all cart items for a user
    func clearCart(for userEmail: String) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user.email == %@", userEmail)
        
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("❌ Failed to clear cart: \(error.localizedDescription)")
        }
    }
    
}
