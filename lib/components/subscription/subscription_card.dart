import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/models/subscription/subscription.dart';
import 'package:trizy_app/theme/colors.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onCancelSubscriptionClicked;
  final VoidCallback onRenewSubscriptionClicked;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onCancelSubscriptionClicked,
    required this.onRenewSubscriptionClicked,
  });

  @override
  Widget build(BuildContext context) {
    final expiresAt = subscription.expiresAt != null
        ? DateFormat('dd-MM-yyyy').format(subscription.expiresAt!)
        : null;

    String statusLabel;
    Color statusColor;

    switch (subscription.status.toLowerCase()) {
      case 'active':
        statusLabel = 'Active';
        statusColor = Colors.green;
        break;
      case 'canceled':
        statusLabel = 'Cancelled';
        statusColor = Colors.grey;
        break;
      case 'past_due':
      default:
        statusLabel = 'Past Due';
        statusColor = Colors.red;
        break;
    }

    return Card(
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/trizyprologo.png',
              width: 80,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),

            const Text(
              "Subscription Status:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusLabel,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (subscription.status.toLowerCase() == 'active') ...[
              const SizedBox(height: 16),

              const Text(
                "Renews At:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Text(
                expiresAt ?? 'N/A',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],

            const SizedBox(height: 16),

            if (subscription.status.toLowerCase() == 'active')
              Center(
                child: TextButton(
                  onPressed: onCancelSubscriptionClicked,
                  child: const Text(
                    "Cancel Subscription",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              CustomButton(
                text: "Renew Subscription",
                textColor: white,
                color: primaryLightColor,
                onClick: onRenewSubscriptionClicked,
              ),
          ],
        ),
      ),
    );
  }
}