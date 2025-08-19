//
//  OffersViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class OffersViewController: UIViewController {

    // Outlet for "Check Offers" button
    @IBOutlet weak var btnCheckOffers: UIButton!
    // Outlet for table view that displays list of offers
    @IBOutlet weak var tblOffers: UITableView!
    
    // Array holding all available offers (fetched from Offer class)
    let arrOffers = Offer.getAllOffers()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Round the corners of the "Check Offers" button
        btnCheckOffers.layer.cornerRadius = 7.42
        
        // Register custom table view cell for reuse
        tblOffers.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
    }
    
    // Action for "Check Offers" button tap
    @IBAction func btnCheckOffersAction(_ sender: Any) {
        // Currently empty - can be used to navigate to another screen or show more offers
    }
    
}
