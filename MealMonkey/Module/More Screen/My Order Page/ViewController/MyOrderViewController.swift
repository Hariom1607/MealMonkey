//
//  MyOrderViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

// MARK: - ViewController for displaying and managing user's current order
class MyOrderViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTotal: UILabel!          // Label for showing final total amount
    @IBOutlet weak var lblDeliveryCost: UILabel!   // Label for showing delivery charges
    @IBOutlet weak var lblSubTotal: UILabel!       // Label for showing subtotal (without delivery cost)
    @IBOutlet weak var btnAddNotes: UIButton!      // Button for adding special notes (optional feature)
    @IBOutlet weak var btnCheckout: UIButton!      // Button to proceed to checkout
    @IBOutlet weak var tblMyOrders: UITableView!   // TableView listing all ordered products
    
    // MARK: - Properties
    var orderProducts: [ProductModel] = []         // Array holding ordered products
    let deliveryCost: Double = 5.0                 // Fixed delivery charge (can be dynamic later)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar with title and back button
        setLeftAlignedTitleWithBack(Main.backBtnTitle.myOrder, target: self, action: #selector(backBtnTapped))
        
        // Round checkout button for better UI
        btnCheckout.layer.cornerRadius = 28
        
        // Register custom cell for table view
        tblMyOrders.register(UINib(nibName: Main.cells.myOrderCell, bundle: nil), forCellReuseIdentifier: Main.cells.myOrderCell)
        
        // Calculate and display totals initially
        calculateTotals()
    }
    
    // MARK: - Helper Methods
    
    /// Calculates subtotal, adds delivery cost, and updates labels
    func calculateTotals() {
        let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + deliveryCost))"
    }
    
    // MARK: - Actions
    
    /// Handles back navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Navigates to checkout screen with current order details
    @IBAction func btnCheckOutAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.checkout) as? CheckoutViewController {
            mlvc.orderProducts = self.orderProducts // Pass order details to checkout screen
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}
