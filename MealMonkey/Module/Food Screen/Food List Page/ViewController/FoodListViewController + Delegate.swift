//
//  FoodListViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import Foundation
import UIKit
import CoreData

// MARK: - TableView DataSource & Delegate
extension FoodScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // We always show 4 collection views (Category, Popular, Most Popular, Recent)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FoodListTableViewCell",
            for: indexPath
        ) as? FoodListTableViewCell else {
            fatalError("❌ Could not dequeue FoodListTableViewCell")
        }
        
        cell.delegate = self
        
        // Adjust collection view scroll direction
        if let layout = cell.collViewFood.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = (indexPath.row == 0 || indexPath.row == 2) ? .horizontal : .vertical
            cell.collViewFood.collectionViewLayout.invalidateLayout()
        }
        
        // MARK: - Configure Each Section
        switch indexPath.row {
        case 0: // 🔹 Categories (fixed height)
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.categories = filteredCategories
            cell.lblCollViewHeading.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.collViewHeight.constant = 113
            
        case 1: // 🔹 Popular (dynamic height)
            cell.collectionType = .popular
            cell.lblCollViewHeading.text = "Popular"
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            
            if selectedCategory == .All {
                cell.products = filteredProducts.filter {
                    $0.floatProductRating >= 4.0 && $0.floatProductRating <= 4.5
                }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.0 &&
                    $0.floatProductRating <= 4.5 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            
        case 2: // 🔹 Most Popular (fixed height)
            cell.collectionType = .mostPopular
            cell.lblCollViewHeading.text = "Most Popular"
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collViewHeight.constant = 185
            
            if selectedCategory == .All {
                cell.products = filteredProducts.filter {
                    $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0
                }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.5 &&
                    $0.floatProductRating <= 5.0 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            
        case 3: // 🔹 Recent Items (dynamic height)
            cell.collectionType = .RecentItems
            cell.lblCollViewHeading.text = "Recent Items"
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.products = recentItems
            
        default:
            break
        }
        
        // Reload collection view inside cell
        cell.collViewFood.reloadData()
        
        // ✅ Ensure height updates correctly after reload (only dynamic sections)
        if indexPath.row == 1 || indexPath.row == 3 {
            DispatchQueue.main.async {
                cell.updateCollectionHeight()
                self.tblRecentItems.beginUpdates()
                self.tblRecentItems.endUpdates()
            }
        }
        
        return cell
    }
    
    // MARK: - Save Order for Current User (Core Data)
    func saveOrderForCurrentUser(products: [ProductModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Get current logged-in user email
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else {
            print("⚠️ No current user found in UserDefaults")
            return
        }
        
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "email == %@", currentUserEmail)
        
        do {
            let users = try context.fetch(userFetch)
            let user: User
            
            if let existingUser = users.first {
                user = existingUser
            } else {
                // Create a new user if not found
                user = User(context: context)
                user.id = UUID()
                user.email = currentUserEmail
                user.name = UserDefaults.standard.string(forKey: "userName")
            }
            
            // Create a new Order
            let order = Order(context: context)
            order.order_no = Int32((user.orders?.count ?? 0) + 1)
            order.total_price = products.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
            order.users = user
            
            // Add products to the order
            for prod in products {
                let foodItemFetch: NSFetchRequest<Food_Items> = Food_Items.fetchRequest()
                foodItemFetch.predicate = NSPredicate(format: "name == %@", prod.strProductName)
                let fetchedFoodItems = try context.fetch(foodItemFetch)
                
                let foodItem: Food_Items
                if let existingFood = fetchedFoodItems.first {
                    foodItem = existingFood
                } else {
                    // Create new food item if it doesn't exist
                    foodItem = Food_Items(context: context)
                    foodItem.id = Int64(prod.intId)
                    foodItem.name = prod.strProductName
                    foodItem.price = prod.doubleProductPrice
                    foodItem.imageName = prod.strProductImage
                    foodItem.category = prod.objProductCategory.rawValue
                }
                
                order.addToProducts(foodItem)
            }
            
            // Link order with user
            user.addToOrders(order)
            
            try context.save()
            print("✅ Order saved for user: \(currentUserEmail)")
            
        } catch {
            print("❌ Failed to save order: \(error.localizedDescription)")
        }
    }
}
