//
//  OffersViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class OffersViewController: UIViewController {
    
    // Outlet for "Check Offers" button
    @IBOutlet weak var lblfindDiscount: UILabel! // Find discounts, Offers special meals and more!
    @IBOutlet weak var btnCheckOffers: UIButton!
    // Outlet for table view that displays list of offers
    @IBOutlet weak var tblOffers: UITableView!
    
    // Array holding all available offers (fetched from Offer class)
    let arrOffers = Offer.getAllOffers()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.updateCartBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Round the corners of the "Check Offers" button
        btnCheckOffers.layer.cornerRadius = Main.UI.cornerRadiusSmall
        
        // Register custom table view cell for reuse
        tblOffers.register(UINib(nibName: Main.cells.offersCell, bundle: nil),
                           forCellReuseIdentifier: Main.cells.offersCell)
        
        setLeftAlignedTitle(Main.OfferLabels.navTitle)
        setCartButton(target: self, action: #selector(cartBtnTapped))
        lblfindDiscount.text = Main.OfferLabels.findDiscounts
        btnCheckOffers.setTitle(Main.OfferLabels.btnCheckOffers, for: .normal)
    }
    
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // Action for "Check Offers" button tap
    @IBAction func btnCheckOffersAction(_ sender: Any) {
        // Currently empty - can be used to navigate to another screen or show more offers
    }
}
