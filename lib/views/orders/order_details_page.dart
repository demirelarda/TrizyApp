import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:trizy_app/bloc/orders/get/details/get_order_details_bloc.dart';
import 'package:trizy_app/bloc/orders/get/details/get_order_details_event.dart';
import 'package:trizy_app/bloc/orders/get/details/get_order_details_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/order/order_details_product_card.dart';
import 'package:trizy_app/theme/colors.dart';

class OrderDetailsPage extends StatefulWidget {
  final String? orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late GetOrderDetailsBloc _orderDetailsBloc;

  @override
  void initState() {
    super.initState();
    _orderDetailsBloc = GetOrderDetailsBloc();
    if (widget.orderId != null) {
      _orderDetailsBloc.add(OrderDetailsRequested(orderId: widget.orderId!));
    } else {
      _orderDetailsBloc.add(LatestOrderDetailsRequested());
    }
  }

  @override
  void dispose() {
    _orderDetailsBloc.close();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.grey;
      case 'shipping':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'returned':
        return Colors.grey.shade600;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderDetailsBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          title: "Order Details",
          onBackClicked: () => context.pop(),
        ),
        body: BlocBuilder<GetOrderDetailsBloc, GetOrderDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Failed to load order details.",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (state.isSuccess && state.orderDetailsResponse != null) {
              final order = state.orderDetailsResponse!.order;

              final productTotal = order.items
                  .map((item) => item.price * item.quantity)
                  .reduce((value, element) => value + element);
              final cargoFee = order.amount - productTotal;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Info Section
                      const Text(
                        "Order Info",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Status"),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color:
                              _getStatusColor(order.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order.status.toUpperCase(),
                              style: TextStyle(
                                color: _getStatusColor(order.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Order ID"),
                          Text(order.orderId),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Created At"),
                          Text(DateFormat('dd-MM-yyyy').format(order.createdAt)),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Product List Section
                      const Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...order.items.map((item) {
                        return OrderDetailsProductCard(
                          productId: item.productId,
                          productTitle: item.productTitle,
                          productImageUrl: item.productImage,
                          price: item.price,
                          quantity: item.quantity,
                          onCardClick: () {
                            context.pushNamed("productDetailsPage",
                                pathParameters: {"productId": item.productId});
                          },
                        );
                      }).toList(),

                      const SizedBox(height: 24),

                      // Order Fee Section
                      const Text(
                        "Order Fee",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Product Total"),
                                Text("\$${productTotal.toStringAsFixed(2)}"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Cargo Fee"),
                                Text("\$${cargoFee.toStringAsFixed(2)}"),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$${order.amount.toStringAsFixed(2)}",
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Delivery Address Section
                      const Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${order.deliveryAddress.fullName}\n"
                              "${order.deliveryAddress.address}, ${order.deliveryAddress.city}, ${order.deliveryAddress.state}, ${order.deliveryAddress.country}\n"
                              "Postal Code: ${order.deliveryAddress.postalCode}\n"
                              "Phone: ${order.deliveryAddress.phoneNumber}",
                          style:
                          const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: Text(
                "Order details not available.",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}