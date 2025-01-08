import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/address/address_bloc.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_bloc.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_state.dart';
import 'package:trizy_app/bloc/payment/payment_bloc.dart';
import 'package:trizy_app/bloc/payment/payment_event.dart';
import 'package:trizy_app/bloc/payment/payment_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../bloc/address/address_state.dart';
import '../../components/checkout/checkout_address_section.dart';
import '../../components/checkout/checkout_delivery_date_section.dart';
import '../../components/checkout/checkout_order_summary_section.dart';
import '../../components/buttons/custom_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late AddressBloc _addressBloc;
  late GetCartBloc _cartBloc;
  late PaymentBloc _paymentBloc;

  @override
  void initState() {
    super.initState();
    _addressBloc = AddressBloc();
    _cartBloc = GetCartBloc();
    _paymentBloc = PaymentBloc();
    _fetchDefaultAddress();
    _fetchCart();
  }

  @override
  void dispose() {
    _addressBloc.close();
    _cartBloc.close();
    _paymentBloc.close();
    super.dispose();
  }

  void _fetchDefaultAddress() {
    _addressBloc.add(const GetDefaultAddressEvent());
  }

  void _fetchCart() {
    _cartBloc.add(UserCartRequested());
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

  Future<void> _showPaymentSheet({required String clientSecret, required String paymentIntentId}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.system,
          merchantDisplayName: 'Trizy',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (mounted) {
        context.goNamed(
          'paymentSuccessful',
          pathParameters: {
            'paymentIntentId': paymentIntentId,
          },
        );
      }
    } on StripeException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${e.error.localizedMessage}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred while processing payment.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _addressBloc),
        BlocProvider(create: (context) => _cartBloc),
        BlocProvider(create: (context) => _paymentBloc),
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
          child: BlocConsumer<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state.isSuccess && state.createPaymentIntentResponse != null) {
                final clientSecret = state.createPaymentIntentResponse!.paymentIntent.clientSecret;
                final paymentIntentId = state.createPaymentIntentResponse!.paymentIntent.id;
                _showPaymentSheet(clientSecret: clientSecret, paymentIntentId: paymentIntentId);
              }
            },
            builder: (context, state) {
              return BlocBuilder<AddressBloc, AddressState>(
                builder: (context, addressState) {
                  final hasDefaultAddress = addressState.address != null;
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                    child: CustomButton(
                      text: state.isLoading ? "Processing..." : "Pay Now",
                      textColor: white,
                      color: primaryLightColor,
                      isLoading: state.isLoading,
                      onClick: () {
                        if (hasDefaultAddress) {
                          context.read<PaymentBloc>().add(PaymentIntentRequested());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You need to set a default address to continue!"),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}