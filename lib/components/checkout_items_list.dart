import 'package:flutter/material.dart';
import '../../models/cart/cart.dart';

class CheckoutItemsList extends StatelessWidget {
  final Cart cart;
  final double cargoFee;

  const CheckoutItemsList({
    super.key,
    required this.cart,
    required this.cargoFee,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...cart.items.map((item) => _buildCartItem(item)).toList(),
        _buildCargoFee(),
        _buildTotalAmount(),
      ],
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "${item.quantity} x",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Text(
              "\$${item.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCargoFee() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cargo Fee",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                cargoFee == 0 ? "Free" : "\$${cargoFee.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: cargoFee == 0 ? FontWeight.bold : FontWeight.normal,
                  color: cargoFee == 0 ? Colors.green : Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount() {
    final double totalAmount = cart.items.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    ) + cargoFee;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$${totalAmount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}