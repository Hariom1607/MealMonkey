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
    @IBOutlet var txtFirstName: [UITextField]!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var btnTrackOrder: UIButton!
    @IBOutlet weak var btnCloseAddCardView: UIButton!
    @IBOutlet weak var btnAddNewCardPopUp: UIButton!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet var txtExpiryMonth: [UITextField]!
    
    var arrCards: [String] = ["card1", "card2", "card3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let allTextFields = [txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!]
        
        let allViews = [btnSendOrder!, btnTrackOrder!, btnAddNewCardPopUp!]
        
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
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
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
    
    
    @IBAction func btnAddNewCardPopUpAction(_ sender: Any) {
        addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        addCardView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.addCardView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewTransparent.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: "Transparentcolor")
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
        
    }
    
    @IBAction func btnTrackMyOrderAction(_ sender: Any) {
    }
    
}
