//
//  MenuViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblMenu: UITableView!
    
    var menuItems: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(cartBtnTapped))
            
        txtSearch.setPadding(left: 34)
        let allviews = [txtSearch!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)

        // Do any additional setup after loading the view.
        
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        menuItems = Menu.populateMenu()
        
    }
    
    @objc func cartBtnTapped() {
        
    }
}
