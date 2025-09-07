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
            UINib(nibName: Main.cells.aboutUsCell, bundle: nil),
            forCellReuseIdentifier: Main.cells.aboutUsCell
        )
        
        // Configure UI and load appropriate data based on page type
        switch objPagetype {
        case .Notifications:
            setLeftAlignedTitleWithBack(Main.Labels.notificationsNavTitle,
                                        target: self,
                                        action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartNotificationsTapped))
            arrCurrent = AboutModel.addNotificationData()
            
        case .Inbox:
            setLeftAlignedTitleWithBack(Main.Labels.inboxNavTitle,
                                        target: self,
                                        action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartInboxTapped))
            arrCurrent = AboutModel.addInboxData()
            
        case .AboutUs:
            setLeftAlignedTitleWithBack(Main.Labels.aboutUsNavTitle,
                                        target: self,
                                        action: #selector(backButtonTapped))
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
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }    }
    
    /// Placeholder for cart action on **My Orders screen**
    @objc func cartMyOrdersTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }    }
    
    /// Cart button action for **Notifications page**
    @objc func cartNotificationsTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }    }
    
    /// Cart button action for **Inbox page**
    @objc func cartInboxTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }    }
    
    /// Cart button action for **About Us page**
    @objc func cartAboutUsTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
