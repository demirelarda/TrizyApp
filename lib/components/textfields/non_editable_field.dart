import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class NonEditableField extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final VoidCallback? onTap;

  const NonEditableField({
    super.key,
    required this.placeholder,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: gray,
              size: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                placeholder,
                style: const TextStyle(
                  color: gray,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}