//
//  OffersViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var btnCheckOffers: UIButton!
    @IBOutlet weak var tblOffers: UITableView!
    
    let arrOffers = offer.getAllOffers()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCheckOffers.layer.cornerRadius = 7.42
        
        tblOffers.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
    }
    
    @IBAction func btnCheckOffersAction(_ sender: Any) {
    }
    
}
