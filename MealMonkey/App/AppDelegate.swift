//
//  AppDelegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Global arrays for cart, orders, and all available products
    var arrCart: [ProductModel] = []
    var arrOrders: [[ProductModel]] = []
    var allProducts: [ProductModel] = [] // Store API products here
    
    // MARK: - Core Data Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        // Initialize Core Data stack with "Food Model"
        let container = NSPersistentContainer(name: Main.model.food)
        
        // Enable automatic lightweight migrations
        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.shouldMigrateStoreAutomatically = true
            storeDescription.shouldInferMappingModelAutomatically = true
        }
        
        // Load persistent store (database)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // 🚨 If migration fails, reset and recreate the store
                if let url = storeDescription.url {
                    try? container.persistentStoreCoordinator.destroyPersistentStore(
                        at: url,
                        ofType: NSSQLiteStoreType,
                        options: nil
                    )
                    try? container.persistentStoreCoordinator.addPersistentStore(
                        ofType: NSSQLiteStoreType,
                        configurationName: nil,
                        at: url,
                        options: [
                            NSMigratePersistentStoresAutomaticallyOption: true,
                            NSInferMappingModelAutomaticallyOption: true
                        ]
                    )
                    print("⚠️ Old Core Data store reset due to migration error.")
                } else {
                    fatalError("❌ Unresolved Core Data error \(error), \(error.userInfo)")
                }
            } else {
                // ✅ Store loaded successfully
                print("✅ Core Data store loaded at: \(storeDescription.url?.absoluteString ?? "unknown")")
            }
        }
        
        return container
    }()
    
    // MARK: - App Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Fetch products from API on app launch
        ProductAPIHelper.shared.fetchProducts { products in
            guard let products = products else { return }
            DispatchQueue.main.async {
                self.allProducts = products
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Return the default scene configuration.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when user discards a scene session.
        // Clean up any resources related to the discarded sessions.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Save wishlist or other user data here if needed
        // saveWishlist(arrWishlist, forUser: "")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Save wishlist before termination (extra safety)
        // saveWishlist(arrWishlist, forUser: "")
        saveContext()
    }
    
    // MARK: - Core Data Save Support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
