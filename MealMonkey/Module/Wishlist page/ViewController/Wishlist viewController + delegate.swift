import UIKit

// MARK: - TableView Delegate & DataSource
extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows = number of wishlist products
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistProducts.count
    }
    
    // Configure each cell with product details
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable WishlistTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.wishlistCell, for: indexPath) as! WishlistTableViewCell
        
        // Get product for current row
        let product = wishlistProducts[indexPath.row]
        
        // Configure the cell with product data and user email
        cell.configure(with: product, userEmail: currentUserEmail)
        
        // Closure: reload wishlist when heart icon is toggled
        // (removes or adds product, then refreshes table & empty state)
        cell.onWishlistToggle = { [weak self] in
            self?.loadWishlist()
        }
        
        return cell
    }
}
