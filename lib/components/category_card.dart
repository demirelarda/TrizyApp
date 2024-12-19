import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';
import '../models/category/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onCategoryClicked;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onCategoryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCategoryClicked,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: primaryLightColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText.copyWith(color: white)
          ),
        ),
      ),
    );
  }
}