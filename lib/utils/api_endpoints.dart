import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {


  static String baseDevAndroidUrl = prodUrl;
  static String baseDeviOSUrl = prodUrl;
  static String baseDevWebUrl = prodUrl;

  /*
  static const String baseDevAndroidUrl = 'http://10.0.2.2:5001';
  static const String baseDeviOSUrl = 'http://localhost:5001';
  static const String baseDevWebUrl = 'http://localhost:5001';

   */

  static String get prodUrl {
    if (dotenv.env['BASE_BACKEND_URL'] != null && dotenv.env['BASE_BACKEND_URL']!.isNotEmpty) {
      return dotenv.env['BASE_BACKEND_URL']!;
    }

    if (kIsWeb) {
      return 'http://localhost:5001';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:5001';
    } else if (Platform.isIOS) {
      return 'http://localhost:5001';
    } else {
      return '';
    }
  }

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


  // PAYMENT
  static const String createPaymentIntent = "api/payments/create-payment-intent";
  static const String checkOrderStatus = "api/payments/check-order-status";

  // ORDERS
  static const String getUserOrders = "api/orders/get-user-orders";

  // SUBSCRIPTIONS
  static const String createSubscription = "api/subscriptions/create";
  static const String getSubscriptionStatus = "api/subscriptions/status";
  static const String cancelSubscription = "api/subscriptions/cancel/{subscriptionId}";


  // TRIAL PRODUCTS
  static const String getLatestTrialProducts = "api/trialProducts/get-latest";
  static const String getTrialProductsByCategory = "api/trialProducts/category/{categoryId}";
  static const String searchTrialProducts = "api/trialProducts/search";
  static const String getSingleTrialProduct = "api/trialProducts/{trialProductId}";

  //TRIAL
  static const String createTrial = "api/trials/create-trial";
  static const String getActiveTrialDetails = "api/trials/active-trial-details";

  //REVIEWS
  static const String createReview = "api/reviews/create-review";
  static const String getProductReviews = "api/reviews/get-product-reviews/{productId}";
  static const String deleteReview = "api/reviews/delete-review/{reviewId}";
  static const String getReviewableProducts = "api/reviews/get-reviewable-products/{orderId}";




}