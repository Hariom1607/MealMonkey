//
//  CheckoutViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnCloseThankyouView: UIButton!
    @IBOutlet weak var sendOrderView: UIView!
    @IBOutlet weak var viewTransparent: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var addCardView: UIView!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var btnLocationChange: UIButton!
    @IBOutlet weak var tblPaymentDetails: UITableView!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var btnTrackOrder: UIButton!
    @IBOutlet weak var btnCloseAddCardView: UIButton!
    @IBOutlet weak var btnAddNewCardPopUp: UIButton!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    
    var arrCards: [String] = []
    var selectedPaymentIndex: Int = 0 // Default COD is selected
    var orderProducts: [ProductModel] = []
    let deliveryCost: Double = 5.0         // Default delivery cost
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Always update current location label
        if let address = UserDefaults.standard.string(forKey: "currentAddress") {
            lblCurrentLocation.text = address
        } else {
            lblCurrentLocation.text = "Select your location"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrCards = getSavedCards()
        
        let allViews = [btnSendOrder!, btnTrackOrder!, btnAddNewCardPopUp!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!]
        
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        setTextFieldPadding(allViews)
        updateOrderSummary()
        
        sendOrderView.isHidden = true
        addCardView.isHidden = true
        viewTransparent.isHidden = true
        
        setLeftAlignedTitleWithBack("Checkout", target: self, action: #selector(backBtnTapped))
        
        tblPaymentDetails.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        tblPaymentDetails.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblPaymentDetails.register(UINib(nibName: "UpiTableViewCell", bundle: nil), forCellReuseIdentifier: "UpiTableViewCell")
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChangeLocationAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
        if let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            
            // Pass closure to update label immediately
            mapVC.onLocationSelected = { [weak self] address in
                self?.lblCurrentLocation.text = address
            }
            
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    
    @IBAction func btnAddNewCardPopUpAction(_ sender: Any) {
        guard let cardNumber = txtCardNumber.text, cardNumber.count == 16, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardNumber)) else {
            showAlert(message: "Card number must be exactly 16 digits.")
            return
        }
        
        guard let expiryMonth = txtExpiryMonth.text, expiryMonth.count == 2, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: expiryMonth)) else {
            showAlert(message: "Expiry month must be 2 digits.")
            return
        }
        
        guard let expiryYear = txtExpiryYear.text, expiryYear.count == 2, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: expiryYear)) else {
            showAlert(message: "Expiry year must be 2 digits.")
            return
        }
        
        // Add card to array
        arrCards.append(cardNumber)
        
        // Save to UserDefaults
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
        
        // Reload table to show new card
        tblPaymentDetails.reloadData()
        
        // Close popup
        btnCloseCardViewAction(sender)
        
        // Clear fields
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
    }
    
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
    
    @IBAction func btnBackToHomeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "MenuTabViewController") as? MenuTabViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
        
    }
    
    @IBAction func btnTrackMyOrderAction(_ sender: Any) {
    }
    
}
