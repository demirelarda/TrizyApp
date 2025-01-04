import 'package:flutter/material.dart';

class ProductListActionButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final int? filterCount;
  final VoidCallback onTap;

  const ProductListActionButton({
    super.key,
    required this.icon,
    this.text,
    this.filterCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFilters = filterCount != null && filterCount! > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: hasFilters ? Colors.green : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: hasFilters ? Colors.green : Colors.black,
              size: 16.0,
            ),

            const SizedBox(width: 8.0),

            Text(
              filterCount != null
                  ? filterCount.toString()
                  : text ?? "",
              style: TextStyle(
                fontSize: 14,
                color: hasFilters ? Colors.green : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}