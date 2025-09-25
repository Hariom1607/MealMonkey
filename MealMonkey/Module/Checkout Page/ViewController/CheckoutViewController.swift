//
//  CheckoutViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblYoucanremovethiscardatanytime: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblAddCreditDebitCard: UILabel!
    @IBOutlet weak var lblDescriptionThankyoupage: UILabel! // Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order
    @IBOutlet weak var lblForYouOrder: UILabel!
    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblSubTotalTitle: UILabel!
    @IBOutlet weak var viewAddCardTopCorner: UIView!
    @IBOutlet weak var lblDeliveryCostTitle: UILabel!
    @IBOutlet weak var lblDiscountTitle: UILabel!
    @IBOutlet weak var lblTotalTitle: UILabel!
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
    var selectedPaymentIndex: Int = 0        // Default: Cash on Delivery is selected
    var orderProducts: [ProductModel] = []   // List of products in current order
    let deliveryCost: Double = 5.0           // Fixed delivery cost
    var savedCards: [Card] = []
    var currentUser: User?
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh all localized texts
        setupLocalization()
        
        // Update delivery location
        if let address = UserDefaults.standard.string(forKey: Main.map.currentAddressKey) {
            lblCurrentLocation.text = address
        } else {
            lblCurrentLocation.text = Main.Labels.selectLocation
        }
        
        // Update subtotal, delivery cost, discount, and total
        updateOrderSummary()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style all input fields and buttons
        let allViews = [btnSendOrder!, btnTrackOrder!, btnAddNewCardPopUp!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding(allViews)
        
        // Add Card placeholders
        txtFirstName.placeholder = Main.Labels.firstName
        txtLastName.placeholder = Main.Labels.lastName
        txtCardNumber.placeholder = Main.Labels.cardNumber
        txtExpiryMonth.placeholder = Main.Labels.expiryMonth
        txtExpiryYear.placeholder = Main.Labels.expiryYear
        txtSecurityCode.placeholder = Main.Labels.securityCode
        
        // Apply localized labels
        lblYoucanremovethiscardatanytime.text = Main.Labels.checkoutYouCanRemoveCard
        lblExpiry.text = Main.Labels.checkoutExpiry
        lblAddCreditDebitCard.text = Main.Labels.checkoutAddCreditDebitCard
        lblDescriptionThankyoupage.text = Main.Labels.checkoutDescriptionThankYou
        lblForYouOrder.text = Main.Labels.checkoutForYourOrder
        lblThankYou.text = Main.Labels.checkoutThankYou
        
        // Reuse My Order labels
        lblDeliveryAddress.text = Main.Labels.myOrderAddress
        lblPaymentMethod.text = Main.Labels.myOrderMealMonkey // If you want a more suitable label, create a new key
        lblSubTotalTitle.text = Main.Labels.myOrderSubTotalTitle
        lblDeliveryCostTitle.text = Main.Labels.myOrderDeliveryCostTitle
        
        // Buttons
        btnAddCard.setTitle(Main.Labels.btnAddCard, for: .normal)
        btnSendOrder.setTitle(Main.Labels.btnSendOrder, for: .normal)
        btnCloseThankyouView.setTitle(Main.Labels.btnClose, for: .normal)
        btnBackToHome.setTitle(Main.Labels.btnBackToHome, for: .normal)
        btnTrackOrder.setTitle(Main.Labels.btnTrackOrder, for: .normal)
        btnAddNewCardPopUp.setTitle(Main.Labels.addNewCard, for: .normal)
        btnCloseAddCardView.setTitle(Main.images.close, for: .normal)
        btnLocationChange.setTitle(Main.Labels.btnLocationChange, for: .normal)

        roundCorners(of: [viewAddCardTopCorner, viewPlaceOrderTopCorner])
        
        // Update subtotal, delivery, discount, and total labels
        updateOrderSummary()
        
        // Initially hide all popup views
        sendOrderView.isHidden = true
        addCardView.isHidden = true
        viewTransparent.isHidden = true
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack(Main.BackBtnTitle.checkout, target: self, action: #selector(backBtnTapped))
        
        // Register custom cells for payment options
        tblPaymentDetails.register(UINib(nibName: Main.cells.checkoutCardCell, bundle: nil), forCellReuseIdentifier:Main.cells.checkoutCardCell)
        tblPaymentDetails.register(UINib(nibName: Main.cells.checkoutCashCell, bundle: nil), forCellReuseIdentifier: Main.cells.checkoutCashCell)
        tblPaymentDetails.register(UINib(nibName: Main.cells.checkoutUpiCell, bundle: nil), forCellReuseIdentifier: Main.cells.checkoutUpiCell)
        
        // Load saved cards from CoreData
        loadCurrentUser()
        loadSavedCards()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        applyTheme()

    }
    
    private func setupLocalization() {
        // Buttons
        btnSendOrder.setTitle(Main.Labels.btnSendOrder, for: .normal)
        btnTrackOrder.setTitle(Main.Labels.btnTrackOrder, for: .normal)
        btnAddCard.setTitle(Main.Labels.btnAddCard, for: .normal)
        btnBackToHome.setTitle(Main.Labels.btnBackToHome, for: .normal)
        btnCloseThankyouView.setTitle(Main.images.close, for: .normal)
        btnAddNewCardPopUp.setTitle(Main.Labels.addNewCard, for: .normal)
        btnCloseAddCardView.setTitle(Main.images.close, for: .normal)
        btnLocationChange.setTitle(Main.Labels.btnLocationChange, for: .normal)
        
        // Labels
        lblYoucanremovethiscardatanytime.text = Main.Labels.checkoutYouCanRemoveCard
        lblExpiry.text = Main.Labels.checkoutExpiry
        lblAddCreditDebitCard.text = Main.Labels.checkoutAddCreditDebitCard
        lblDescriptionThankyoupage.text = Main.Labels.checkoutDescriptionThankYou
        lblForYouOrder.text = Main.Labels.checkoutForYourOrder
        lblThankYou.text = Main.Labels.checkoutThankYou
        lblDeliveryAddress.text = Main.Labels.myOrderAddress
        lblPaymentMethod.text = Main.Labels.myOrderMealMonkey
        lblSubTotalTitle.text = Main.Labels.myOrderSubTotalTitle
        lblDeliveryCostTitle.text = Main.Labels.myOrderDeliveryCostTitle
        lblTotalTitle.text = Main.Labels.myOrderTotal
    }

    // MARK: - Load User + Cards
    private func loadCurrentUser() {
        if let email = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) {
            currentUser = CoreDataHelper.shared.fetchUser(byEmail: email)
        }
    }
    
    private func loadSavedCards() {
        if let user = currentUser {
            savedCards = CoreDataHelper.shared.fetchCards(for: user)
            tblPaymentDetails.reloadData()
        }
    }
    
    // MARK: - Navigation
    /// Back button action → pops current VC
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Location
    /// Opens Map screen to change delivery location
    @IBAction func btnChangeLocationAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.aboutUs, bundle: nil)
        if let mapVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.map) as? MapViewController {
            
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
        guard let firstName = txtFirstName.text, !firstName.isEmpty,
              let lastName = txtLastName.text, !lastName.isEmpty,
              let cardNumber = txtCardNumber.text, !cardNumber.isEmpty,
              let expMonth = Int16(txtExpiryMonth.text ?? ""),
              let expYear = Int16(txtExpiryYear.text ?? ""),
              let cvv = txtSecurityCode.text, !cvv.isEmpty else {
            showAlert(message: Main.Labels.invalidInput)
            return
        }
        
        // Validate using helper
        if let error = CardHelper.validateCardInputs(cardNumber: cardNumber,
                                                     expMonth: expMonth,
                                                     expYear: expYear,
                                                     cvv: cvv,
                                                     firstName: firstName,
                                                     lastName: lastName) {
            showAlert(message: error)
            return
        }
        
        guard let user = currentUser else {
            showAlert(message: Main.Labels.userNotFound)
            return
        }
        
        if savedCards.contains(where: { $0.cardNumber == cardNumber }) {
            showAlert(message: Main.Labels.cardAlreadySaved)
            return
        }
        
        // Save new card
        CoreDataHelper.shared.saveCard(
            for: user,
            number: cardNumber,
            expiryMonth: expMonth,
            expiryYear: expYear,
            firstName: firstName,
            lastName: lastName
        )
        
        loadSavedCards()
        btnCloseCardViewAction(sender)
        
        // Clear fields
        CardHelper.clearCardInputs(in: self)
    }
    
    /// Close Add Card popup
    @IBAction func btnCloseCardViewAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewTransparent.isHidden = true
        }) { _ in
            self.addCardView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
        
        // Enable back button and reset nav bar color
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
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
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: Main.Colors.transparent)
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
        
        // Disable back button and set nav bar color
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: Main.Colors.transparent)
    }
    
    // MARK: - Navigation after Order
    /// Navigate back to Home tab after order placed
    @IBAction func btnBackToHomeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.tabBar, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.viewController.menuTabBar) as? UITabBarController {
            
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
