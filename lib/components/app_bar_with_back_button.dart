import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

import '../theme/text_styles.dart';

class AppBarWithBackButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackClicked;

  const AppBarWithBackButton({
    super.key,
    this.title = '',
    required this.onBackClicked,i
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: gray),
        onPressed: onBackClicked,
      ),
      title: title.isNotEmpty
          ? Text(
        title,
        style: AppTextStyles.headlineMedium.copyWith(color: primaryDarkColor),
      )
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}