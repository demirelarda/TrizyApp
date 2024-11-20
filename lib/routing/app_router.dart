import 'package:go_router/go_router.dart';
import 'package:trizy_app/views/splash/splash_page.dart';

import '../views/auth/login_page.dart';
import '../views/auth/signup_page.dart';
import '../views/onboarding/onboarding_page.dart';


class AppRouter {
  final GoRouter router;
  AppRouter() : router = GoRouter(
    initialLocation: '/',
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
          path:'/login',
          builder: (context, state) => const LoginPage()
      ),
      GoRoute(
          name: 'signup',
          path: '/signup',
          builder: (context, state) => const SignupPage()
      ),
    ],
  );
}