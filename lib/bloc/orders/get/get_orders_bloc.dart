import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/orders/get/get_orders_event.dart';
import 'package:trizy_app/bloc/orders/get/get_orders_state.dart';
import 'package:trizy_app/models/order/get_user_orders_response.dart';
import 'package:trizy_app/repositories/orders_repository.dart';

class GetOrdersBloc extends Bloc<GetOrdersEvent, GetOrdersState> {
  final OrdersRepository ordersRepository = GetIt.instance<OrdersRepository>();

  GetOrdersBloc() : super(GetOrdersState.initial()) {
    on<UserOrdersRequested>(_onUserOrdersRequested);
  }

  Future<void> _onUserOrdersRequested(UserOrdersRequested event, Emitter<GetOrdersState> emit) async {
    // If this is the first page we can show a loading indicator and reset state accordingly
    // for subsequent pages we just append the data
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else {
      // for subsequent pages show loading but don't reset orders
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }

    try {
      final response = await ordersRepository.getUserOrders(page: event.page,);


      if (event.page > 1 && state.getUserOrdersResponse != null) {
        // Append new orders to the existing list
        final oldOrders = state.getUserOrdersResponse!.orders;
        final newOrders = response.orders;
        final combinedOrders = [...oldOrders, ...newOrders];

        final updatedResponse = GetUserOrdersResponse(
          success: response.success,
          orders: combinedOrders,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          getUserOrdersResponse: updatedResponse,
          isFailure: false,
          errorMessage: null,
        ));
      } else {
        // First page load or resetting the order list
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          getUserOrdersResponse: response,
          isFailure: false,
          errorMessage: null,
        ));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}