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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom table view cell
        tblMore.register(UINib(nibName: "MoreTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "MoreTableViewCell")
        
        // Set navigation title
        setLeftAlignedTitle("More")
        
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    // MARK: - Cart Button Action
    @objc func cartButtonTapped() {
        // Navigate to CartViewController when cart button is tapped
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
