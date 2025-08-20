//
//  CheckoutViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var viewAddCardTopCorner: UIView!
    @IBOutlet weak var btnAddCard: UIButton!                 // Button to open Add Card popup
    @IBOutlet weak var viewPlaceOrderTopCorner: UIView!
    @IBOutlet weak var btnCloseThankyouView: UIButton!       // Button to close Thank You view
    @IBOutlet weak var sendOrderView: UIView!                // View displayed after sending order
    @IBOutlet weak var viewTransparent: UIView!              // Transparent overlay for popups
    @IBOutlet weak var viewMain: UIView!                     // Main container view
    @IBOutlet weak var addCardView: UIView!                  // View for adding new card
    @IBOutlet weak var btnSendOrder: UIButton!               // Button to confirm/send order
    @IBOutlet weak var lblTotal: UILabel!                    // Label showing total price
    @IBOutlet weak var lblDiscount: UILabel!                 // Label showing discount
    @IBOutlet weak var lblDeliveryCost: UILabel!             // Label showing delivery cost
    @IBOutlet weak var lblSubTotal: UILabel!                 // Label showing subtotal
    @IBOutlet weak var lblCurrentLocation: UILabel!          // Label showing current delivery location
    @IBOutlet weak var btnLocationChange: UIButton!          // Button to change location
    @IBOutlet weak var tblPaymentDetails: UITableView!       // Table showing available payment options
    @IBOutlet weak var txtLastName: UITextField!             // TextField for cardholder last name
    @IBOutlet weak var txtCardNumber: UITextField!           // TextField for card number input
    @IBOutlet weak var btnBackToHome: UIButton!              // Button to navigate back to home
    @IBOutlet weak var btnTrackOrder: UIButton!              // Button to track placed order
    @IBOutlet weak var btnCloseAddCardView: UIButton!        // Button to close Add Card popup
    @IBOutlet weak var btnAddNewCardPopUp: UIButton!         // Button to add new card (inside popup)
    @IBOutlet weak var txtSecurityCode: UITextField!         // TextField for card CVV
    @IBOutlet weak var txtExpiryYear: UITextField!           // TextField for expiry year
    @IBOutlet weak var txtFirstName: UITextField!            // TextField for cardholder first name
    @IBOutlet weak var txtExpiryMonth: UITextField!          // TextField for expiry month
    
    // MARK: - Properties
    var arrCards: [String] = []              // Stores saved card numbers
    var selectedPaymentIndex: Int = 0        // Default: Cash on Delivery is selected
    var orderProducts: [ProductModel] = []   // List of products in current order
    let deliveryCost: Double = 5.0           // Fixed delivery cost
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Always update delivery location label before view appears
        if let address = UserDefaults.standard.string(forKey: "currentAddress") {
            lblCurrentLocation.text = address
        } else {
            lblCurrentLocation.text = "Select your location"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved cards from UserDefaults
        arrCards = getSavedCards()
        
        // Style all input fields and buttons
        let allViews = [btnSendOrder!, btnTrackOrder!, btnAddNewCardPopUp!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding(allViews)
        
        roundCorners(of: [viewAddCardTopCorner, viewPlaceOrderTopCorner])
        
        // Update subtotal, delivery, discount, and total labels
        updateOrderSummary()
        
        // Initially hide all popup views
        sendOrderView.isHidden = true
        addCardView.isHidden = true
        viewTransparent.isHidden = true
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack("Checkout", target: self, action: #selector(backBtnTapped))
        
        // Register custom cells for payment options
        tblPaymentDetails.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        tblPaymentDetails.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblPaymentDetails.register(UINib(nibName: "UpiTableViewCell", bundle: nil), forCellReuseIdentifier: "UpiTableViewCell")
    }
    
    // MARK: - Navigation
    /// Back button action → pops current VC
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Location
    /// Opens Map screen to change delivery location
    @IBAction func btnChangeLocationAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
        if let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            
            // Pass closure to update delivery address label when location is selected
            mapVC.onLocationSelected = { [weak self] address in
                self?.lblCurrentLocation.text = address
            }
            
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    // MARK: - Add New Card
    /// Add new card popup → validates and saves card
    @IBAction func btnAddNewCardPopUpAction(_ sender: Any) {
        // Validate card number (must be 16 digits)
        guard let cardNumber = txtCardNumber.text, cardNumber.count == 16, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardNumber)) else {
            showAlert(message: "Card number must be exactly 16 digits.")
            return
        }
        
        // Validate expiry month (must be 2 digits)
        guard let expiryMonth = txtExpiryMonth.text, expiryMonth.count == 2, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: expiryMonth)) else {
            showAlert(message: "Expiry month must be 2 digits.")
            return
        }
        
        // Validate expiry year (must be 2 digits)
        guard let expiryYear = txtExpiryYear.text, expiryYear.count == 2, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: expiryYear)) else {
            showAlert(message: "Expiry year must be 2 digits.")
            return
        }
        
        // Add valid card to array
        arrCards.append(cardNumber)
        
        // Save updated array to UserDefaults
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
        
        // Reload payment options list
        tblPaymentDetails.reloadData()
        
        // Close Add Card popup
        btnCloseCardViewAction(sender)
        
        // Clear card fields
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
    }
    
    /// Close Add Card popup
    @IBAction func btnCloseCardViewAction(_ sender: Any) {
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
        UIView.animate(withDuration: 0.3, animations: {
            self.addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewTransparent.isHidden = true
        }) { _ in
            self.addCardView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    // MARK: - Order Actions
    /// Show Thank You screen after placing order
    @IBAction func btnSendOrderAction(_ sender: Any) {
        sendOrderView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        sendOrderView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.sendOrderView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewTransparent.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: "Transparentcolor")
    }
    
    /// Close Thank You popup
    @IBAction func btnCloseThankyouAction(_ sender: Any) {
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
        UIView.animate(withDuration: 0.3, animations: {
            self.sendOrderView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewTransparent.isHidden = true
        }) { _ in
            self.sendOrderView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    /// Open Add Card popup (main screen button)
    @IBAction func btnAddCardMainAction(_ sender: Any) {
        addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        addCardView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.addCardView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewTransparent.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: "Transparentcolor")
    }
    
    // MARK: - Navigation after Order
    /// Navigate back to Home tab after order placed
    @IBAction func btnBackToHomeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MenuTabViewController") as? UITabBarController {
            
            tabBarController.selectedIndex = 2   // Select Home tab
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    /// Track order (currently empty action)
    @IBAction func btnTrackMyOrderAction(_ sender: Any) {
    }
}
