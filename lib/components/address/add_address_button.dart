import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class AddAddressButton extends StatelessWidget {
  final VoidCallback onAddAddressClicked;

  const AddAddressButton({
    super.key,
    required this.onAddAddressClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onAddAddressClicked,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: primaryLightColor, width: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: primaryLightColor,
            ),
            SizedBox(width: 8),
            Text(
              "Add Address",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}