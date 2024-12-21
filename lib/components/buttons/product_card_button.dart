import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductCardButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isActive;
  final bool isLoading;
  final VoidCallback? onPressed;

  const ProductCardButton({
    super.key,
    required this.text,
    this.backgroundColor = primaryLightColor,
    this.textColor = Colors.white,
    this.isActive = true,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive && !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: isLoading
          ? SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      )
          : Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
    );
  }
}