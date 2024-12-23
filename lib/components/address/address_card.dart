import 'package:flutter/material.dart';
import 'package:trizy_app/models/address/address.dart';
import 'package:trizy_app/theme/colors.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onEditClicked;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEditClicked,
  });

  @override
  Widget build(BuildContext context) {
    IconData addressIcon;
    switch (address.addressType) {
      case 'home':
        addressIcon = Icons.home;
        break;
      case 'work':
        addressIcon = Icons.work;
        break;
      default:
        addressIcon = Icons.help_outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(
              addressIcon,
              color: primaryLightColor,
              size: 36,
            ),
          ),

          // Details section
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address title (using city for now)
                  Text(
                    address.city,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Address details
                  Flexible(
                    child: Text(
                      formatAddress(address.address),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (address.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Text(
                        'Default',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Edit button
          GestureDetector(
            onTap: onEditClicked,
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatAddress(String address) {
    if (address.length > 40) {
      return '${address.substring(0, 40)}...';
    }
    return address;
  }
}