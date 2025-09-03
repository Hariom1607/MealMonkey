import Foundation

// API helper for product-related network calls
class ProductAPIHelper {
    // Singleton instance
    static let shared = ProductAPIHelper()
    
    // Private init to prevent multiple instances
    private init() {}
    
    // API endpoint URL
    private let apiURL = "https://mocki.io/v1/e60bf567-b729-48c3-a316-d23b8a0ea24b"
    
    // Fetch products from API
    func fetchProducts(completion: @escaping ([ProductModel]?) -> Void) {
        // Validate URL
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        // API call
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Ensure data received and no error
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                // Decode JSON response
                let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                completion(response.products)
            } catch {
                // Handle decoding error
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }
}

// API response model
class ProductResponse: Codable {
    var products: [ProductModel] = []        // List of products
    var productTypes: [ProductType] = []     // List of product types
    var productCategories: [ProductCategory] = [] // List of product categories
}
