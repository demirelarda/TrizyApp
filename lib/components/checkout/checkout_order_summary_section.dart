import 'package:flutter/material.dart';
import 'package:trizy_app/components/checkout_items_list.dart';
import '../../models/cart/cart.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';

class OrderSummarySection extends StatelessWidget {
  final Cart cart;

  const OrderSummarySection({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: primaryLightColor,
              size: 32,
            ),
            SizedBox(width: 12),
            Text("Order Summary", style: AppTextStyles.headline18),
          ],
        ),
        const SizedBox(height: 16),
        CheckoutItemsList(cart: cart, cargoFee: 35.0),
      ],
    );
  }
}