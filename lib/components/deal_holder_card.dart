import 'package:flutter/material.dart';

class DealHolderCard extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;
  final BorderRadius borderRadius;

  const DealHolderCard({
    super.key,
    required this.imageUrl,
    required this.aspectRatio,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.error, color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}