import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class TrialDetailsCard extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final int trialPeriod;

  const TrialDetailsCard({
    super.key,
    required this.productName,
    required this.productImageUrl,
    required this.trialPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryDate = DateTime.now().add(const Duration(days: 2));
    final returnDate = deliveryDate.add(Duration(days: trialPeriod));

    String formatDate(DateTime date) {
      return DateFormat('dd-MM-yyyy').format(date);
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
            child: CachedNetworkImage(
              imageUrl: productImageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            productName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trial Starts (Delivery Date)",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                formatDate(deliveryDate),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trial Ends (Return Date)",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                formatDate(returnDate),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}