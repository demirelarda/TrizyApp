import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/address/address_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/address/add_address_button.dart';
import 'package:trizy_app/components/address/address_card.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../models/address/address.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {

  Future<void> _navigateToAddressFormPage({
    required BuildContext blocContext,
    Address? address,
    required bool isEditing,
  }) async {
    final result = isEditing
        ? await blocContext.push('/addressForm', extra: address)
        : await blocContext.push('/addressForm');

    // Check the result if "success", trigger fetching again
    if (result == "success" && mounted) {
      blocContext.read<AddressBloc>().add(const GetAddressesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc()..add(const GetAddressesEvent()),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () => context.pop(),
          title: "My Addresses",
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  "Error: ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.isSuccess) {
              final addresses = state.addresses ?? [];

              // No addresses = show message + Add button
              if (addresses.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "You have no addresses yet.",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),
                      SafeArea(
                        top: false,
                        child: AddAddressButton(
                          onAddAddressClicked: () {
                            _navigateToAddressFormPage(isEditing: false, blocContext: context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Show list of addresses + Add button
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return AddressCard(
                            address: address,
                            onEditClicked: () {
                              _navigateToAddressFormPage(
                                address: address,
                                isEditing: true,
                                blocContext: context
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: AddAddressButton(
                        onAddAddressClicked: () {
                          _navigateToAddressFormPage(isEditing: false, blocContext: context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            // for unexpected state
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}