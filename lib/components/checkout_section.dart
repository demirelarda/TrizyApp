import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class CheckoutSection extends StatelessWidget {
  final String title;
  final String content;
  final String? actionText;
  final VoidCallback? onActionClick;

  const CheckoutSection({
    super.key,
    required this.title,
    required this.content,
    this.actionText,
    this.onActionClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title/action text row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            if (actionText != null)
              GestureDetector(
                onTap: onActionClick,
                child: Text(
                  actionText!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryLightColor,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Content Section
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}