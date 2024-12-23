import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_state.dart';
import 'package:trizy_app/components/address/address_card.dart';
import 'package:trizy_app/components/address/add_address_button.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';
import '../../models/address/address.dart';

class CheckoutAddressSection extends StatelessWidget {
  final Function(Address?) onEditAddress;

  const CheckoutAddressSection({super.key, required this.onEditAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              color: primaryLightColor,
              size: 32,
            ),
            SizedBox(width: 12),
            Text("Shipping Details", style: AppTextStyles.headline18),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 16),

        // Address Content
        BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  "Error loading default address: ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.isSuccess && state.address != null) {
              final defaultAddress = state.address!;
              return AddressCard(
                address: defaultAddress,
                onEditClicked: () => onEditAddress(defaultAddress),
              );
            }

            // No default address case
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "You have no default address.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                AddAddressButton(
                  onAddAddressClicked: () => onEditAddress(null),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}