import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductCardButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isActive;
  final VoidCallback? onPressed;

  const ProductCardButton({
    super.key,
    required this.text,
    this.backgroundColor = primaryLightColor,
    this.textColor = Colors.white,
    this.isActive = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
    );
  }
}