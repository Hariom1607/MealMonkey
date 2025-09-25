//
//  MoreViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {
    
    // Array of items for the "More" section (from More model)
    var arrTitles: [More] = []
    
    // Outlet for the More screen's table view
    @IBOutlet weak var tblMore: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateCartBadge()
        arrTitles = More.items
        if arrTitles.count > 6 {
            arrTitles[6] = More(imgSection: Main.images.language,
                                title: Main.Labels.moreLanguages)
        }
        tblMore.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell
        tblMore.register(UINib(nibName: Main.cells.morePageCell, bundle: nil),
                         forCellReuseIdentifier: Main.cells.morePageCell)
        
        // Set navigation title
        setLeftAlignedTitle(Main.Labels.moreNavTitle)
        
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        // Update view background
        view.backgroundColor = theme.backgroundColor
        
        // Update navigation bar colors
        navigationController?.navigationBar.barTintColor = theme.mainColor
//        navigationController?.navigationBar.tintColor = theme.accentColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.primaryFontColor
        ]
        
        // Update table view background
        tblMore.backgroundColor = theme.backgroundColor
        
        // Reload table to apply text color changes
        tblMore.reloadData()
    }

    // MARK: - Cart Button Action
    @objc func cartButtonTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }

}
