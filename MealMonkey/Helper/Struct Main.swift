import CoreFoundation

// Main struct containing all constants and configurations
struct Main {
    
    // MARK: - Image Assets
    // Contains all image asset names used throughout the app for UI icons, buttons, food items, and animations
    struct images {
        static let appLogo = "ic_AppLogo" // App logo image used in splash and header
        static let btnCart = "btnCart" // Cart button image
        static let btnMoveToCurrentLocation = "Ic_Current_Location_Target" // Button icon for moving to current location
        static let locationPin = "Ic_Location_Pin" // Map pin icon for selected locations
        static let locationMessage = "Ic_Location_Rectangle" // Icon for location messages
        static let whiteCircle = "Ellipse 24" // Generic white circle for UI elements
        static let eye = "eye" // Eye icon to toggle password visibility
        static let eyeSlash = "eye.slash" // Eye-slash icon to hide password
        static let placeholder = "placeholder" // Placeholder image for empty state
        static let heart = "heart" // Wishlist or favorite icon (unselected)
        static let heartfill = "heart.fill" // Wishlist or favorite icon (selected)
        static let http = "http" // Icon used for external links
        static let defaultUser = "person.crop.circle" // Default profile image
        static let orderListAnimation = "OrderList" // Lottie animation for order list
        static let paymentDetails = "ic_1x_PaymentDetails" // Icon for payment details
        static let myOrders = "ic_1x_MyOrders" // Icon for "My Orders" section
        static let notifications = "ic_1x_Notifications" // Notifications icon
        static let inbox = "ic_1x_Inbox" // Inbox icon
        static let aboutUs = "ic_1x_aboutus" // About Us screen icon
        static let foodMenu = "ic_1x_FoodMenu" // Food menu icon
        static let beveragesMenu = "ic_1x_BeveragesMenu" // Beverages menu icon
        static let dessertsMenu = "ic_1x_DesertMenu" // Desserts menu icon
        static let frenchApplePie = "ic_FrenchApplePie" // Food item image
        static let darkChocolateCake = "ic_DarkChocolateCake" // Food item image
        static let streetShake = "ic_Street Shake" // Food item image
        static let fudgyChewyBrownies = "ic_Fudgy Chew Brownies" // Food item image
        static let shadeDesserts = "ic_shadeDesserts" // Dessert placeholder image
        static let punjabi = "ic_paneertikka" // Punjabi food category image
        static let chinese = "ic_hakkanoodles" // Chinese food category image
        static let gujarati = "Ic_Khaman_Dhokla" // Gujarati food category image
        static let southIndian = "ic_masaladosa" // South Indian food category image
        static let westernFood = "ic_margherita_pizza" // Western food category image
        static let featureFindFood = "ic_1x_Find food you love" // Feature section icon
        static let featureFastDelivery = "ic_1x_Delivery vector" // Feature section icon
        static let featureLiveTracking = "ic_1x_Live tracking vector" // Feature section icon
        static let circle = "circle" // Generic circle UI element
        static let circleFill = "circle.fill" // Filled circle for selection
        static let cartFill = "cart.fill" // Filled cart icon
    }
    
    // MARK: - TableView / CollectionView Cells
    // Cell identifiers for UITableView and UICollectionView used across the app
    struct cells {
        static let cartCell = "CartTableViewCell" // Cell for cart items
        static let checkoutCardCell = "CardTableViewCell" // Checkout cell for card payments
        static let checkoutCashCell = "CashOnDeliveryTableViewCell" // Checkout cell for cash payment
        static let checkoutUpiCell = "UpiTableViewCell" // Checkout cell for UPI payment
        static let featureCell = "FeatureCollectionViewCell" // Feature collection view cell
        static let homeFoosListCell = "FoodListTableViewCell" // Home screen food list cell
        static let homeFoodCategoryCell = "FoodCategoryCollectionViewCell" // Home screen food category cell
        static let homePopulatFoodCell = "PopularFoodCollectionViewCell" // Popular food cell
        static let homeMostPopulatFoodCell = "MostPopularCollectionViewCell" // Most popular food cell
        static let homeRecentItemsCell = "RecentItemsCollectionViewCell" // Recently added items cell
        static let menuDessertCell = "DessertsTableViewCell" // Dessert menu cell
        static let menuCell = "MenuTableViewCell" // General menu table cell
        static let aboutUsCell = "AboutUsTableViewCell" // About Us table cell
        static let morePageCell = "MoreTableViewCell" // More options screen cell
        static let myOrderCell = "MyOrderTableViewCell" // My orders cell
        static let paymentDetailCell = "PaymentDetailsTableViewCell" // Payment details cell
        static let offersCell = "OffersTableViewCell" // Offers cell
        static let orderListCell = "OrderListTableViewCell" // Order list cell
        static let wishlistCell = "WishlistTableViewCell" // Wishlist screen cell
    }
    
