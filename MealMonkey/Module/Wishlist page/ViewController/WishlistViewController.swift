//
//  WishlistViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 15/08/25.
//

import UIKit

class WishlistViewController: UIViewController {
    
    var wishlistItems: [ProductModel] = []
    
    @IBOutlet weak var tblWishlist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        wishlistItems = loadWishlist(forUser: currentUserEmail)
        
        tblWishlist.delegate = self
        tblWishlist.dataSource = self
        tblWishlist.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
        tblWishlist.reloadData()
        
        setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backBtnTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        wishlistItems = loadWishlist(forUser: currentUserEmail)
        tblWishlist.reloadData()
    }
    
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
