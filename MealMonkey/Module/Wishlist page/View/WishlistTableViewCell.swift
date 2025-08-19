import UIKit

// MARK: - Wishlist Table Cell
// This cell is used in Wishlist / Product List screen to display product info and toggle wishlist state
class WishlistTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var btnWishlist: UIButton!       // Heart button for wishlist toggle
    @IBOutlet weak var lblPrice: UILabel!           // Product price label
    @IBOutlet weak var lblType: UILabel!            // Product type (Veg/Non-Veg/etc.)
    @IBOutlet weak var lblCategory: UILabel!        // Product category (Snacks, Beverages, etc.)
    @IBOutlet weak var lblProductName: UILabel!     // Product name
    @IBOutlet weak var imgProduct: UIImageView!     // Product image
    
    // MARK: - Properties
    var productId: Int = 0                          // Product unique ID
    var userEmail: String = ""                      // Logged-in user email for wishlist association
    var onWishlistToggle: (() -> Void)?             // Callback closure to notify table view when wishlist changes
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round image corners for better UI
        imgProduct.layer.cornerRadius = 8
        imgProduct.clipsToBounds = true
    }
    
    // MARK: - Configure Cell
    // This method sets up cell data with product details
    func configure(with product: ProductModel, userEmail: String) {
        productId = product.intId
        self.userEmail = userEmail
        
        // Assign text values to labels
        lblProductName.text = product.strProductName
        lblPrice.text = "₹\(product.doubleProductPrice)"
        lblCategory.text = product.objProductCategory.rawValue
        lblType.text = product.objProductType.rawValue
        
        // Load product image
        if product.strProductImage.hasPrefix("http") {
            // Case: Remote URL image
            if let imageUrl = URL(string: product.strProductImage) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgProduct.image = image
                        }
                    } else {
                        // Fallback placeholder if loading fails
                        DispatchQueue.main.async {
                            self?.imgProduct.image = UIImage(named: "placeholder")
                        }
                    }
                }.resume()
            }
        } else {
            // Case: Local asset image
            imgProduct.image = UIImage(named: product.strProductImage) ?? UIImage(named: "placeholder")
        }
        
        // ✅ Check CoreData to determine wishlist state and update heart button
        let isInWishlist = CoreDataHelper.shared.isInWishlist(productId: product.intId, userEmail: userEmail)
        btnWishlist.setImage(UIImage(systemName: isInWishlist ? "heart.fill" : "heart"), for: .normal)
    }
    
    // MARK: - Wishlist Button Action
    @IBAction func btnWishListAction(_ sender: Any) {
        // Toggle wishlist state in CoreData
        if CoreDataHelper.shared.isInWishlist(productId: productId, userEmail: userEmail) {
            // Remove from wishlist
            CoreDataHelper.shared.removeFromWishlist(productId: productId, userEmail: userEmail)
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            // Add to wishlist
            CoreDataHelper.shared.addToWishlist(productId: productId, userEmail: userEmail)
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        // Notify parent view controller to refresh UI (if needed)
        onWishlistToggle?()
    }
}
