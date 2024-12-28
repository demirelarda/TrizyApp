import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order/order.dart';

class OrderCard extends StatelessWidget {
  final OrderData order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd-MM-yyyy').format(order.createdAt);
    final statusColor = _getStatusColor(order.status);

    // show the image of first item's first image
    String firstImageUrl = '';
    if (order.items.isNotEmpty && order.items[0].imageURLs.isNotEmpty) {
      firstImageUrl = order.items[0].imageURLs[0];
    }

    // Show all product names separated with commas
    final productTitles = order.items.map((item) => item.title).join(', ');

    final deliveryAddress = order.deliveryAddress;
    final cityPlusPostal = '${deliveryAddress.city}, 12345'; // TODO: GET REAL POSTAL CODE, INCLUDE IT IN THE DELIVERY ADDRESS RESPONSE

    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Date + Status label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormatted,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Middle row = product image + product titles
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image preview
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Container(
                    color: Colors.white,
                    child: firstImageUrl.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        firstImageUrl,
                        fit: BoxFit.contain,
                      ),
                    )
                        : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // product names
                Expanded(
                  child: Text(
                    productTitles,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // for address preview using city + postal code
            Text(
              cityPlusPostal,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.grey;
      case 'shipping':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'returned':
        return Colors.grey.shade600;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}