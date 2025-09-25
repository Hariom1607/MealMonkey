import Foundation
import UIKit

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
        static let language = "globe" // 👈 Or your custom asset
        static let palette = "paintpalette"
        static let close = "X" // ❌ system symbol
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
    
    struct Login {
        // Labels
        static var lblOrLoginWith: String { Localized("lbl_or_login_with") }
        static var lblAddDetailToLogin: String { Localized("lbl_add_your_detail_to_login") }
        static var lblLogin: String { Localized("lbl_login") }
        
        // TextField Placeholders
        static var txtEmailPlaceholder: String { Localized("txt_email_placeholder") }
        static var txtPasswordPlaceholder: String { Localized("txt_password_placeholder") }
        
        // Buttons
        static var btnEye: String { Localized("btn_eye") }
        static var btnSignup: String { Localized("btn_signup_text") }
        static var btnGoogleLogin: String { Localized("btn_google_login") }
        static var btnFacebookLogin: String { Localized("btn_facebook_login") }
        static var btnForgotPassword: String { Localized("btn_forgot_password") }
        static var btnLogin: String { Localized("btn_login") }
        
        // Alerts
        static var alertLoginSuccessful: String { Localized("alert_login_successful") }
        static var alertLoginFailed: String { Localized("alert_login_failed") }
        static var alertEmailMissing: String { Localized("alert_email_missing") }
        static var alertInvalidEmail: String { Localized("alert_invalid_email") }
        static var alertPasswordMissing: String { Localized("alert_password_missing") }
        static var alertInvalidPassword: String { Localized("alert_invalid_password") }
        
        // Validation messages
        static var validationEmailMissing: String { Localized("validation_email_missing") }
        static var validationInvalidEmail: String { Localized("validation_invalid_email") }
        static var validationPasswordMissing: String { Localized("validation_password_missing") }
        static var validationInvalidPassword: String { Localized("validation_invalid_password") }
    }
    
    struct Signup {
        // Labels
        static var lblAddYourDetails: String { Localized("lbl_add_your_details_signup") }
        static var lblSignupTitle: String { Localized("lbl_signup_title") }
        
        // TextFields Placeholders
        static var txtNamePlaceholder: String { Localized("txtfield_name_placeholder") }
        static var txtEmailPlaceholder: String { Localized("txtfield_email_placeholder") }
        static var txtMobilePlaceholder: String { Localized("txtfield_mobile_placeholder") }
        static var txtAddressPlaceholder: String { Localized("txtfield_address_placeholder") }
        static var txtPasswordPlaceholder: String { Localized("txtfield_password_placeholder") }
        static var txtConfirmPasswordPlaceholder: String { Localized("txtfield_confirm_password_placeholder") }
        
        // Buttons
        static var btnSignup: String { Localized("btn_signup_action") }
        static var btnBackToLogin: String { Localized("btn_back_to_login") }
        static var btnEyePassword: String { Localized("btn_eye_password") }
        static var btnEyeConfirmPassword: String { Localized("btn_eye_confirm_password") }
        
        // Alerts
        static var alertSignupSuccess: String { Localized("alert_signup_success") }
        static var alertUserExists: String { Localized("alert_user_exists") }
        static var alertNameMissing: String { Localized("alert_name_missing") }
        static var alertEmailMissing: String { Localized("alert_email_missing") }
        static var alertInvalidEmail: String { Localized("alert_invalid_email") }
        static var alertMobileMissing: String { Localized("alert_mobile_missing") }
        static var alertAddressMissing: String { Localized("alert_address_missing") }
        static var alertPasswordMissing: String { Localized("alert_password_missing") }
        static var alertInvalidPassword: String { Localized("alert_invalid_password") }
        static var alertConfirmPasswordMissing: String { Localized("alert_confirm_password_missing") }
        static var alertPasswordMismatch: String { Localized("alert_password_mismatch") }
    }
    
    struct ForgotPassword {
        // Labels / Placeholders
        static var navTitle: String { Localized("lbl_forgotpassword_nav_title") }
        static var title: String { Localized("lbl_forgotpassword_title") }
        static var subtitle: String { Localized("lbl_forgotpassword_subtitle") }
        static var txtEmailPlaceholder: String { Localized("txtfield_email_placeholder") }
        static var btnSend: String { Localized("btn_send") }
        
        // Alerts / Validation
        static var alertEmailMissing: String { Localized("alert_email_missing") }
        static var validationEmailMissing: String { Localized("validation_email_missing") }
        static var alertInvalidEmail: String { Localized("alert_invalid_email") }
        static var validationInvalidEmail: String { Localized("validation_invalid_email") }
        static var alertOtpSent: String { Localized("alert_otp_sent") }
        static var okBtn: String { Localized("alert_ok") }
        static var noAccountFound: String { Localized("validation_no_account_email") }
    }
    
    struct OTP {
        // Labels / Buttons
        static var otpTitle: String { Localized("lbl_otp_title") }
        static var otpSubTitle: String { Localized("lbl_otp_subtitle") }
        static var btnRegenerate: String { Localized("btn_otp_regeneration") }
        static var btnNext: String { Localized("btn_otp_next") }
        
        // Alerts / Validation
        static var alertOtpSent: String { Localized("alert_otp_sent") }
        static var okBtn: String { Localized("alert_ok") }
        static var noAccountFound: String { Localized("validation_no_account_email") }
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
    struct BackBtnTitle {
        static var forgotPassword: String { Localized("label_back_forgot_password") }
        static var wishList: String { Localized("label_back_wishlist") }
        static var profile: String { Localized("label_back_profile") }
        static var myOrder: String { Localized("label_back_my_order") }
        static var menu: String { Localized("label_back_menu") }
        static var map: String { Localized("label_back_map") }
        static var checkout: String { Localized("label_back_checkout") }
        static var cart: String { Localized("label_back_cart") }
        static var otp: String { Localized("label_back_otp") }
    }
    
    // MARK: - Labels
    // Standard labels used throughout the app for UI elements and texts
    struct Labels {
        static let welcomePrefix = "Welcome, " // Prefix for welcome messages
        static let otp = "OTP" // OTP label
        static let orderList = "Order List" // Order list screen title
        static let latestOffers = "Latest Offers" // Offers section title
        static let orderNoPrefix = "Order No : " // Prefix for order numbers
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
        static let next = "Next" // Next button label
        static let done = "Done" // Done button label
        static let selectLocation = "Select your location" // Location selection prompt
        static let unknown = "Unknown" // Default unknown text
        
        static let moreLanguages = Localized("label_more_languages") // ✅ Localized
        static let moreThemes = Localized("label_more_themes")       // ✅ NEW key for Themes row
        static var moreNavTitle: String { Localized("label_more_nav_title") }
        static var morePaymentDetails: String { Localized("label_more_payment_details") }
        static var moreMyOrders: String { Localized("label_more_my_orders") }
        static var moreNotifications: String { Localized("label_more_notifications") }
        static var moreInbox: String { Localized("label_more_inbox") }
        static var moreWishlist: String { Localized("label_more_wishlist") }
        static var moreAboutUs: String { Localized("label_more_about_us") }
        
        static var aboutUsNavTitle: String { Localized("label_aboutus_nav_title") }
        static var inboxNavTitle: String { Localized("label_inbox_nav_title") }
        static var notificationsNavTitle: String { Localized("label_notifications_nav_title") }
        
        static var paymentNavTitle: String { Localized("label_payment_nav_title") }
        static var addNewCard: String { Localized("label_add_new_card") }
        static var addCard: String { Localized("label_add_card") }
        static var closeAddCardView: String { Localized("label_close_add_card_view") }
        static var firstName: String { Localized("label_first_name") }
        static var lastName: String { Localized("label_last_name") }
        static var cardNumber: String { Localized("label_card_number") }
        static var expiryMonth: String { Localized("label_expiry_month") }
        static var expiryYear: String { Localized("label_expiry_year") }
        static var securityCode: String { Localized("label_security_code") }
        static var invalidInput: String { Localized("label_alert_invalid_input") }
        static var userNotFound: String { Localized("label_alert_user_not_found") }
        static var cardAlreadySaved: String { Localized("label_alert_card_already_saved") }
        static var noSavedCards: String { Localized("label_no_saved_cards") }
        static var removeCardSwitch: String { Localized("label_remove_card_switch") }
        
        // MARK: - Food Detail Page
        static var foodDetailNavTitle: String { Localized("label_food_detail_nav_title") }
        
        static var success: String { Localized("label_success") }
        static var addedToCart: String { Localized("label_added_to_cart") }
        static var ok: String { Localized("label_ok") }
        
        static var btnAddToCart: String { Localized("label_btn_add_to_cart") }
        static var btnPortionIncrease: String { Localized("label_btn_portion_increase") }
        static var btnPortionDecrease: String { Localized("label_btn_portion_decrease") }
        
        static var txtSelectIngredients: String { Localized("label_txt_select_ingredients") }
        static var txtSizeOfPortions: String { Localized("label_txt_size_of_portions") }
        
        static var alertItemAdded: String { Localized("label_alert_item_added") }
        
        static var fourStarRatings: String { Localized("label_4_star_ratings") }
        static var totalPriceTitle: String { Localized("label_total_price_title") }
        static var perPortion: String { Localized("label_per_portion") }
        static var descriptionTitle: String { Localized("label_description_title") }
        static var customizeYourOrder: String { Localized("label_customize_your_order") }
        static var numberOfPortions: String { Localized("label_number_of_portions") }
        
        // ===================== Food Screen Page =====================
        static let foodscreenNavGreeting = Localized("label_foodscreen_nav_greeting")
        static let foodscreenNavGreetingUser = Localized("label_foodscreen_nav_greeting_user")
        static let foodscreenLocationPlaceholder = Localized("label_foodscreen_location_placeholder")
        static let foodscreenSearchPlaceholder = Localized("label_foodscreen_search_placeholder")
        static let foodscreenSectionPopular = Localized("label_foodscreen_section_popular")
        static let foodscreenSectionMostPopular = Localized("label_foodscreen_section_most_popular")
        static let foodscreenSectionRecent = Localized("label_foodscreen_section_recent")
        static let foodscreenBtnViewAll = Localized("label_foodscreen_btn_view_all")
        static let foodscreenDeliveringTo = Localized("label_foodscreen_delivering_to")
        
        // ===================== Profile Page =====================
        static let profileNavTitle = Localized("label_profile_nav_title")
        static let profileWelcome = Localized("label_profile_welcome")
        
        static let profileNamePlaceholder = Localized("label_profile_name_placeholder")
        static let profileEmailPlaceholder = Localized("label_profile_email_placeholder")
        static let profileMobilePlaceholder = Localized("label_profile_mobile_placeholder")
        static let profileAddressPlaceholder = Localized("label_profile_address_placeholder")
        
        static let profileBtnSave = Localized("label_profile_btn_save")
        static let profileBtnSignOut = Localized("label_profile_btn_signout")
        static let profileBtnEdit = Localized("label_profile_btn_edit")
        
        // My Order Page
        static var myOrderNavTitle: String { Localized("label_my_order_nav_title") }
        static var myOrderSubTotal: String { Localized("label_my_order_subtotal") }
        static var myOrderDeliveryCost: String { Localized("label_my_order_delivery_cost") }
        static var myOrderTotal: String { Localized("label_my_order_total") }
        static var myOrderAddNotes: String { Localized("label_my_order_add_notes") }
        static var myOrderCheckout: String { Localized("label_my_order_checkout") }
        static var currencySymbol: String { Localized("label_currency_symbol") }
        static var myOrderAddress: String { Localized("label_my_order_address") }
        static var myOrderMealMonkey: String { Localized("label_my_order_meal_monkey") }
        static var myOrderDeliveryCostTitle: String { Localized("label_my_order_delivery_cost_title") }
        static var myOrderSubTotalTitle: String { Localized("label_my_order_subtotal_title") }
        static var myOrderDeliveryInstruction: String { Localized("label_my_order_delivery_instruction") }
        
        // Checkout-specific labels
        static var checkoutYouCanRemoveCard: String { Localized("label_checkout_you_can_remove_card") }
        static var checkoutExpiry: String { Localized("label_checkout_expiry") }
        static var checkoutAddCreditDebitCard: String { Localized("label_checkout_add_credit_debit_card") }
        static var checkoutDescriptionThankYou: String { Localized("label_checkout_description_thank_you") }
        static var checkoutForYourOrder: String { Localized("label_checkout_for_your_order") }
        static var checkoutThankYou: String { Localized("label_checkout_thank_you") }
        
        // Checkout buttons
        static var btnAddCard: String { Localized("btn_checkout_add_card") }
        static var btnSendOrder: String { Localized("btn_checkout_send_order") }
        static var btnClose: String { Localized("btn_checkout_close") }
        static var btnBackToHome: String { Localized("btn_checkout_back_to_home") }
        static var btnTrackOrder: String { Localized("btn_checkout_track_order") }
        static var btnLocationChange: String { Localized("btn_location_change") }
        
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
        static var cafeDeNoiresName: String {
            Localized("label_offer_cafe_name_cafe_de_noires")
        }
        
        // Isso
        static let issoImage = "ic_Isso" // Image for Isso restaurant
        static var issoName: String {
            Localized("label_offer_cafe_name_isso")
        }
        
        // Cafe Beans
        static let cafeBeansImage = "ic_Cafe Beans" // Image for Cafe Beans
        static var cafeBeansName: String {
            Localized("label_offer_cafe_name_cafe_beans")
        }
        
        // Common default values
        static var defaultRatings: String {
            Localized("label_offer_default_ratings")
        }
        static var defaultRestaurantType: String {
            Localized("label_offer_default_restaurant_type")
        }
        static var defaultFoodType: String {
            Localized("label_offer_default_food_type")
        }
    }
    
    struct OfferLabels {
        static var navTitle: String {
            Localized("label_offers_nav_title")
        }
        static var findDiscounts: String {
            Localized("label_find_discounts")
        }
        static var btnCheckOffers: String {
            Localized("label_btn_check_offers")
        }
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
        static var food: String {
            String(format: Localized("label_menu_items_count"), 25)
        }
        static var beverages: String {
            String(format: Localized("label_menu_items_count"), 25)
        }
        static var desserts: String {
            String(format: Localized("label_menu_items_count"), 25)
        }
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
        static let cartAnimation = "Add to cart" // Cart empty animation
        
        static var cartEmptyMessage: String {
            Localized("label_empty_cart_message")
        }
        
        static var wishlistEmptyMessage: String {
            Localized("label_empty_wishlist_message")
        }
        
        static func noItemsFound(for category: String) -> String {
            switch category.lowercased() {
            case "food":
                return Main.MenuLabels.noFoodResults
            case "beverages":
                return Main.MenuLabels.noBeveragesResults
            case "desserts":
                return Main.MenuLabels.noDessertsResults
            default:
                return Localized("label_empty_no_items_found")
            }
        }
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
        
        static var lblChooseSavedAddress: String {
            Localized("lbl_choose_a_saved_address")
        }
        // TextFields
        static var txtSearchPlaceholder: String {
            Localized("txt_search_placeholder")
        }
    }
    
    // MARK: - New Password Screen
    // Titles, messages, and icons used in new password screen
    struct NewPassword {
        
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
        
        // MARK: - Labels / Placeholders
        static var navTitle: String { Localized("lbl_newpassword_nav_title") }
        static var title: String { Localized("lbl_newpassword_title") }
        static var subtitle: String { Localized("lbl_newpassword_subtitle") }
        static var newPasswordPlaceholder: String { Localized("txt_newpassword_placeholder") }
        static var confirmPasswordPlaceholder: String { Localized("txt_confirm_password_placeholder") }
        static var btnSubmit: String { Localized("btn_submit_newpassword") }
        
        // MARK: - Alerts / Validation
        static var alertPasswordMissing: String { Localized("alert_password_missing") }
        static var validationPasswordMissing: String { Localized("validation_password_missing") }
        static var alertConfirmPasswordMissing: String { Localized("alert_confirm_password_missing") }
        static var validationConfirmPasswordMissing: String { Localized("validation_confirm_password_missing") }
        static var alertPasswordMismatch: String { Localized("alert_password_mismatch") }
        static var validationPasswordMismatch: String { Localized("validation_password_mismatch") }
        static var alertProfileUpdateFailed: String { Localized("alert_profile_update_failed") }
        static var alertError: String { Localized("alert_error") }
    }
    
    struct model {
        static let food = "Food Model"
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
        
        // MARK: - Titles
        static var findFoodTitle: String { Localized("feature_find_food_title") }
        static var fastDeliveryTitle: String { Localized("feature_fast_delivery_title") }
        static var liveTrackingTitle: String { Localized("feature_live_tracking_title") }
        
        // MARK: - Subtitles
        static var findFoodSubTitle: String { Localized("feature_find_food_subtitle") }
        static var fastDeliverySubTitle: String { Localized("feature_fast_delivery_subtitle") }
        static var liveTrackingSubTitle: String { Localized("feature_live_tracking_subtitle") }
        
        // MARK: - Buttons
        static var next: String { Localized("label_next") }
        static var done: String { Localized("label_done") }
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
    struct AboutUsModelKeys {
        static var text1: String { Localized("label_aboutus_text_1") }
        static var text2: String { Localized("label_aboutus_text_2") }
        static var text3: String { Localized("label_aboutus_text_3") }
        static var text4: String { Localized("label_aboutus_text_4") }
        static var text5: String { Localized("label_aboutus_text_5") }
        static var text6: String { Localized("label_aboutus_text_6") }
        static var text7: String { Localized("label_aboutus_text_7") }
    }
    
    // MARK: - Inbox Model
    struct inboxModel {
        static var promotions: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_promotions_title"),
                Localized("label_inbox_promotions_date"),
                Localized("label_inbox_promotions_desc")
            )
        }
        static var orderUpdate: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_orderupdate_title"),
                Localized("label_inbox_orderupdate_date"),
                Localized("label_inbox_orderupdate_desc")
            )
        }
        static var deliveryReminders: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_deliveryreminders_title"),
                Localized("label_inbox_deliveryreminders_date"),
                Localized("label_inbox_deliveryreminders_desc")
            )
        }
        static var welcome: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_welcome_title"),
                Localized("label_inbox_welcome_date"),
                Localized("label_inbox_welcome_desc")
            )
        }
        static var experience: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_experience_title"),
                Localized("label_inbox_experience_date"),
                Localized("label_inbox_experience_desc")
            )
        }
        static var flashSale: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_flashsale_title"),
                Localized("label_inbox_flashsale_date"),
                Localized("label_inbox_flashsale_desc")
            )
        }
        static var referEarn: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_referearn_title"),
                Localized("label_inbox_referearn_date"),
                Localized("label_inbox_referearn_desc")
            )
        }
        static var weekendSpecial: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_weekendspecial_title"),
                Localized("label_inbox_weekendspecial_date"),
                Localized("label_inbox_weekendspecial_desc")
            )
        }
        static var tips: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_tips_title"),
                Localized("label_inbox_tips_date"),
                Localized("label_inbox_tips_desc")
            )
        }
        static var orderCancel: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_ordercancel_title"),
                Localized("label_inbox_ordercancel_date"),
                Localized("label_inbox_ordercancel_desc")
            )
        }
        static var loyaltyProgram: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_loyaltyprogram_title"),
                Localized("label_inbox_loyaltyprogram_date"),
                Localized("label_inbox_loyaltyprogram_desc")
            )
        }
        static var securityUpdate: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_securityupdate_title"),
                Localized("label_inbox_securityupdate_date"),
                Localized("label_inbox_securityupdate_desc")
            )
        }
        static var accountVerified: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_accountverified_title"),
                Localized("label_inbox_accountverified_date"),
                Localized("label_inbox_accountverified_desc")
            )
        }
        static var limitedDeal: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_limiteddeal_title"),
                Localized("label_inbox_limiteddeal_date"),
                Localized("label_inbox_limiteddeal_desc")
            )
        }
        static var newRestaurants: (title: String, date: String, desc: String) {
            return (
                Localized("label_inbox_newrestaurants_title"),
                Localized("label_inbox_newrestaurants_date"),
                Localized("label_inbox_newrestaurants_desc")
            )
        }
    }
    
    // MARK: - Notification Model
    struct notificationModel {
        static var orderPlaced: (msg: String, time: String) {
            return (
                Localized("label_notifications_orderplaced_msg"),
                Localized("label_notifications_orderplaced_time")
            )
        }
        static var paymentConfirmed: (msg: String, time: String) {
            return (
                Localized("label_notifications_paymentconfirmed_msg"),
                Localized("label_notifications_paymentconfirmed_time")
            )
        }
        static var foodPrepared: (msg: String, time: String) {
            return (
                Localized("label_notifications_foodprepared_msg"),
                Localized("label_notifications_foodprepared_time")
            )
        }
        static var agentAssigned: (msg: String, time: String) {
            return (
                Localized("label_notifications_agentassigned_msg"),
                Localized("label_notifications_agentassigned_time")
            )
        }
        static var orderOnWay: (msg: String, time: String) {
            return (
                Localized("label_notifications_orderonway_msg"),
                Localized("label_notifications_orderonway_time")
            )
        }
        static var discount: (msg: String, time: String) {
            return (
                Localized("label_notifications_discount_msg"),
                Localized("label_notifications_discount_time")
            )
        }
        static var appUpdate: (msg: String, time: String) {
            return (
                Localized("label_notifications_appupdate_msg"),
                Localized("label_notifications_appupdate_time")
            )
        }
        static var referFriend: (msg: String, time: String) {
            return (
                Localized("label_notifications_referfriend_msg"),
                Localized("label_notifications_referfriend_time")
            )
        }
        static var limitedDeal: (msg: String, time: String) {
            return (
                Localized("label_notifications_limiteddeal_msg"),
                Localized("label_notifications_limiteddeal_time")
            )
        }
        static var deliveryDone: (msg: String, time: String) {
            return (
                Localized("label_notifications_deliverydone_msg"),
                Localized("label_notifications_deliverydone_time")
            )
        }
        static var rateMeal: (msg: String, time: String) {
            return (
                Localized("label_notifications_ratemeal_msg"),
                Localized("label_notifications_ratemeal_time")
            )
        }
        static var weekendOffer: (msg: String, time: String) {
            return (
                Localized("label_notifications_weekendoffer_msg"),
                Localized("label_notifications_weekendoffer_time")
            )
        }
        static var freeDelivery: (msg: String, time: String) {
            return (
                Localized("label_notifications_freedelivery_msg"),
                Localized("label_notifications_freedelivery_time")
            )
        }
        static var thanks: (msg: String, time: String) {
            return (
                Localized("label_notifications_thanks_msg"),
                Localized("label_notifications_thanks_time")
            )
        }
        static var newRestaurants: (msg: String, time: String) {
            return (
                Localized("label_notifications_newrestaurants_msg"),
                Localized("label_notifications_newrestaurants_time")
            )
        }
    }
    
    struct PaymentLabels {
        
        // MARK: - Navigation Title
        static var paymentNavTitle: String { Localized("label_payment_nav_title") }
        
        static var expiry: String { Localized("label_expiry") }
        static var addCreditDebitCard: String { Localized("label_add_credit_debit_card") }
        static var customizePaymentMethod: String { Localized("label_customize_payment_method") }
        static var youCanRemoveThisCard: String { Localized("label_you_can_remove_this_card") }
        static var cashOnDelivery: String { Localized("label_cash_on_delivery") }
        static var otherPaymentMethods: String { Localized("label_other_methods") }
        
        // MARK: - Buttons
        static var addNewCard: String { Localized("label_add_new_card") }
        static var addCard: String { Localized("label_add_card") }
        static var closeAddCardView: String { Localized("label_close_add_card_view") }
        
        // MARK: - TextFields / Placeholders
        static var firstName: String { Localized("label_first_name") }
        static var lastName: String { Localized("label_last_name") }
        static var cardNumber: String { Localized("label_card_number") }
        static var expiryMonth: String { Localized("label_expiry_month") }
        static var expiryYear: String { Localized("label_expiry_year") }
        static var securityCode: String { Localized("label_security_code") }
        
        // MARK: - Alerts / Messages
        static var invalidInput: String { Localized("label_alert_invalid_input") }
        static var userNotFound: String { Localized("label_alert_user_not_found") }
        static var cardAlreadySaved: String { Localized("label_alert_card_already_saved") }
        
        // MARK: - Empty State
        static var noSavedCards: String { Localized("label_no_saved_cards") }
        
        // MARK: - Switch / Other UI
        static var removeCardSwitch: String { Localized("label_remove_card_switch") }
        
        // MARK: - Common Buttons
        static var ok: String { Localized("label_ok") }
        static var next: String { Localized("label_next") }
        static var done: String { Localized("label_done") }
        static var selectLocation: String { Localized("label_select_location") }
        static var unknown: String { Localized("label_unknown") }
    }
    
    struct WishlistLabels {
        static var wishlistEmptyMessage: String {
            Localized("label_wishlist_empty_message")
        }
        static var wishlistAddItems: String {
            Localized("label_wishlist_add_items")
        }
    }
    
    struct MenuLabels {
        static var navTitle: String {
            Localized("label_menu_nav_title")
        }
        
        static var searchPlaceholder: String {
            Localized("label_menu_search_placeholder")
        }
        static var searchFoodPlaceholder: String {
            Localized("label_menu_search_food_placeholder")
        }
        static var searchBeveragesPlaceholder: String {
            Localized("label_menu_search_beverages_placeholder")
        }
        static var searchDessertsPlaceholder: String {
            Localized("label_menu_search_desserts_placeholder")
        }
        
        static var noResults: String {
            Localized("label_menu_no_results")
        }
        static var noFoodResults: String {
            Localized("label_menu_no_food_results")
        }
        static var noBeveragesResults: String {
            Localized("label_menu_no_beverages_results")
        }
        static var noDessertsResults: String {
            Localized("label_menu_no_desserts_results")
        }
        
        static var categoryFood: String {
            Localized("label_menu_category_food")
        }
        static var categoryBeverages: String {
            Localized("label_menu_category_beverages")
        }
        static var categoryDesserts: String {
            Localized("label_menu_category_desserts")
        }
    }
    
    struct CartPage {
        static var navTitle: String {
            Localized("label_cart_nav_title")
        }
        static var emptyMessage: String {
            Localized("label_cart_empty_message")
        }
        static var emptyTitle: String {
            Localized("label_cart_empty_title")
        }
        static var placeOrderButton: String {
            Localized("label_cart_place_order_btn")
        }
        static var orderPlacedTitle: String {
            Localized("label_cart_order_placed_title")
        }
        static var orderPlacedMessage: String {
            Localized("label_cart_order_placed_message")
        }
        static var orderErrorTitle: String {
            Localized("label_cart_order_error_title")
        }
        static var orderErrorMessage: String {
            Localized("label_cart_order_error_message")
        }
        static var qty: String {
            Localized("label_cart_qty")
        }
    }
    
    struct OrderListPage {
        static var navTitle: String {
            Localized("label_order_list_nav_title")
        }
        static var orderNoPrefix: String {
            Localized("label_order_list_order_no_prefix")
        }
        static var currencySymbol: String {
            Localized("label_order_list_currency_symbol")
        }
        static var noOrdersMessage: String {
            Localized("label_order_list_no_orders")
        }
    }
}

func Localized(_ key: String) -> String {
    return NSLocalizedString(
        key,
        tableName: nil,
        bundle: LocalizationManager.shared.bundle,
        value: "",
        comment: ""
    )
}

