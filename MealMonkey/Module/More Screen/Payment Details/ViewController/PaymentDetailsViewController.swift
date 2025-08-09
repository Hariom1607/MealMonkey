//
//  PaymentDetailsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backBtnTapped))
        setCartButton(target: self, action: #selector(btnCartPressed))
        
        let allviews = [btnAddNewCard!, txtLastName!, txtFirstName!, txtCardNumber!, txtExpiryYear!, txtExpiryMonth!, txtSecurityCode!, btnAddCardView!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        setTextFieldPadding(allviews)
        
        tblCardDetails.register(UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailsTableViewCell")
        
        viewAddCard.isHidden = true
        viewBack.isHidden = true
        
        ScrollView.backgroundColor = .clear
        
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddNewCardAction(_ sender: Any) {
        viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        viewAddCard.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            self.viewBack.isHidden = false
        }
        self.navigationController?.navigationBar.backgroundColor  = UIColor(named: "Transparentcolor")
    }
    
    @IBAction func btnAddCardViewAction(_ sender: Any) {
    }
    
    @IBAction func btnRemoveAddCardView(_ sender: Any) {
        self.navigationController?.navigationBar.backgroundColor  = UIColor.white
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewBack.isHidden = true
        }) { _ in
            self.viewAddCard.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    @objc func btnCartPressed() {
        
    }
    
}