    // MARK: - Storyboards
    // All storyboard names used in the app
    struct storyboards {
        static let aboutUs = "AboutUsStoryboard" // About Us storyboard
        static let feature = "FeatureStoryboard" // Feature screens storyboard
        static let main = "Main" // Main app storyboard
        static let menu = "MenuStoryboard" // Menu storyboard
        static let tabBar = "TabBarStoryboard" // Tab bar storyboard
        static let userlogin = "UserLoginStoryboard" // User login and signup storyboard
    }
    
    // MARK: - ViewControllers
    // Identifier names for all ViewControllers in the app
    struct viewController {
        static let cart = "CartViewController" // Cart screen
        static let checkout = "CheckoutViewController" // Checkout screen
        static let feature = "FeatureViewController" // Onboarding/feature screen
        static let foodDetail = "FoodDetailViewController" // Detailed food info screen
        static let foodScreen = "FoodScreenViewController" // Main food browsing screen
        static let forgotPassword = "ForgotPasswordViewController" // Forgot password screen
        static let newPassword = "NewPasswordViewController" // Change new password screen
        static let login = "LoginViewController" // Login screen
        static let map = "MapViewController" // Map and location screen
        static let menu = "MenuViewController" // Menu screen
        static let desserts = "DessertsViewController" // Desserts screen
        static let aboutUs = "AboutUsViewController" // About us screen
        static let mainMore = "MoreViewController" // More options screen
        static let myOrder = "MyOrderViewController" // User orders screen
        static let paymentDetails = "PaymentDetailsViewController" // Payment details screen
        static let offers = "OffersViewController" // Offers screen
        static let orderList = "OrderListViewController" // Order list screen
        static let otp = "OtpViewController" // OTP verification screen
        static let profile = "ProfileViewController" // User profile screen
        static let signup = "SignupViewController" // Signup screen
        static let splash = "SplashViewController" // Splash screen
        static let menuTabBar = "MenuTabViewController" // Tab bar with menu options
        static let wishlist = "WishlistViewController" // Wishlist screen
    }
    
    // MARK: - UserDefaults Keys
    // Keys for storing data locally using UserDefaults
    struct UserDefaultsKeys {
        static let isLoggedIn = "isLoggedIn" // Boolean to track login status
        static let currentUserEmail = "currentUserEmail" // Stores current user email
        static let currentUserName = "currentUserName" // Stores current user name
        static let userName = "userName" // Stores user name
        static let userEmail = "userEmail" // Stores user email
        static let userMobile = "userMobile" // Stores user mobile number
        static let userAddress = "userAddress" // Stores user address
        static let currentUser = "currentUser" // Stores full user object
    }
    
    // MARK: - Alerts
    // Titles and messages for alert dialogs in the app
    struct Alerts {
        static let signup = "Signup" // Signup alert title
        static let login = "Login" // Login alert title
        static let error = "Error" // General error alert title
        static let success = "Success" // General success alert title
        static let validationError = "Validation Error" // Validation error title
        static let otpSentMsg = "A new OTP has been sent to your registered mobile number." // OTP message
        static let invalidInput = "Invalid Input" // Invalid input alert
        static let cartEmptyTitle = "Cart is Empty" // Cart empty alert title
        static let cartEmptyMessage = "Please add items to your cart before placing an order." // Cart empty message
        static let orderPlacedTitle = "Order Placed" // Order placed alert title
        static let orderPlacedMessage = "Your order has been placed successfully!" // Order placed message
        static let orderErrorTitle = "Error" // Order error alert title
        static let orderErrorMessage = "Failed to place order. Please try again." // Order error message
    }
    
