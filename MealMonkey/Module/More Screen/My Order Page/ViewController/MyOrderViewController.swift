//
//  MyOrderViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit

class MyOrderViewController: UIViewController {
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var tblMyOrders: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("My Order", target: self, action: #selector(backBtnTapped))
        
        btnCheckout.layer.cornerRadius = 28
        tblMyOrders.register(UINib(nibName: "MyOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckOutAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AboutUsStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
    
}
