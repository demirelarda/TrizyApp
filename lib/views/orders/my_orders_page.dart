import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/orders/get/get_orders_bloc.dart';
import 'package:trizy_app/bloc/orders/get/get_orders_event.dart';
import 'package:trizy_app/bloc/orders/get/get_orders_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/order/order_card.dart';

class MyOrdersPage extends StatefulWidget {

  final bool fromAccount;

  const MyOrdersPage({super.key, required this.fromAccount});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late GetOrdersBloc _getOrdersBloc;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _getOrdersBloc = GetOrdersBloc();
    _getOrdersBloc.add(UserOrdersRequested(page: _currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          !_getOrdersBloc.state.isLoading &&
          _getOrdersBloc.state.getUserOrdersResponse != null &&
          _currentPage < _getOrdersBloc.state.getUserOrdersResponse!.totalPages) {
        _currentPage++;
        _getOrdersBloc.add(UserOrdersRequested(page: _currentPage));
      }
    });
  }

  @override
  void dispose() {
    _getOrdersBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getOrdersBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          title: "My Orders",
          onBackClicked: () {
            if(widget.fromAccount){
              context.pop();
            }
            else{
              context.goNamed("mainPage");
            }
          },
        ),
        body: BlocBuilder<GetOrdersBloc, GetOrdersState>(
          builder: (context, state) {
            if (state.isLoading && state.getUserOrdersResponse == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Failed to load orders.",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (state.isSuccess && state.getUserOrdersResponse != null) {
              final orders = state.getUserOrdersResponse!.orders;

              return ListView.builder(
                controller: _scrollController,
                itemCount: orders.length + 1,
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  return OrderCard(
                    order: orders[index],
                    onClick: (orderId){
                      context.pushNamed(
                          "orderDetailsFromMyOrder",
                          pathParameters: {"orderId":orderId}
                      );
                    },
                  );
                },
              );
            }

            return const Center(
              child: Text(
                "You have no orders yet.",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}