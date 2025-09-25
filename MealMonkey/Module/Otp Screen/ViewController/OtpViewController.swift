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
    @IBOutlet weak var lblSubTitle: UILabel! // Please check your mobile number 071*****12 continue to reset your password
    @IBOutlet weak var lblOtpTitle: UILabel! // We have sent an OTP to your Mobile
    @IBOutlet weak var btnOtpRegeneration: UIButton! // Button to regenerate OTP
    @IBOutlet weak var btnNext: UIButton!            // Button to proceed after OTP verification
    @IBOutlet weak var viewOtp: DPOTPView!
    
    var email: String?
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ Apply theme initially
        applyTheme()
        
        // ✅ Observe theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        
        // Localize labels and buttons
        lblOtpTitle.text = Main.OTP.otpTitle
        lblSubTitle.text = Main.OTP.otpSubTitle
        btnOtpRegeneration.setTitle(Main.OTP.btnRegenerate, for: .normal)
        btnNext.setTitle(Main.OTP.btnNext, for: .normal)
        
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack(Main.BackBtnTitle.otp, target: self, action: #selector(otpBackBtnTapped))
        
        // Round corners for Next button
        btnNext.layer.cornerRadius = 28
        
        setupOtpView()
    }
    
    func setupOtpView() {
        viewOtp.count = 5
        viewOtp.spacing = 10
        viewOtp.fontTextField = UIFont(name: Main.Colors.fontTextfield, size: CGFloat(25.0))!
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
            title: Main.OTP.alertOtpSent,
            message: Main.OTP.otpSubTitle,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Main.OTP.okBtn, style: .default))
        self.present(alert, animated: true)
    }
    
    /// Next button tap → navigate to new password screen
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: Main.viewController.newPassword) as? NewPasswordViewController {
            mlvc.email = email
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
    
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        view.backgroundColor = theme.backgroundColor
        
        lblOtpTitle.textColor = theme.titleColor
        lblSubTitle.textColor = theme.secondaryFontColor
        
        // Buttons
        btnOtpRegeneration.setTitleColor(theme.buttonColor, for: .normal)
        
        btnNext.backgroundColor = theme.buttonColor
        btnNext.setTitleColor(theme.titleColor, for: .normal)
        btnNext.layer.cornerRadius = 28
        
        // OTP View styling
        viewOtp.borderColorTextField = theme.secondaryFontColor
        viewOtp.selectedBorderColorTextField = theme.buttonColor
        viewOtp.backGroundColorTextField = theme.secondaryFontColor.withAlphaComponent(0.1)
        viewOtp.fontTextField = UIFont(name: Main.Colors.fontTextfield, size: CGFloat(25.0))!
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
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
