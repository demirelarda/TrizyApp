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
  static const String searchProducts = 'api/products/search/{query}';

}