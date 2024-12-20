import 'package:flutter/material.dart';

class SubCategoryCard extends StatelessWidget {
  final String subCategoryId;
  final String subCategoryName;
  final VoidCallback onSubCategoryClicked;

  const SubCategoryCard({
    super.key,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.onSubCategoryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSubCategoryClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subcategory Name
            Text(
              subCategoryName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(width: 8.0),

            const Icon(
              Icons.arrow_forward_ios,
              size: 12.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}