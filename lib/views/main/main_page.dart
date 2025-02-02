import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/utils/auth_check.dart';
import 'package:trizy_app/views/main/pages/account_page.dart';
import 'package:trizy_app/views/main/pages/cart_page.dart';
import 'package:trizy_app/views/main/pages/home/home_page.dart';
import 'package:trizy_app/views/main/pages/trial_page.dart';
import '../../theme/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TrialPage(),
    const CartPage(fromProductFeed: false),
    const AccountPage(),
  ];

  void _onTabTapped(int index) async {
    bool isUserAuthenticated = await isAuthenticated();
    if (!mounted) return;
    if (!isUserAuthenticated && (index == 1 || index == 2 || index == 3)) {
      context.goNamed("signup");
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: primaryLightColor,
        unselectedItemColor: gray,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Trial",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}