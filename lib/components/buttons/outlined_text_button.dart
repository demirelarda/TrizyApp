import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';

class OutlinedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const OutlinedTextButton({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryLightColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyles.bodyText
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: primaryLightColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}