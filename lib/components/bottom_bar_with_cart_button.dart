import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trizy_app/theme/colors.dart';

class BottomBarWithCartButton extends StatelessWidget {
  final double price;
  final double? salePrice;
  final double cargoWeight;
  final VoidCallback onAddToCart;
  final bool isAddToCartActive;
  final bool isLoading;
  final String buttonText;

  const BottomBarWithCartButton({
    Key? key,
    required this.price,
    this.salePrice,
    required this.cargoWeight,
    required this.onAddToCart,
    this.isAddToCartActive = true,
    this.isLoading = false,
    this.buttonText = "Add to Cart",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String deliveryText = _getDeliveryText(cargoWeight);

    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 12.0,
          left: 16.0,
          right: 16.0,
          bottom: 12.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Price & Delivery Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Price widget
                  if (salePrice != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Sale Price
                        Text(
                          "\$${salePrice!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryLightColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "\$${price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      "\$${price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 6),
                  // Delivery time
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: Colors.green.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          deliveryText,
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add to Cart Button
            ElevatedButton(
              onPressed: isAddToCartActive && !isLoading ? onAddToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isAddToCartActive ? primaryLightColor : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2.0,
                ),
              )
                  : Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDeliveryText(double cargoWeight) {
    if (cargoWeight <= 2) {
      return "Next Day Delivery!";
    } else if (cargoWeight > 30) {
      final deliveryDate = _getDeliveryDateExcludingWeekends(4);
      return "Delivers on $deliveryDate";
    } else {
      final deliveryDate = _getDeliveryDateExcludingWeekends(2);
      return "Delivers on $deliveryDate";
    }
  }

  String _getDeliveryDateExcludingWeekends(int daysToAdd) {
    DateTime current = DateTime.now();
    int addedDays = 0;

    while (addedDays < daysToAdd) {
      current = current.add(const Duration(days: 1));
      if (current.weekday != 6 && current.weekday != 7) {
        addedDays++;
      }
    }
    return DateFormat("MMM d, yyyy").format(current);
  }
}