import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class BottomBarWithCartButton extends StatelessWidget {
  final String price;
  final VoidCallback onAddToCart;
  final bool isAddToCartActive;

  const BottomBarWithCartButton({
    super.key,
    required this.price,
    required this.onAddToCart,
    this.isAddToCartActive = true,
  });
  // TODO: TAKE THE PRICE TO THE LEFT, PUT SOMETHING ABOUT CARGO BELOW IT LIKE FAST SHIPPING ETC. OR 2 DAYS Shipping etc.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5), // Top border
          ),
        ),
        padding: const EdgeInsets.only(
          top: 12.0,
          left: 16.0,
          right: 16.0,
          bottom: 12.0, // Additional bottom padding for spacing
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price
            const Spacer(),
            Text(
              "\$$price",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 10),

            // Add to Cart Button
            ElevatedButton(
              onPressed: isAddToCartActive ? onAddToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isAddToCartActive ? primaryLightColor : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}