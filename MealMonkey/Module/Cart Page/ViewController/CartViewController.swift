//
//  CartViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit
import CoreData
import Lottie

/// Handles cart display and order placement
class CartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCart: UITableView!
    
    private var emptyAnimationView: LottieAnimationView?
    private var emptyStackView: UIStackView?
    
    /// Cart items for current user
    var cartItems: [CartItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style button
        styleViews([btnPlaceOrder!], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add title + back button
        setLeftAlignedTitleWithBack(Main.backBtnTitle.cart, target: self, action: #selector(backBtnTapped))
        
        // Register custom cell
        tblCart.register(UINib(nibName: Main.cells.cartCell, bundle: nil), forCellReuseIdentifier: Main.cells.cartCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch cart items for logged-in user
        if let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) {
            cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        }
        updateEmptyState()
        tblCart.reloadData()
    }
    
    // MARK: - Helpers
    
    func updateEmptyState() {
        if cartItems.isEmpty {
            let emptyView = EmptyStateView(animationName: Main.EmptyState.cartAnimation,
                                           message: Main.EmptyState.cartEmptyMessage)
            
            tblCart.backgroundView = emptyView
            btnPlaceOrder.isHidden = true
        } else {
            tblCart.backgroundView = nil
            btnPlaceOrder.isHidden = false
        }
    }
    
    // MARK: - Actions
    
    /// Place order button tapped
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // Refresh cart
        cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        
        // Check empty cart
        if cartItems.isEmpty {
            let alert = UIAlertController(title: Main.Alerts.cartEmptyTitle,
                                          message: Main.Alerts.cartEmptyMessage,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Main.Labels.ok, style: .default))
            
            present(alert, animated: true)
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            // Fetch user
            guard let user = CoreDataHelper.shared.fetchUser(byEmail: currentUserEmail) else { return }
            
            // Create new order
            let order = Order(context: context)
            order.order_no = Int32((user.orders?.count ?? 0) + 1)
            order.total_price = cartItems.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
            order.users = user
            
            // Add cart items as Food_Items
            for item in cartItems {
                let foodItem = Food_Items(context: context)
                foodItem.id = Int64(item.id)
                foodItem.name = item.name
                foodItem.price = item.price
                foodItem.imageName = item.image
                foodItem.category = item.category ?? ""
                foodItem.quantity = Int16(item.quantity)
                foodItem.productDescription = item.type ?? ""
                
                order.addToProducts(foodItem)
            }
            
            // Save order
            user.addToOrders(order)
            try context.save()
            print("✅ Order saved for user: \(currentUserEmail)")
            
            // Clear cart
            CoreDataHelper.shared.clearCart(for: currentUserEmail)
            cartItems.removeAll()
            updateEmptyState()
            tblCart.reloadData()
            
            // Success alert
            let alert = UIAlertController(title: Main.Alerts.orderPlacedTitle,
                                          message: Main.Alerts.orderPlacedMessage,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: Main.Labels.ok, style: .default))
            present(alert, animated: true)
            
        } catch {
            print("❌ Failed to save order: \(error.localizedDescription)")
            let alert = UIAlertController(title: Main.Alerts.orderErrorTitle,
                                          message: Main.Alerts.orderErrorMessage,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: Main.Labels.ok, style: .default))
            present(alert, animated: true)
        }
    }
    
    /// Handle back button tap
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
