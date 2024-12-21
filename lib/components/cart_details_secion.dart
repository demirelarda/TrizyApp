import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class CartDetailsSection extends StatelessWidget {
  final double subTotalPrice;
  final double deliveryFee;
  final VoidCallback onCheckOutClicked;

  const CartDetailsSection({
    super.key,
    required this.subTotalPrice,
    required this.deliveryFee,
    required this.onCheckOutClicked,
  });

  @override
  Widget build(BuildContext context) {
    final totalAmount = subTotalPrice + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // subtotal
          Row(
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              Text(
                "\$${subTotalPrice.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Delivery fee
          Row(
            children: [
              const Text(
                "Delivery Fee",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              Text(
                deliveryFee == 0 ? "Free" : "\$${deliveryFee.toStringAsFixed(2)}",
                style: TextStyle(
                  color: deliveryFee == 0 ? Theme.of(context).primaryColorLight : Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Grand total section
          Row(
            children: [
              const Text(
                "Grand Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                "\$${totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // CheckOut Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckOutClicked,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}