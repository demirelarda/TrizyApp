import 'package:flutter/material.dart';
import 'cart_product_controller_items.dart';

class CartItemCard extends StatelessWidget {
  final String productImageUrl;
  final String productTitle;
  final String productPrice;
  final int quantity;
  final VoidCallback onMinusClicked;
  final VoidCallback onPlusClicked;
  final VoidCallback onRemoveClicked;
  final bool isMinusLoading;
  final bool isPlusLoading;
  final bool isRemoveLoading;

  const CartItemCard({
    super.key,
    required this.productImageUrl,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.onMinusClicked,
    required this.onPlusClicked,
    required this.onRemoveClicked,
    this.isMinusLoading = false,
    this.isPlusLoading = false,
    this.isRemoveLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Image.network(
              productImageUrl,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),

          // Product Details and Controller
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  productTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Product Price
                Text(
                  productPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),

                CartProductControllerItems(
                  quantity: quantity,
                  onMinusClicked: onMinusClicked,
                  onPlusClicked: onPlusClicked,
                  onRemoveClicked: onRemoveClicked,
                  isMinusLoading: isMinusLoading,
                  isPlusLoading: isPlusLoading,
                  isRemoveLoading: isRemoveLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}