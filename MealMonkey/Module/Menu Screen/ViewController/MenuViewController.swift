//
//  MenuViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

/// Displays the list of menu categories (Food, Beverages, Desserts)
class MenuViewController: UIViewController {
    
    /// Search bar for filtering menu items
    @IBOutlet weak var txtSearch: UITextField!
    
    /// Table view that shows menu categories
    @IBOutlet weak var tblMenu: UITableView!
    
    /// Data source for the table (Food, Beverages, Desserts)
    var menuItems: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ Show navigation bar for this screen
        self.navigationController?.isNavigationBarHidden = false
        
        // ✅ Set title ("Menu") and add cart button to nav bar
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(cartBtnTapped))
        
        // ✅ Style search field with padding and rounded corners
        txtSearch.setPadding(left: 34, right: 34)
        let allviews = [txtSearch!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // ✅ Register custom table view cell
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "MenuTableViewCell")
        
        // ✅ Load static menu data
        menuItems = Menu.populateMenu()
    }
    
    /// Opens CartViewController when cart button is tapped
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
