//
//  PaymentDetailsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

// MARK: - PaymentDetailsViewController
/// Manages user's saved payment cards, adding new cards, and deleting cards
class PaymentDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!              // Label shown when no cards are saved
    @IBOutlet weak var ScrollView: UIScrollView!       // Scroll view for content
    @IBOutlet weak var viewBack: UIView!               // Background overlay for add card popup
    @IBOutlet weak var viewMain: UIView!               // Main container view
    @IBOutlet weak var viewScroll: UIView!             // Scrollable section with rounded top corners
    @IBOutlet weak var btnAddCardView: UIButton!       // "Add card" button inside the popup
    @IBOutlet weak var switchRemoveCard: UISwitch!     // Switch to remove card (currently unused)
    @IBOutlet weak var txtLastName: UITextField!       // Cardholder last name input
    @IBOutlet weak var txtFirstName: UITextField!      // Cardholder first name input
    @IBOutlet weak var txtSecurityCode: UITextField!   // CVV / Security code input
    @IBOutlet weak var txtExpiryYear: UITextField!     // Expiry year input
    @IBOutlet weak var txtExpiryMonth: UITextField!    // Expiry month input
    @IBOutlet weak var txtCardNumber: UITextField!     // Card number input
    @IBOutlet weak var btnCloseAddCardView: UIButton!  // Close button for popup
    @IBOutlet weak var viewAddCard: UIView!            // Popup view for adding a card
    @IBOutlet weak var btnAddNewCard: UIButton!        // Button to open "Add card" popup
    @IBOutlet weak var tblCardDetails: UITableView!    // TableView for saved cards
    
    // MARK: - Properties
    
    var savedCards: [Card] = []
    var currentUser: User?    // you should already have logged-in user reference
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar with back + cart button
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backBtnTapped))
        setCartButton(target: self, action: #selector(btnCartPressed))
        
        // Style all form inputs and buttons
        let allviews = [btnAddNewCard!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!, btnAddCardView!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding(allviews)
        
        // Register custom table view cell
        tblCardDetails.register(UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailsTableViewCell")
        
        // Hide popup + background overlay by default
        viewAddCard.isHidden = true
        viewBack.isHidden = true
        
        // Transparent background for scrollview
        ScrollView.backgroundColor = .clear
        
        // Style scrollable section (rounded + shadow)
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        loadCurrentUser()
        loadSavedCards()
    }
    
    private func loadCurrentUser() {
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
            print("📩 Logged in email from UserDefaults = \(email)")
            currentUser = CoreDataHelper.shared.fetchUser(byEmail: email)
            print("✅ Current user loaded: \(currentUser?.email ?? "nil")")
        } else {
            print("⚠️ No email found in UserDefaults")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewAddCard.isHidden = true
        loadSavedCards()
    }
    
    // MARK: - Helpers
    /// Show "No cards available" label if arrCards is empty
    func updateEmptyLabel() {
        let isEmpty = savedCards.isEmpty
        lblEmpty.isHidden = !isEmpty
        tblCardDetails.isHidden = isEmpty
    }
    
    /// Simple alert for invalid card input
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartPressed() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - Actions
    /// Opens the Add Card popup with animation
    @IBAction func btnAddNewCardAction(_ sender: Any) {
        CardHelper.clearCardInputs(in: self)
        
        lblEmpty.isHidden = true
        viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        viewAddCard.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewBack.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: "Transparentcolor")
        // 👇 This makes sure the cursor is always at the first field
        DispatchQueue.main.async {
            self.txtCardNumber.becomeFirstResponder()
        }
    }
    
    /// Validates input and saves a new card
    @IBAction func btnAddCardViewAction(_ sender: Any) {
        guard let firstName = txtFirstName.text, !firstName.isEmpty,
              let lastName = txtLastName.text, !lastName.isEmpty,
              let cardNumber = txtCardNumber.text, !cardNumber.isEmpty,
              let expMonth = Int16(txtExpiryMonth.text ?? ""),
              let expYear = Int16(txtExpiryYear.text ?? ""),
              let cvv = txtSecurityCode.text, !cvv.isEmpty else {
            showAlert(message: "Please fill all fields correctly.")
            return
        }
        
        // ✅ Central validation
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
            showAlert(message: "User not found")
            return
        }
        
        // ✅ Duplicate check
        if savedCards.contains(where: { $0.cardNumber == cardNumber }) {
            showAlert(message: "This card is already saved.")
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
        updateEmptyLabel()
        viewAddCard.isHidden = true
        viewBack.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func loadSavedCards() {
        if let user = currentUser {
            savedCards = CoreDataHelper.shared.fetchCards(for: user)
            tblCardDetails.reloadData()
            updateEmptyLabel()
        }
    }
    
    /// Closes the Add Card popup with animation
    @IBAction func btnRemoveAddCardView(_ sender: Any) {
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewBack.isHidden = true
        }) { _ in
            self.viewAddCard.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.updateEmptyLabel()
        }
    }
    
    /// Placeholder for remove card switch (not implemented yet)
    @IBAction func switchValueChanged(_ sender: Any) { }
}
