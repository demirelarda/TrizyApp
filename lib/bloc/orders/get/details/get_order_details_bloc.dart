import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/orders/get/details/get_order_details_event.dart';
import 'package:trizy_app/bloc/orders/get/details/get_order_details_state.dart';
import 'package:trizy_app/repositories/orders_repository.dart';


class GetOrderDetailsBloc extends Bloc<GetOrderDetailsEvent, GetOrderDetailsState> {
  final OrdersRepository ordersRepository = GetIt.instance<OrdersRepository>();

  GetOrderDetailsBloc() : super(GetOrderDetailsState.initial()) {
    on<OrderDetailsRequested>(_onOrderDetailsRequested);
    on<LatestOrderDetailsRequested>(_onLatestOrderDetailsRequested);
  }

  Future<void> _onOrderDetailsRequested(OrderDetailsRequested event, Emitter<GetOrderDetailsState> emit) async {
    emit(GetOrderDetailsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await ordersRepository.getOrderDetails(orderId: event.orderId);
      emit(state.copyWith(isLoading: false, isSuccess: true, orderDetailsResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


  Future<void> _onLatestOrderDetailsRequested(LatestOrderDetailsRequested event, Emitter<GetOrderDetailsState> emit) async {
    emit(GetOrderDetailsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await ordersRepository.getLatestOrderDetails();
      emit(state.copyWith(isLoading: false, isSuccess: true, orderDetailsResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }

}