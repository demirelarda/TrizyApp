import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';

class HomePageChipCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const HomePageChipCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: primaryLightColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: AppTextStyles.bodyText
            ),
          ],
        ),
      ),
    );
  }
}