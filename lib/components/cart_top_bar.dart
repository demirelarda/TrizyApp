import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/theme/colors.dart';

class CartTopBar extends StatelessWidget implements PreferredSizeWidget {
  final double subtotalAmount;
  final int itemCount;
  final VoidCallback onMenuClicked;
  final bool showBackButton;

  const CartTopBar({
    super.key,
    required this.subtotalAmount,
    required this.itemCount,
    required this.onMenuClicked,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Subtotal and Item Count
          Row(
            children: [
              Text(
                "\$${subtotalAmount.toStringAsFixed(0)} subtotal",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "•",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "$itemCount items",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
      leading: showBackButton
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          context.pop("back");
        },
      )
          : null,
      actions: [
        // Menu
        GestureDetector(
          onTap: onMenuClicked,
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              color: primaryLightColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}