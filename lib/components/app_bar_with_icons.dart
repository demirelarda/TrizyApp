import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'buttons/heart_button.dart';

class AppBarWithIcons extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackClicked;
  //final VoidCallback onHeartClicked;
  final VoidCallback onCartClicked;
  final bool isLiked;

  const AppBarWithIcons({
    super.key,
    required this.onBackClicked,
    //required this.onHeartClicked,
    required this.onCartClicked,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: gray),
        onPressed: onBackClicked,
      ),
      actions: [
        // Heart Icon
        /*
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: HeartButton(
            isLiked: isLiked,
            onLikeTap: onHeartClicked,
          ),
        ),
         */
        // Cart Icon
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: onCartClicked,
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
              size: 24,
            ),
          ),
        ),
      ],
      backgroundColor: white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}