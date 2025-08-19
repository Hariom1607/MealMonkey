//
//  AboutUsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import UIKit

/// A versatile view controller that can show:
/// - About Us page
/// - Notifications page
/// - Inbox page
///
/// Uses a single table view with dynamic cell configurations.
class AboutUsViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Table view that displays data based on the selected page type
    @IBOutlet weak var tblAboutUs: UITableView!
    
    
    // MARK: - Properties
    
    /// Determines which type of screen is currently being displayed
    var objPagetype: PageType = .AboutUs
    
    /// Holds the data to be displayed in the tableView (changes based on page type)
    var arrCurrent: [AboutModel] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register reusable cell
        tblAboutUs.register(
            UINib(nibName: "AboutUsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AboutUsTableViewCell"
        )
        
        // Configure UI and load appropriate data based on page type
        switch objPagetype {
            
        case .Notifications:
            // Navigation setup
            setLeftAlignedTitleWithBack("Notifications", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartNotificationsTapped))
            
            // Load data
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
    
    
    // MARK: - Navigation Button Actions
    
    /// Handles back button action → navigates to previous screen
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Placeholder for cart action on **Payment screen**
    @objc func cartPaymentTapped() {
        // TODO: Implement Payment cart action
    }
    
    /// Placeholder for cart action on **My Orders screen**
    @objc func cartMyOrdersTapped() {
        // TODO: Implement My Orders cart action
    }
    
    /// Cart button action for **Notifications page**
    @objc func cartNotificationsTapped() {
        // TODO: Implement Notifications cart action
    }
    
    /// Cart button action for **Inbox page**
    @objc func cartInboxTapped() {
        // TODO: Implement Inbox cart action
    }
    
    /// Cart button action for **About Us page**
    @objc func cartAboutUsTapped() {
        // TODO: Implement About Us cart action
    }
}
