import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';

class DeliveryDateSection extends StatelessWidget {
  const DeliveryDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryDate = DateTime.now().add(const Duration(days: 3));
    final formattedDate =
        "${deliveryDate.weekday == 4 ? "Thu" : deliveryDate.weekday}, ${deliveryDate.month}/${deliveryDate.day}/${deliveryDate.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: primaryLightColor,
              size: 28,
            ),
            SizedBox(width: 10),
            Text("Delivery Date", style: AppTextStyles.headline18),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 6),
        Text(
          "Arriving by $formattedDate",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}