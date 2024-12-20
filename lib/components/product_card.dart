import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product/product_model.dart';
import '../theme/colors.dart';
import 'buttons/heart_button.dart';
import 'buttons/product_card_button.dart';
import 'product_rating_stars.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onLikeTap;
  final ValueChanged<String> onProductClicked;
  final bool isLiked;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onLikeTap,
    required this.onProductClicked,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onProductClicked(product.id),
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
                imageUrl: product.imageURLs.isNotEmpty ? product.imageURLs.first : "",
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
                  // Price
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Product Rating and Review Count
                  const Row(
                    children: [
                      ProductRatingStars(rating: 3.5),
                      SizedBox(width: 8),
                      Text(
                        "120",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Stock Status
                  Text(
                    product.stockCount > 0 ? "In stock" : "Out of stock",
                    style: TextStyle(
                      fontSize: 14,
                      color: product.stockCount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Add to Cart Button and Heart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductCardButton(
                        text: "Add to cart",
                        backgroundColor:
                        product.stockCount > 0 ? primaryLightColor : Colors.grey,
                        textColor: Colors.white,
                        isActive: product.stockCount > 0,
                        onPressed: product.stockCount > 0 ? onAddToCart : null,
                      ),
                      HeartButton(
                        isLiked: isLiked,
                        onLikeTap: onLikeTap,
                      ),
                    ],
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