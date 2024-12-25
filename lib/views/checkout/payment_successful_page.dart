import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_bloc.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_event.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_state.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/components/buttons/outlined_text_button.dart';
import 'package:trizy_app/theme/text_styles.dart';

class PaymentSuccessfulPage extends StatefulWidget {
  final String paymentIntentId;

  const PaymentSuccessfulPage({super.key, required this.paymentIntentId});

  @override
  State<PaymentSuccessfulPage> createState() => _PaymentSuccessfulPageState();
}

class _PaymentSuccessfulPageState extends State<PaymentSuccessfulPage> {
  late CheckOrderStatusBloc _orderStatusBloc;

  @override
  void initState() {
    super.initState();
    _orderStatusBloc = CheckOrderStatusBloc();
    _orderStatusBloc.add(OrderCheckRequested(paymentIntentId: widget.paymentIntentId));
  }

  @override
  void dispose() {
    _orderStatusBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderStatusBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Payment Status",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: white,
          elevation: 1,
          centerTitle: true,
        ),
        body: BlocBuilder<CheckOrderStatusBloc, CheckOrderStatusState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isSuccess && state.checkOrderStatusResponse != null) {
              return _SuccessWidget(
                orderId: state.checkOrderStatusResponse!.order!.id,
              );
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  "Failed to fetch order details: ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const Center(
              child: Text(
                "Completing payment...",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  final String orderId;

  const _SuccessWidget({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/confirmTick.json',
              width: 150,
              height: 150,
              repeat: false,
            ),
            const SizedBox(height: 20),
            const Text(
              "Order Created Successfully!",
              style: AppTextStyles.headline20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            Column(
              children: [
                OutlinedTextButton(
                  text: "Go to your orders",
                  onClick: () {
                    context.goNamed(
                      'myOrders',
                      pathParameters: {
                        'fromAccount': "0",
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                OutlinedTextButton(
                  text: "Go to home page",
                  onClick: () {
                    context.go('/mainPage');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}