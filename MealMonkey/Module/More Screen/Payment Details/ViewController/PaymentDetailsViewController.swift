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
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var btnAddCardView: UIButton!
    @IBOutlet weak var switchRemoveCard: UISwitch!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnCloseAddCardView: UIButton!
    @IBOutlet weak var viewAddCard: UIView!
    @IBOutlet weak var btnAddNewCard: UIButton!
    @IBOutlet weak var tblCardDetails: UITableView!
    
    // MARK: - Properties
    var savedCards: [Card] = []
    var currentUser: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar with back + cart button
        setLeftAlignedTitleWithBack(Main.Labels.paymentDetails, target: self, action: #selector(backBtnTapped))
        setCartButton(target: self, action: #selector(btnCartPressed))
        
        let allviews = [btnAddNewCard!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!, btnAddCardView!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding(allviews)
        
        tblCardDetails.register(UINib(nibName: Main.cells.paymentDetailCell, bundle: nil), forCellReuseIdentifier: Main.cells.paymentDetailCell)
        
        viewAddCard.isHidden = true
        viewBack.isHidden = true
        
        ScrollView.backgroundColor = .clear
        
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
        if let email = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) {
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
    func updateEmptyState() {
        if savedCards.isEmpty {
            tblCardDetails.setEmptyView(
                animationName: Main.Animations.paymentFailed,
                message: Main.Messages.noSavedCards
            )
        } else {
            tblCardDetails.restore()
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: Main.Alerts.invalidInput, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Main.AlertTitle.okBtn, style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartPressed() {
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - Actions
    @IBAction func btnAddNewCardAction(_ sender: Any) {
        CardHelper.clearCardInputs(in: self)
        
        viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        viewAddCard.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewBack.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: Main.Colors.transparent)
        DispatchQueue.main.async {
            self.txtCardNumber.becomeFirstResponder()
        }
    }
    
    @IBAction func btnAddCardViewAction(_ sender: Any) {
        guard let firstName = txtFirstName.text, !firstName.isEmpty,
              let lastName = txtLastName.text, !lastName.isEmpty,
              let cardNumber = txtCardNumber.text, !cardNumber.isEmpty,
              let expMonth = Int16(txtExpiryMonth.text ?? ""),
              let expYear = Int16(txtExpiryYear.text ?? ""),
              let cvv = txtSecurityCode.text, !cvv.isEmpty else {
            showAlert(message: Main.ValidationMessages.invalidCardInput)
            return
        }
        
        if let error = CardHelper.validateCardInputs(
            cardNumber: cardNumber,
            expMonth: expMonth,
            expYear: expYear,
            cvv: cvv,
            firstName: firstName,
            lastName: lastName
        ) {
            showAlert(message: error)
            return
        }
        
        guard let user = currentUser else {
            showAlert(message: Main.Messages.userNotFound)
            return
        }
        
        if savedCards.contains(where: { $0.cardNumber == cardNumber }) {
            showAlert(message: Main.Messages.cardAlreadySaved)
            return
        }
        
        CoreDataHelper.shared.saveCard(
            for: user,
            number: cardNumber,
            expiryMonth: expMonth,
            expiryYear: expYear,
            firstName: firstName,
            lastName: lastName
        )
        
        loadSavedCards()
        updateEmptyState()
        viewAddCard.isHidden = true
        viewBack.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func loadSavedCards() {
        if let user = currentUser {
            savedCards = CoreDataHelper.shared.fetchCards(for: user)
            tblCardDetails.reloadData()
            updateEmptyState()
        }
    }
    
    @IBAction func btnRemoveAddCardView(_ sender: Any) {
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewBack.isHidden = true
        }) { _ in
            self.viewAddCard.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.updateEmptyState()
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) { }
}
