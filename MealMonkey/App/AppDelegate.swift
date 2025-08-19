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
    
    var arrCart: [ProductModel] = []
    var arrOrders: [[ProductModel]] = []
    var allProducts: [ProductModel] = [] // Store API products here
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Food Model")
        
        if let storeDescription = container.persistentStoreDescriptions.first {
            storeDescription.shouldMigrateStoreAutomatically = true
            storeDescription.shouldInferMappingModelAutomatically = true
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // 🚨 Reset the store if migration fails
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
                print("✅ Core Data store loaded at: \(storeDescription.url?.absoluteString ?? "unknown")")
            }
        }
        
        return container
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //        saveWishlist(arrWishlist, forUser: "")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //        saveWishlist(arrWishlist, forUser: "") // Extra safety
        saveContext()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}

