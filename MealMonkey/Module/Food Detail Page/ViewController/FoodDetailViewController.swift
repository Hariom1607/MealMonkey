//
//  FoodDetailViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var btnDropDownPortions: UIButton!
    @IBOutlet weak var btnDropDownIngredients: UIButton!
    @IBOutlet weak var viewFoodDetailContent: UIScrollView!
    @IBOutlet weak var stackRating: UIStackView!
    @IBOutlet weak var lblTotalPice: UILabel!
    @IBOutlet weak var btnAddtoCart: UIButton!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblNimberOfPortion: UILabel!
    @IBOutlet weak var btnPortionIncrease: UIButton!
    @IBOutlet weak var btnPortionReduce: UIButton!
    @IBOutlet weak var txtSelectIngridients: UITextField!
    @IBOutlet weak var txtSizeOfPortions: UITextField!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrize: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    
    // Access to AppDelegate (for cart management)
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - Properties
    var product: ProductModel?              // Current product being displayed
    var quantity: Int = 1                   // Portion quantity
    var cartItems: [(product: ProductModel, quantity: Int)] = []
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reset nav bar appearance
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        // Re-apply custom nav items
        setLeftAlignedTitleWithBack(Main.Labels.foodDetail, target: self, action: #selector(detailBackBtnTapped))
        setCartButton(target: self, action: #selector(cartBtnTapped))
        updateWishlistButton() // Refresh wishlist state when screen appears
        updateCartBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style UI components
        let allviews = [btnPortionReduce!, btnPortionIncrease!]
        styleViews(allviews, cornerRadius: 15, borderWidth: 0, borderColor: UIColor.black.cgColor)
        styleViews([lblNimberOfPortion], cornerRadius: 15, borderWidth: 1, borderColor: UIColor.loginButton.cgColor)
        setTextFieldPadding([txtSelectIngridients!, txtSizeOfPortions!])
        btnAddtoCart.layer.cornerRadius = 7.42
        
        styleViews([viewFoodDetailContent], cornerRadius: 42, borderWidth: 1, borderColor: UIColor.extraLabel.cgColor)
        viewFoodDetailContent.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewFoodDetailContent.clipsToBounds = true
        
        // Configure product UI directly
        configureUI()
        updateWishlistButton()
        setCartButton(target: self, action: #selector(self.cartBtnTapped))
        
        // Styling dropdowns & text fields
        styleViews([btnDropDownPortions!, btnDropDownIngredients!, txtSizeOfPortions!, txtSelectIngridients!], cornerRadius: 4, borderWidth: 0, borderColor: UIColor.white.cgColor)
        btnDropDownIngredients.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        btnDropDownPortions.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        txtSizeOfPortions.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        txtSelectIngridients.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        // Default setup for portion & buttons
        quantity = 1
        lblNimberOfPortion.text = "\(quantity)"
        btnPortionReduce.isEnabled = false
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        guard let product = product else { return }
        lblFoodName.text = product.strProductName
        lblFoodDescription.text = product.strProductDescription
        imgFood.image = UIImage(named: product.strProductImage)
        updatePriceAndQuantityUI()
    }
    
    /// Updates wishlist button (filled heart if product is in wishlist)
    private func updateWishlistButton() {
        guard let product = product,
              let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) else {
            btnWishlist.setImage(UIImage(systemName: Main.images.heart), for: .normal)
            return
        }
        let filled = CoreDataHelper.shared.isInWishlist(productId: product.intId, userEmail: currentUserEmail)
        btnWishlist.setImage(UIImage(systemName: filled ? Main.images.heartfill : Main.images.heart), for: .normal)
    }
    
    /// Configures product details (name, description, image)
    func configureUI() {
        guard let product = product else { return }
        lblFoodName.text = product.strProductName
        lblFoodDescription.text = product.strProductDescription
        imgFood.image = UIImage(named: product.strProductImage)
        updatePriceAndQuantityUI()
    }
    
    /// Updates UI labels for price, total, and portion quantity
    func updatePriceAndQuantityUI() {
        guard let product = product else { return }
        let total = product.doubleProductPrice * Double(quantity)
        lblFoodPrize.text = "$ \(String(format: "%.2f", product.doubleProductPrice))"
        lblTotalPice.text = "$ \(String(format: "%.2f", total))"
        lblNimberOfPortion.text = "\(quantity)"
        btnPortionReduce.isEnabled = quantity > 1
    }
    
    // MARK: - Navigation Actions
    @objc func detailBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - Button Actions
    /// Add product to cart in CoreData
    @IBAction func btnAddToCartAction(_ sender: Any) {
        guard let product = product,
              let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) else { return }
        
        CoreDataHelper.shared.addCartItem(product: product, quantity: quantity, userEmail: currentUserEmail)
        
        //  Update the cart badge instantly
        self.updateCartBadge()
        
        // Show confirmation alert
        let alert = UIAlertController(title: Main.Labels.success, message: Main.Labels.addedToCart, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Main.Labels.ok, style: .default))
        present(alert, animated: true)
    }
    
    /// Decrease portion count
    @IBAction func btnPortionDecreaseAction(_ sender: Any) {
        if quantity > 1 {
            quantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    /// Increase portion count
    @IBAction func btnPortionIncreaseAction(_ sender: Any) {
        quantity += 1
        updatePriceAndQuantityUI()
    }
    
    /// Toggle wishlist state (add/remove)
    @IBAction func btnWishlistAction(_ sender: Any) {
        guard let product = product,
              let currentUserEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) else { return }
        
        if CoreDataHelper.shared.isInWishlist(productId: product.intId, userEmail: currentUserEmail) {
            CoreDataHelper.shared.removeFromWishlist(productId: product.intId, userEmail: currentUserEmail)
        } else {
            CoreDataHelper.shared.addToWishlist(productId: product.intId, userEmail: currentUserEmail)
        }
        updateWishlistButton()
    }
    
    // Dropdown buttons (currently no logic)
    @IBAction func btnDropDownPortionAction(_ sender: Any) {}
    @IBAction func btnDropDownIngredientsAction(_ sender: Any) {}
    
    // MARK: - Cart Management (legacy UserDefaults)
    /// Checks if product exists in cart and updates or adds new
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            appDelegate.arrCart[existingIndex].intProductQty = (appDelegate.arrCart[existingIndex].intProductQty ?? 0) + quantity
        } else {
            var newProduct = productToAdd
            newProduct.intProductQty = quantity
            appDelegate.arrCart.append(newProduct)
        }
        
        // Save updated cart in UserDefaults
        let cartDictArray = appDelegate.arrCart.map { product -> [String: Any] in
            return [
                Main.Keys.intId: product.intId,
                Main.Keys.strProductName: product.strProductName,
                Main.Keys.strProductDescription: product.strProductDescription,
                Main.Keys.doubleProductPrice: product.doubleProductPrice,
                Main.Keys.strProductImage: product.strProductImage,
                Main.Keys.intProductQty: product.intProductQty ?? 1,
                Main.Keys.floatProductRating: product.floatProductRating,
                Main.Keys.intTotalNumberOfRatings: product.intTotalNumberOfRatings,
                Main.Keys.objProductCategory: product.objProductCategory.rawValue,
                Main.Keys.objProductType: product.objProductType.rawValue
            ]
        }
    }
}
