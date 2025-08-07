//
//  AboutUsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBOutlet weak var tblAboutUs: UITableView!
    
    var objPagetype: PageType = .AboutUs
    var arrCurrent:[AboutModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tblAboutUs.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        
        switch objPagetype {
            
        case .Notifications:
            setLeftAlignedTitleWithBack("Notifications", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartNotificationsTapped))
            arrCurrent = AboutModel.addNotificationData()
            
            
        case .Inbox:
            setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartInboxTapped))
            arrCurrent = AboutModel.addInboxData()
            
        case .AboutUs:
            setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartAboutUsTapped))
            arrCurrent = AboutModel.addAboutData()
            
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartPaymentTapped() {
        
    }
    
    @objc func cartMyOrdersTapped() {
        
    }
    
    @objc func cartNotificationsTapped() {
        
    }
    
    @objc func cartInboxTapped() {
        
    }
    
    @objc func cartAboutUsTapped() {
        
    }
}