    // MARK: - Messages
    // Generic messages displayed in app for success, failure, or informational prompts
    struct Messages {
        static let signupSuccess = "✅ Signup successful! Please login." // Signup success message
        static let userExists = "⚠️ User already exists, try logging in." // User exists message
        static let loginFailed = "Invalid email or password. Please sign up if you don't have an account." // Login failure message
        static let profileUpdated = "Profile updated successfully!" // Profile update success
        static let profileUpdateFailed = "Failed to update profile." // Profile update failure
        static let emailExists = "This email is already registered. Please use another one." // Email exists message
        static let emptyFields = "All fields must be filled before saving." // Empty field message
        static let emailEmpty = "Email cannot be empty." // Email empty message
        static let noOrders = "You have no orders yet 🍴" // No orders message
        static let noSavedCards = "No saved cards yet.\nAdd one to continue." // No saved card message
        static let userNotFound = "User not found" // User not found message
        static let cardAlreadySaved = "This card is already saved." // Card already saved message
        static let noMenuResults = "No results found 🔍" // No search results message
    }
    
    // MARK: - Validation Messages
    // Messages to display for form validations
    struct ValidationMessages {
        static let nameMissing = "Please enter your name" // Missing name
        static let emailMissing = "Please enter your email" // Missing email
        static let invalidEmail = "Please enter a valid email address" // Invalid email format
        static let mobileMissing = "Please enter your mobile number" // Missing mobile
        static let addressMissing = "Please enter your address" // Missing address
        static let passwordMissing = "Please enter your password" // Missing password
        static let invalidPassword = "Please enter a stronger password" // Weak password
        static let confirmPasswordMissing = "Please re-enter password" // Missing confirm password
        static let passwordMismatch = "Password and confirm password must match" // Password mismatch
        static let noAccFoundEmail = "No Account found with this email" // Email not registered
        static let otpSentMsg = "An OTP has been sent to" // OTP sent confirmation
        static let invalidCardInput = "Please fill all fields correctly." // Invalid card entry
        static let otpSentMobile = "An OTP has been sent to your Registered Mobile No" // OTP sent to mobile
    }
    
    // MARK: - Alert Titles
    // Predefined alert titles for various scenarios
    struct AlertTitle {
        static let NameMissing = "Name Missing" // Missing name alert
        static let EmailMissing = "Email Missing" // Missing email alert
        static let InvalidEmail = "Invalid Email" // Invalid email alert
        static let MobileMissing = "Mobile Missing" // Missing mobile alert
        static let AddressMissing = "Address Missing" // Missing address alert
        static let PasswordMissing = "Password Missing" // Missing password alert
        static let InvalidPassword = "Invalid Password" // Weak password alert
        static let ConfirmPasswordMissing = "Confirm Password Missing" // Confirm password alert
        static let PasswordMismatch = "Passwords Do Not Match" // Password mismatch alert
        static let okBtn = "OK" // Default OK button text
        static let loginFailed = "Login Failed" // Login failed title
        static let loginSuccessful = "✅ Login successful" // Login success title
        static let otpSent = "OTP Sent" // OTP sent title
        static let invalidInput = "Invalid Input" // Invalid input title
    }
    
    // MARK: - Back Button Titles
    // Titles displayed on back buttons in navigation bars
    struct backBtnTitle {
        static let forgotPassword = "Forgot Password" // Back button title for forgot password
        static let wishList = "WishList" // Back button title for wishlist
        static let profile = "Profile" // Back button title for profile
        static let myOrder = "My Order" // Back button title for my orders
        static let menu = "Menu" // Back button title for menu
        static let map = "Change Address" // Back button title for map screen
        static let checkout = "Checkout" // Back button title for checkout
        static let cart = "Cart" // Back button title for cart
        static let otp = "OTP" // Back button title for OTP screen
    }
    
