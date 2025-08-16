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
        
        setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backBtnTapped))
        tblWishlist.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            wishlistItems = appDelegate.arrWishlist
        }
        tblWishlist.reloadData()
    }
    
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
