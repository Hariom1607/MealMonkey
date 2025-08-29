import UIKit

// MARK: - Wishlist View Controller
// This screen displays the list of products added to the user's wishlist
class WishlistViewController: UIViewController {
    
    // MARK: - Properties
    var wishlistProducts: [ProductModel] = []     // Array of wishlist products for current user
    var currentUserEmail: String = ""             // Logged-in user's email
    
    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!         // Label shown when wishlist is empty
    @IBOutlet weak var tblWishlist: UITableView!  // TableView displaying wishlist products
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get current user email from UserDefaults
        currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") ?? ""
        
        // Setup TableView
        tblWishlist.delegate = self
        tblWishlist.dataSource = self
        
        // Register custom cell (WishlistTableViewCell)
        tblWishlist.register(
            UINib(nibName: Main.cells.wishlistCell, bundle: nil),
            forCellReuseIdentifier: Main.cells.wishlistCell
        )
        
        // Load wishlist data from CoreData
        loadWishlist()
        
        // Set navigation title with back button
        setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backBtnTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh wishlist every time the screen appears
        loadWishlist()
    }
    
    // MARK: - Navigation
    @objc func backBtnTapped() {
        // Navigate back to previous screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Data Loading
    func loadWishlist() {
        // Fetch wishlist products from CoreData for logged-in user
        wishlistProducts = CoreDataHelper.shared.fetchWishlistProducts(for: currentUserEmail)
        
        // Reload table view with fetched products
        tblWishlist.reloadData()
        
        // Show or hide "Empty Wishlist" label
        lblEmpty.isHidden = !wishlistProducts.isEmpty
        tblWishlist.isHidden = wishlistProducts.isEmpty
    }
}
