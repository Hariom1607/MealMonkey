//
//  ForgotPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let allViews = [txtEmail!, btnSend!]
        
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        txtEmail.setPadding(left: 34)

    }
    
    @IBAction func btnSendAction(_ sender: Any) {
    }
    
    

}
