//
//  MoreViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {
    
    // Array of items for the "More" section (from More model)
    let arrTitles: [More] = More.items
    
    // Outlet for the More screen's table view
    @IBOutlet weak var tblMore: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateCartBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell
        tblMore.register(UINib(nibName: Main.cells.morePageCell, bundle: nil),
                         forCellReuseIdentifier: Main.cells.morePageCell)
        
        // Set navigation title
        setLeftAlignedTitle(Main.Labels.more)

        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    // MARK: - Cart Button Action
    @objc func cartButtonTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
