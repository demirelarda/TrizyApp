import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_bloc.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_event.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_state.dart';
import 'package:trizy_app/theme/colors.dart';

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
        appBar: AppBar(
          title: const Text(
            "Payment Status",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
        ),
        body: BlocBuilder<CheckOrderStatusBloc, CheckOrderStatusState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isSuccess && state.checkOrderStatusResponse != null) {
              return const Center(
                child: Text(
                  "Order Created Successfully",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryLightColor,
                  ),
                ),
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