import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductRatingStars extends StatelessWidget {
  final double rating;

  const ProductRatingStars({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: primaryLightColor,
      ),
      unratedColor: Colors.grey,
      itemCount: 5,
      itemSize: 24.0,
      direction: Axis.horizontal,
    );
  }
}