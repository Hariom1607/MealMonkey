//
//  OtpViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit
import DPOTPView

class OtpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnOtpRegeneration: UIButton! // Button to regenerate OTP
    @IBOutlet weak var btnNext: UIButton!            // Button to proceed after OTP verification
    @IBOutlet weak var viewOtp: DPOTPView!
    
    var email: String?
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack("OTP", target: self, action: #selector(otpBackBtnTapped))
        
        // Round corners for Next button
        btnNext.layer.cornerRadius = 28
        
        setupOtpView()
    }
    
    func setupOtpView() {
        
        viewOtp.count = 5
        viewOtp.spacing = 10
        viewOtp.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        viewOtp.dismissOnLastEntry = true
        viewOtp.borderColorTextField = .black
        viewOtp.selectedBorderColorTextField = .blue
        viewOtp.borderWidthTextField = 2
        viewOtp.backGroundColorTextField = .textFieldBackground
        viewOtp.cornerRadiusTextField = 8
        viewOtp.isCursorHidden = true
        
    }
    
    // MARK: - Button Actions
    
    /// Back button tap → navigate back
    @objc func otpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Regenerate OTP button tap → show alert
    @IBAction func btnOtpRegenerationAction(_ sender: Any) {
        let alert = UIAlertController(
            title: "OTP Sent",
            message: "A new OTP has been sent to your registered mobile number.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Next button tap → navigate to new password screen
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: Main.viewController.newPassword) as? NewPasswordViewController {
            mlvc.email = email
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}

// MARK: - UITextField Delegate
extension OtpViewController: UITextFieldDelegate {
    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
