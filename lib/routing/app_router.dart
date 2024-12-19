import 'package:go_router/go_router.dart';
import 'package:trizy_app/views/main/main_page.dart';
import 'package:trizy_app/views/search/search_page.dart';
import 'package:trizy_app/views/splash/splash_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/onboarding/onboarding_page.dart';
import '../views/product/product_list_page.dart';

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
        builder: (context, state) => const SearchPage(),
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
    ],
  );
}