    // MARK: - Labels
    // Standard labels used throughout the app for UI elements and texts
    struct Labels {
        static let welcomePrefix = "Welcome, " // Prefix for welcome messages
        static let otp = "OTP" // OTP label
        static let orderList = "Order List" // Order list screen title
        static let latestOffers = "Latest Offers" // Offers section title
        static let orderNoPrefix = "Order No : " // Prefix for order numbers
        static let currencySymbol = "$" // Currency symbol
        static let paymentDetails = "Payment Details" // Payment details screen label
        static let more = "More" // More screen label
        static let myOrders = "My Orders" // My orders label
        static let notifications = "Notifications" // Notifications label
        static let inbox = "Inbox" // Inbox label
        static let wishlist = "Wishlist" // Wishlist label
        static let aboutUs = "About Us" // About Us label
        static let menu = "Menu" // Menu label
        static let popular = "Popular" // Popular section label
        static let mostPopular = "Most Popular" // Most popular section label
        static let recentItems = "Recent Items" // Recent items section label
        static let foodDetail = "Food Detail" // Food detail screen label
        static let success = "Success" // Success label
        static let addedToCart = "Added to cart!" // Feedback for cart addition
        static let ok = "OK" // Default OK label
        static let next = "Next" // Next button label
        static let done = "Done" // Done button label
        static let selectLocation = "Select your location" // Location selection prompt
        static let unknown = "Unknown" // Default unknown text
    }
    
    
    // MARK: - UI Constants
    // Generic UI constants used across the app
    struct UI {
        static let cornerRadiusSmall: CGFloat = 7.42 // Standard small corner radius for buttons, cards, and views
    }
    
    // MARK: - Offers
    // Predefined offers and featured restaurants
    struct Offers {
        // Café de Noires
        static let cafeDeNoiresImage = "ic_Café de Noires" // Image for Café de Noires
        static let cafeDeNoiresName = "Café de Noires" // Display name for Café de Noires
        
        // Isso
        static let issoImage = "ic_Isso" // Image for Isso restaurant
        static let issoName = "Isso" // Display name for Isso
        
        // Cafe Beans
        static let cafeBeansImage = "ic_Cafe Beans" // Image for Cafe Beans
        static let cafeBeansName = "Cafe Beans" // Display name for Cafe Beans
        
        // Common default values
        static let defaultRatings = "(124 ratings)" // Default ratings display
        static let defaultRestaurantType = "Café" // Default type of restaurant
        static let defaultFoodType = "Western Food" // Default cuisine type
    }
    
    // MARK: - Animations
    // Lottie animation names used in the app
    struct Animations {
        static let paymentFailed = "Payment Failed" // Payment failed animation
        static let menu = "Menu" // Menu animation (e.g., menu loading)
    }
    
    // MARK: - Colors
    // App color assets and UI-related constants
    struct Colors {
        static let transparent = "Transparentcolor" // Transparent color reference
        static let navigationcolor = "NavigationColor" // Navigation bar color
        static let navigationBackBtnColor = "chevron.backward" // Back button color/icon
        static let fontTextfield = "HelveticaNeue-Bold" // Font used in textfields
    }
    
    // MARK: - Menu Categories
    // Predefined menu categories
    struct MenuCategories {
        static let food = "Food" // Food category
        static let beverages = "Beverages" // Beverages category
        static let desserts = "Desserts" // Desserts category
    }
    
    // MARK: - Menu Counts
    // Number of items in each category (example placeholders)
    struct MenuCounts {
        static let food = "25 Items" // Food item count
        static let beverages = "25 Items" // Beverages item count
        static let desserts = "25 Items" // Desserts item count
    }
    
