import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_bloc.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/checkout/checkout_address_section.dart';
import '../../components/checkout/checkout_delivery_date_section.dart';
import '../../components/checkout/checkout_order_summary_section.dart';
import '../../components/buttons/custom_button.dart';
import '../../models/address/address.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late AddressBloc _addressBloc;
  late GetCartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _addressBloc = AddressBloc();
    _cartBloc = GetCartBloc();
    _fetchDefaultAddress();
    _fetchCart();
  }

  @override
  void dispose() {
    _addressBloc.close();
    _cartBloc.close();
    super.dispose();
  }

  void _fetchDefaultAddress() {
    _addressBloc.add(const GetDefaultAddressEvent());
  }

  void _fetchCart() {
    _cartBloc.add(UserCartRequested());
  }

  Future<void> _navigateToAddressForm({Address? address}) async {
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
        BlocProvider(create: (context) => _addressBloc),
        BlocProvider(create: (context) => _cartBloc),
      ],
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          title: "Checkout",
          onBackClicked: () => context.pop(),
        ),
        body: BlocBuilder<GetCartBloc, GetCartState>(
          builder: (context, cartState) {
            if (cartState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (cartState.isFailure) {
              return Center(
                child: Text(
                  "Error loading cart: ${cartState.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (cartState.isSuccess && cartState.cartResponse != null) {
              final cart = cartState.cartResponse!.cart;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CheckoutAddressSection(
                      onEditAddress: (address) {
                        _navigateToAddressForm(address: address);
                      },
                    ),
                    const SizedBox(height: 20),
                    const DeliveryDateSection(),
                    const SizedBox(height: 40),
                    OrderSummarySection(cart: cart),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }

            return const Center(child: Text("Cart is empty."));
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            child: CustomButton(
              text: "Pay Now",
              textColor: white,
              color: primaryLightColor,
              onClick: () {

              },
            ),
          ),
        ),
      ),
    );
  }
}