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
    var filteredMenuItems: [Menu] = []   // For search
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateCartBadge()
    }
    
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
        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        menuItems = Menu.populateMenu()
        filteredMenuItems = menuItems
        updateEmptyState()
    }
    
    /// Opens CartViewController when cart button is tapped
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // ✅ Search Filtering
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredMenuItems = menuItems
        } else {
            filteredMenuItems = menuItems.filter { menu in
                return menu.strName.lowercased().contains(searchText)
            }
        }
        
        tblMenu.reloadData()
        updateEmptyState()
    }
}
