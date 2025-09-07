//
//  OrderListViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import UIKit

/// ViewController that displays the list of past orders placed by the user
class OrderListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tblOrderList: UITableView!  // Table view displaying orders
    
    // MARK: - Properties
    var orders: [[ProductModel]] = []              // 2D array: Each element represents an order containing multiple products
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar title with a back button
        setLeftAlignedTitleWithBack(Main.OrderListPage.navTitle, target: self, action: #selector(backBtnTapped))
        
        // Register custom table view cell for displaying order items
        tblOrderList.register(UINib(nibName: Main.cells.orderListCell, bundle: nil),
                              forCellReuseIdentifier: Main.cells.orderListCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Fetch orders from Core Data for the currently logged-in user
        let coreDataOrders = fetchOrdersForCurrentUser()
        
        // Convert Core Data `Food_Items` objects into `ProductModel`
        self.orders = coreDataOrders.map { order in
            let foodItems = (order.products?.allObjects as? [Food_Items])?.sorted(by: { $0.name ?? "" < $1.name ?? "" }) ?? []
            
            return foodItems.map { foodItem in
                ProductModel(
                    intId: 0,
                    strProductName: foodItem.name ?? "",
                    strProductDescription: foodItem.productDescription ?? "",
                    floatProductRating: 0.0,
                    doubleProductPrice: foodItem.price,
                    strProductImage: foodItem.imageName ?? "",
                    intProductQty: Int(foodItem.quantity),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: ProductCategory(rawValue: foodItem.category ?? "") ?? .Gujarati,
                    objProductType: ProductType.food
                )
            }
        }
        
        // Update "No Orders" label visibility
        updateEmptyLabel()
        // Reload table view with the latest data
        tblOrderList.reloadData()
    }
    
    // MARK: - UI Helpers
    /// Show/hide empty label based on whether orders exist
    func updateEmptyLabel() {
        if orders.isEmpty {
            tblOrderList.setEmptyView(animationName: Main.images.orderListAnimation,
                                      message: Main.OrderListPage.noOrdersMessage)
        } else {
            tblOrderList.restore()
        }
    }
    
    // MARK: - Actions
    /// Navigate back when the custom back button is tapped
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
