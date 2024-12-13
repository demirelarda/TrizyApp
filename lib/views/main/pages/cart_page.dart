import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
              child: Column(
                children: [
                  Text("Cart Page"),
                ],
              )
          ),
          Spacer()
        ],
      ),
    );
  }
}