    // MARK: - Product Names
    // Food item display names
    struct ProductNames {
        static let frenchApplePie = "French Apple Pie"
        static let darkChocolateCake = "Dark Chocolate Cake"
        static let streetShake = "Street Shake"
        static let fudgyChewyBrownies = "Fudgy Chewy Brownies"
    }
    
    // MARK: - Restaurants
    // Restaurant display names
    struct Restaurants {
        static let mealMonkey = "Meal Monkey" // Main restaurant
        static let minuteByTukTuk = "Minute by tuk tuk" // Secondary restaurant
    }
    
    // MARK: - Empty State
    // Assets and messages for empty states
    struct EmptyState {
        static let wishlistjson = "Wishlist" // JSON reference for wishlist
        static let dessertsAnimation = "Walking Orange" // Dessert empty animation
        static let noItemsFound = "No items found" // Generic empty message
        static let cartAnimation = "Add to cart" // Cart empty animation
        static let cartEmptyMessage = "Your cart is empty" // Cart empty text
        static let wishlistEmptyMessage = "Your wishlist is empty" // Wishlist empty text
    }
    
    // MARK: - Ratings
    // Default ratings
    struct Ratings {
        static let defaultRating = "4.9" // Default displayed rating
    }
    
    // MARK: - Map
    // Map-related constants for UI and storage
    struct map {
        static let navTitle = "Change Address" // Navigation title for map screen
        
        // Pin titles
        static let currentLocation = "Your Current Location"
        static let selectedLocation = "Selected Location"
        static let searchedLocation = "Searched Location"
        static let savedLocation = "Saved Location"
        static let defaultLocation = "Location"
        
        // Keys for storing location data in UserDefaults
        static let currentAddressKey = "currentAddress"
        static let latitudeKey = "currentLatitude"
        static let longitudeKey = "currentLongitude"
        
        // Pin icon
        static let locationPin = "Ic_Location_Pin"
    }
    
    // MARK: - New Password Screen
    // Titles, messages, and icons used in new password screen
    struct NewPassword {
        static let navTitle = "New Password" // Screen title
        
        // Validation Titles
        static let newPasswordMissingTitle = "New Password is missing"
        static let confirmPasswordMissingTitle = "Confirm Password is missing"
        static let mismatchTitle = "Mismatch"
        static let errorTitle = "Error"
        
        // Validation Messages
        static let newPasswordMissingMessage = "Please enter your New Password"
        static let confirmPasswordMissingMessage = "Please enter your Confirm Password"
        static let mismatchMessage = "Passwords do not match"
        static let errorMessage = "Failed to change the password"
        
        // Eye icons for show/hide password
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
    }
    
    // MARK: - Keys
    // Keys for product or cart data dictionaries
    struct Keys {
        static let intId = "intId"
        static let strProductName = "strProductName"
        static let strProductDescription = "strProductDescription"
        static let doubleProductPrice = "doubleProductPrice"
        static let strProductImage = "strProductImage"
        static let intProductQty = "intProductQty"
        static let floatProductRating = "floatProductRating"
        static let intTotalNumberOfRatings = "intTotalNumberOfRatings"
        static let objProductCategory = "objProductCategory"
        static let objProductType = "objProductType"
    }
    
    // MARK: - Feature Texts
    // Texts for onboarding or feature screens
    struct FeatureTexts {
        // Titles
        static let findFoodTitle = "Find Food You Love"
        static let fastDeliveryTitle = "Fast Delivery"
        static let liveTrackingTitle = "Live Tracking"
        
        // Subtitles
        static let findFoodSubTitle = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
        static let fastDeliverySubTitle = "Fast food delivery to your home, office wherever you are"
        static let liveTrackingSubTitle = "Real time tracking of your food on the app once you placed the order"
    }
    
    // MARK: - Validation Patterns
    // Regex patterns for form validation
    struct ValidationPatterns {
        static let password = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"# // Password: min 8, uppercase, lowercase, number, special char
        static let email = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"# // Email format
    }
    
