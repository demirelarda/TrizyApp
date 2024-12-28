import 'package:go_router/go_router.dart';
import 'package:trizy_app/views/address/my_addresses_page.dart';
import 'package:trizy_app/views/checkout/checkout_page.dart';
import 'package:trizy_app/views/main/main_page.dart';
import 'package:trizy_app/views/main/pages/cart_page.dart';
import 'package:trizy_app/views/checkout/payment_successful_page.dart';
import 'package:trizy_app/views/orders/my_orders_page.dart';
import 'package:trizy_app/views/product/product_details_page.dart';
import 'package:trizy_app/views/search/search_page.dart';
import 'package:trizy_app/views/splash/splash_page.dart';
import 'package:trizy_app/views/subscription/my_subscription_page.dart';
import 'package:trizy_app/views/subscription/subscription_promotion_page.dart';
import 'package:trizy_app/views/subscription/subscription_successful_page.dart';
import 'package:trizy_app/views/subscription/subscription_view.dart';
import '../models/address/address.dart';
import '../views/address/address_form_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/onboarding/onboarding_page.dart';
import '../views/product/product_list_page.dart';
import '../views/trial/trial_product_list_page.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
    initialLocation: '/mainPage',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: 'mainPage',
        path: '/mainPage',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        name: 'search',
        path: '/search',
        builder: (context, state) => const SearchPage(isTrial: false),
      ),
      GoRoute(
        name: 'searchTrial',
        path: '/searchTrial',
        builder: (context, state) => const SearchPage(isTrial: true),
      ),
      GoRoute(
        name: 'productListPageWithCategory',
        path: '/productListPage/:categoryId/:categoryName',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId'];
          final categoryName = state.pathParameters['categoryName'];
          return ProductListPage(categoryId: categoryId, categoryName: categoryName, query: null);
        },
      ),
      GoRoute(
        name: 'productListPageWithQuery',
        path: '/productListPage',
        builder: (context, state) {
          final query = state.uri.queryParameters['query'];
          return ProductListPage(categoryId: null, categoryName: null, query: query);
        },
      ),
      GoRoute(
        name: 'productDetailsPage',
        path: '/productDetailsPage/:productId',
        builder: (context, state) {
          final productId = state.pathParameters['productId'];
          return ProductDetailsPage(productId: productId!);
        },
      ),
      GoRoute( //TODO: MAKE CART PAGE COMPATIBLE WITHOUT BOTTOM BAR OR DIRECTLY GO TO MAIN PAGE AND SELECT CART PAGE FROM BOTTOM BAR.
        name: 'cart',
        path: '/cart',
        builder: (context, state) {
          return const CartPage();
        },
      ),
      GoRoute(
        name: 'checkoutPage',
        path: '/checkoutPage',
        builder: (context, state) {
          return const CheckoutPage();
        },
      ),
      GoRoute(
        name: 'myAddresses',
        path: '/myAddresses',
        builder: (context, state) {
          return const MyAddressesPage();
        },
      ),

      GoRoute(
        name: 'addressForm',
        path: '/addressForm',
        builder: (context, state) {
          final address = state.extra as Address?;
          return AddressFormPage(address: address);
        },
      ),


      GoRoute(
        name: 'paymentSuccessful',
        path: '/paymentSuccessful/:paymentIntentId',
        builder: (context, state) {
          final paymentIntentId = state.pathParameters['paymentIntentId']!;
          return PaymentSuccessfulPage(paymentIntentId: paymentIntentId);
        },
      ),

      GoRoute(
        name: 'myOrders',
        path: '/myOrders/:fromAccount',
        builder: (context, state) {
          final fromAccount = state.pathParameters['fromAccount']!;
          var fromAccountBool = false;
          if(fromAccount == "1"){
            fromAccountBool = true;
          }
          return MyOrdersPage(fromAccount: fromAccountBool);
        },
      ),


      GoRoute(
        name: 'mySubscription',
        path: '/mySubscription',
        builder: (context, state) {
          return const MySubscriptionPage();
        },
      ),


      GoRoute(
        name: 'subscriptionPromotionPage',
        path: '/subscriptionPromotionPage',
        builder: (context, state) {
          return const SubscriptionPromotionPage();
        },
      ),


      GoRoute(
        name: 'subscriptionView',
        path: '/subscriptionView',
        builder: (context, state) {
          return const SubscriptionView();
        },
      ),

      GoRoute(
        name: 'subscriptionSuccessful',
        path: '/subscriptionSuccessful',
        builder: (context, state) {
          return const SubscriptionSuccessfulPage();
        },
      ),

      GoRoute(
        name: 'trialProductListPageWithCategory',
        path: '/trialProductListPage/:categoryId/:categoryName',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId'];
          final categoryName = state.pathParameters['categoryName'];
          return TrialProductListPage(
            categoryId: categoryId,
            categoryName: categoryName,
            query: null,
          );
        },
      ),
      GoRoute(
        name: 'trialProductListPageWithQuery',
        path: '/trialProductListPage',
        builder: (context, state) {
          final query = state.uri.queryParameters['query'];
          return TrialProductListPage(
            categoryId: null,
            categoryName: null,
            query: query,
          );
        },
      ),



    ],
  );
}