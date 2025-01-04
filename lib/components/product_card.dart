import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
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
  final bool isLoading;
  final bool productInCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onLikeTap,
    required this.onProductClicked,
    this.isLiked = false,
    this.isLoading = false,
    this.productInCart = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onProductClicked(product.id),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0), // Reduced padding
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
              // Product Image (Height fills available card height)
              Container(
                color: Colors.white, // outside image background
                height: 160, // Ensure height is fixed
                width: 140, // Fixed width
                child: CachedNetworkImage(
                  imageUrl: product.imageURLs.isNotEmpty
                      ? product.imageURLs.first
                      : "",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusts alignment
                  children: [
                    Column(
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

                        // Reason Container
                        if (product.reason != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [Colors.blue, primaryLightColor],
                                ),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.reason!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
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

                        // Rating, Review Count, Stock Status (all in one row)
                        Row(
                          children: [
                            ProductRatingStars(rating: product.averageRating),
                            const SizedBox(width: 8),
                            Text(
                              "${product.reviewCount}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              product.stockCount > 0
                                  ? "In stock"
                                  : "Out of stock",
                              style: TextStyle(
                                fontSize: 14,
                                color: product.stockCount > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Bigger "Add to Cart" button below rating, with heart icon on the right
                    Row(
                      children: [
                        Expanded(
                          child: ProductCardButton(
                            text: productInCart ? "Go to cart" : "Add to cart",
                            backgroundColor: product.stockCount > 0
                                ? primaryLightColor
                                : Colors.grey,
                            textColor: Colors.white,
                            isActive: product.stockCount > 0,
                            isLoading: isLoading,
                            onPressed: product.stockCount > 0
                                ? productInCart
                                ? () {
                              // If product is already in the cart navigate to cart page
                              context.pushNamed("cart");
                            }
                                : onAddToCart
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
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
      ),
    );
  }
}