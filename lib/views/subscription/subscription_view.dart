import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trizy_app/bloc/subscription/subscription_bloc.dart';
import 'package:trizy_app/bloc/subscription/subscription_event.dart';
import 'package:trizy_app/bloc/subscription/subscription_state.dart';

import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/models/subscription/request/create_subscription_request.dart';
import 'package:trizy_app/models/user/user_pref_model.dart';
import 'package:trizy_app/theme/colors.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool isCardFieldComplete = false;
  String? paymentMethodId;
  String? userEmail;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      final user = UserPreferencesModel.fromJson(userMap);
      setState(() {
        userEmail = user.email;
        userName = '${user.firstName} ${user.lastName}';
      });
    }
  }


  Future<void> _pollSubscriptionStatus(BuildContext context) async {
    const maxAttempts = 5;
    for (int i = 0; i < maxAttempts; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.read<SubscriptionBloc>().add(const GetSubscriptionStatusEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubscriptionBloc(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "Subscribe",
        ),
        body: SafeArea(
          child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) async {
              debugPrint('BlocConsumer Listener:');
              debugPrint('  isSuccess: ${state.isSuccess}');
              debugPrint('  isFailure: ${state.isFailure}');
              debugPrint('  operationType: ${state.operationType}');
              debugPrint('  subscriptionStatus: ${state.subscriptionStatus}');
              debugPrint('  errorMessage: ${state.errorMessage}');
              debugPrint('  message: ${state.message}');
              debugPrint('  clientSecret: ${state.clientSecret}');
              debugPrint('  subscription: ${state.subscription}');
              if (state.isSuccess &&
                  state.operationType == SubscriptionOperationType.create) {
                if (state.clientSecret != null && state.clientSecret!.isNotEmpty) {
                  debugPrint('Confirming PaymentIntent with Stripe...');
                  try {
                    await Stripe.instance.confirmPayment(
                      paymentIntentClientSecret: state.clientSecret!,
                      data: PaymentMethodParams.card(
                        paymentMethodData: PaymentMethodData(
                          billingDetails: BillingDetails(
                            email: userEmail ?? 'testuser@gmail.com',
                            name: userName ?? 'Test User',
                          ),
                        ),
                      ),
                    );
                    debugPrint('PaymentIntent confirmed successfully.');

                    _pollSubscriptionStatus(context);

                  } catch (e) {
                    debugPrint('Error confirming PaymentIntent: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Payment confirmation failed: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'Subscription created successfully.'),
                    ),
                  );
                }
              }

              if (state.isFailure && state.errorMessage != null) {
                debugPrint('Failure state detected: ${state.errorMessage}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }

              if (state.subscriptionStatus == 'active') {
                debugPrint('Subscription is active! Navigating to success screen...');
                context.goNamed('subscriptionSuccessful');
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        'assets/images/trizyprologo.png',
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Unlock the best experience with Trizy Pro!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "By subscribing to Trizy Pro, you'll get faster deliveries, "
                          "access to early product trials, and priority for high-demand items.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "We use Stripe, a trusted and secure payment platform, to process your subscription. "
                          "Your payment information is handled securely.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    CardField(
                      onCardChanged: (details) {
                        setState(() {
                          isCardFieldComplete = details?.complete ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomButton(
                      text: 'Subscribe for \$30/Month',
                      textColor: Colors.white,
                      color: primaryLightColor,
                      isLoading: state.isLoading &&
                          state.operationType == SubscriptionOperationType.create,
                      onClick: () async {
                        if (!isCardFieldComplete) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete card details.')),
                          );
                          return;
                        }

                        try {
                          debugPrint('Creating PaymentMethod with Stripe...');
                          final billingDetails = BillingDetails(
                            email: userEmail ?? 'testuser@gmail.com',
                            name: userName ?? 'Test User',
                          );
                          final paymentMethod = await Stripe.instance.createPaymentMethod(
                            params: PaymentMethodParams.card(
                              paymentMethodData: PaymentMethodData(
                                billingDetails: billingDetails,
                              ),
                            ),
                          );
                          paymentMethodId = paymentMethod.id;
                          debugPrint('Created PaymentMethod: $paymentMethodId');
                        } catch (e) {
                          debugPrint('Error creating PaymentMethod: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error creating PaymentMethod: $e')),
                          );
                          return;
                        }

                        if (paymentMethodId != null) {
                          final req = CreateSubscriptionRequest(paymentMethodId: paymentMethodId!);
                          debugPrint('Dispatching CreateSubscriptionEvent...');
                          context
                              .read<SubscriptionBloc>()
                              .add(CreateSubscriptionEvent(request: req));
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    if (state.isLoading &&
                        state.operationType != SubscriptionOperationType.create)
                      const CircularProgressIndicator(),
                    const SizedBox(height: 8),

                    if (state.subscriptionStatus != null)
                      const Text(
                        'Completing Subscription...',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}