import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/address/address_state.dart';
import 'package:trizy_app/bloc/trial/create/create_trial_bloc.dart';
import 'package:trizy_app/bloc/trial/create/create_trial_event.dart';
import 'package:trizy_app/bloc/trial/create/create_trial_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/checkout/checkout_address_section.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/trial/trial_details_card.dart';

class TrialDetailsPage extends StatefulWidget {
  final String trialProductId;
  final String trialProductName;
  final String trialProductImageUrl;
  final int trialPeriod;

  const TrialDetailsPage({
    super.key,
    required this.trialProductId,
    required this.trialProductName,
    required this.trialProductImageUrl,
    required this.trialPeriod,
  });

  @override
  State<TrialDetailsPage> createState() => _TrialDetailsPageState();
}

class _TrialDetailsPageState extends State<TrialDetailsPage> {
  late AddressBloc _addressBloc;
  late CreateTrialBloc _createTrialBloc;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _addressBloc = AddressBloc();
    _createTrialBloc = CreateTrialBloc();
    _fetchDefaultAddress();
  }

  @override
  void dispose() {
    _addressBloc.close();
    _createTrialBloc.close();
    super.dispose();
  }

  void _fetchDefaultAddress() {
    _addressBloc.add(const GetDefaultAddressEvent());
  }

  Future<void> _navigateToAddressForm({address}) async {
    final result = await context.pushNamed(
      'addressForm',
      extra: address,
    );

    if (result == "success") {
      _fetchDefaultAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _addressBloc),
        BlocProvider(create: (_) => _createTrialBloc),
      ],
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "Trial Details",
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, addressState) {
            if (addressState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (addressState.isFailure) {
              return Center(
                child: Text(
                  "Error loading address: ${addressState.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (addressState.isSuccess && addressState.address != null) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CheckoutAddressSection(
                      onEditAddress: (updatedAddress) {
                        _navigateToAddressForm(address: updatedAddress);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Trial details card
                    TrialDetailsCard(
                      productName: widget.trialProductName,
                      productImageUrl: widget.trialProductImageUrl,
                      trialPeriod: widget.trialPeriod,
                    ),
                    const SizedBox(height: 30),
                    // Terms and conditions checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                          activeColor: primaryLightColor,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed("trialTerms");
                            },
                            child: const Text(
                              "I have read and accept Trizy's terms for trialing products.",
                              style: TextStyle(
                                color: primaryLightColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Submit button
                    BlocConsumer<CreateTrialBloc, CreateTrialState>(
                      listener: (context, createTrialState) {
                        if (createTrialState.isSuccess) {
                          context.goNamed("trialSuccess");
                        } else if (createTrialState.isFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(createTrialState.errorMessage ?? "Failed to create trial."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, createTrialState) {
                        return CustomButton(
                          text: createTrialState.isLoading ? "Processing..." : "Trial Now!",
                          textColor: Colors.white,
                          color: primaryLightColor,
                          height: 56,
                          width: double.infinity,
                          isLoading: createTrialState.isLoading,
                          disabled: !_isChecked || createTrialState.isLoading,
                          onClick: () {
                            context.read<CreateTrialBloc>().add(
                              TrialCreationRequested(trialProductId: widget.trialProductId),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            return const Center(child: Text("No address found."));
          },
        ),
      ),
    );
  }
}