    // MARK: - Predicate Formats
    // NSPredicate formats for CoreData or array filtering
    struct PredicateFormats {
        static let matches = "SELF MATCHES %@"
        static let email = "email == %@"
        static let usersemail = "users.email == %@"
        static let useremail = "user.email == %@"
        static let emailandPassword = "email == %@ AND password == %@"
        static let emailandemail = "email == %@ AND email != %@"
        static let userEmail = "userEmail == %@"
        static let userEmailandProductId = "userEmail == %@ AND productId == %d"
        static let useremailandId = "user.email == %@ AND id == %d"
    }
    
    // MARK: - About Us Model
    // Text content displayed in About Us screen
    struct aboutUsModel {
        static let strText1 = "Our mission is to deliver a seamless and intuitive shopping experience..."
        static let strText2 = "We are dedicated to maintaining high standards of performance, transparency..."
        static let strText3 = "Your feedback matters. If you have any questions, suggestions..."
        static let strText4 = "We believe that technology should serve people. That’s why we constantly refine..."
        static let strText5 = "Security is our priority. We use industry-standard protocols..."
        static let strText6 = "We value accessibility and inclusiveness. Our platform is designed to be usable by..."
        static let strText7 = "Sustainability matters to us. We support eco-friendly business practices..."
    }
    
    // MARK: - Inbox Model
    // Predefined messages for the inbox
    struct inboxModel {
        static let promotions = ("MealMonkey Promotions", "6th July", "Get 20% off on your next meal!")
        static let orderUpdate = ("Order Update", "6th July", "Your order is being prepared by the restaurant.")
        static let deliveryReminders = ("Delivery Reminder", "6th July", "Your delivery agent is on the way.")
        static let welcome = ("Welcome to MealMonkey", "6th July", "Thanks for joining us! Start exploring meals.")
        static let experience = ("Rate Your Experience", "6th July", "How was your recent meal order?")
        static let flashSale = ("Flash Sale", "6th July", "Enjoy 30% off on all pasta orders today only.")
        static let newRestaurants = ("New Restaurants", "6th July", "Discover trending restaurants in your area.")
        static let referEarn = ("Refer & Earn", "6th July", "Invite friends and earn ₹100 credits!")
        static let weekendSpecial = ("Weekend Special", "6th July", "Free dessert on orders above ₹499.")
        static let tips = ("MonkeyMeal Tips", "6th July", "Customize your orders with special instructions.")
        static let orderCancel = ("Order Cancelled", "6th July", "Your order has been cancelled as requested.")
        static let loyaltyProgram = ("Loyalty Program", "6th July", "Collect Monkey Points with every purchase.")
        static let securityUpdate = ("Security Update", "6th July", "Your password was recently changed.")
        static let accountVerified = ("Account Verified", "6th July", "Your account has been successfully verified.")
        static let limitedDeal = ("Limited Time Deal", "6th July", "Flat ₹50 off on biryani orders today.")
    }
    
    // MARK: - Notification Model
    // Predefined notifications displayed to the user
    struct notificationModel {
        static let orderPlaced = ("Order placed successfully", "Just now")
        static let paymentConfirmed = ("Your payment has been confirmed", "5m ago")
        static let foodPrepared = ("Your food is being prepared", "10m ago")
        static let agentAssigned = ("Delivery agent assigned", "30m ago")
        static let orderOnWay = ("Your order is on the way", "1h ago")
        static let discount = ("Special discount available!", "2h ago")
        static let appUpdate = ("Download our new app update", "3h ago")
        static let referFriend = ("Refer a friend and earn", "5h ago")
        static let limitedDeal = ("Limited-time deal ending soon", "12h ago")
        static let deliveryDone = ("Delivery completed", "1d ago")
        static let rateMeal = ("Rate your last meal", "2d ago")
        static let weekendOffer = ("Weekend offer just for you", "3d ago")
        static let freeDelivery = ("Free delivery on orders above ₹299", "5d ago")
        static let thanks = ("Thanks for being with us!", "6d ago")
        static let newRestaurants = ("New restaurants added near you", "1w ago")
    }
}
