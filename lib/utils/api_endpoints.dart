class ApiEndpoints {

  static const String baseDevAndroidUrl = 'http://10.0.2.2:5001';
  static const String baseDeviOSUrl = 'http://localhost:5001';
  static const String baseDevWebUrl = 'http://localhost:5001';

  // AUTH
  static const String register = 'api/register';
  static const String login = 'api/login';

  // DEALS
  static const String getDeals = 'api/deals/get-deals';

  // CATEGORIES
  static const String getRootCategories = 'api/categories/get-root-categories';
  static const String getChildCategories = 'api/categories/get-child-categories/{rootCategoryId}';

  // PRODUCTS
  static const String getProductsByCategory = 'api/products/category/{categoryId}';
  static const String searchProducts = 'api/products/search/';
  static const String getSingleProduct = 'api/products/{productId}';

  // CART
  static const String getUserCart = 'api/carts/get-cart';
  static const String addItemToCart = 'api/carts/add-item';
  static const String deleteItemFromCart = 'api/carts/delete-item/{productId}';
  static const String decrementQuantity = 'api/carts/decrement-quantity';
  static const String addItemOnFeed = 'api/carts/add-item-on-feed';


  // ADDRESS
  static const String createAddress = "api/address/create-user-address";
  static const String updateAddress = "api/address/update-address/{addressId}";
  static const String deleteAddress = "api/address/delete-address/{addressId}";
  static const String getUserAddresses = "api/address/get-all-addresses";
  static const String getDefaultAddress = "api/address/get-default-address";

}