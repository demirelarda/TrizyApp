import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/trialproduct/trial_products_response.dart';
import '../../theme/colors.dart';
import '../buttons/product_card_button.dart';

class TrialProductCard extends StatelessWidget {
  final TrialProduct trialProduct;
  final VoidCallback onTrialNowClicked;

  const TrialProductCard({
    super.key,
    required this.trialProduct,
    required this.onTrialNowClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTrialNowClicked,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              color: Colors.white, // outside image background
              child: CachedNetworkImage(
                imageUrl: trialProduct.imageURLs.isNotEmpty ? trialProduct.imageURLs.first : "",
                placeholder: (context, url) => const SizedBox(
                  height: 120,
                  width: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const SizedBox(
                  height: 120,
                  width: 120,
                  child: Icon(Icons.error),
                ),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    trialProduct.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Trial Period
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${trialProduct.trialPeriod} days",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Availability Status
                  Text(
                    trialProduct.availableCount > 0 ? "Available" : "Not Available",
                    style: TextStyle(
                      fontSize: 14,
                      color: trialProduct.availableCount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Trial Now Button
                  ProductCardButton(
                    text: "Trial Now",
                    backgroundColor: trialProduct.availableCount > 0
                        ? primaryLightColor
                        : Colors.grey,
                    textColor: Colors.white,
                    isActive: trialProduct.availableCount > 0,
                    onPressed: trialProduct.availableCount > 0 ? onTrialNowClicked : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}