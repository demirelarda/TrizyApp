import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_event.dart';
import 'package:trizy_app/bloc/orders/check/check_order_status_state.dart';
import 'package:trizy_app/repositories/orders_repository.dart';

class CheckOrderStatusBloc extends Bloc<CheckOrderStatusEvent, CheckOrderStatusState> {
  final OrdersRepository ordersRepository = GetIt.instance<OrdersRepository>();

  CheckOrderStatusBloc() : super(CheckOrderStatusState.initial()) {
    on<OrderCheckRequested>(_onOrderCheckRequested);
    on<_PollingTriggered>(_onPollingTriggered);
  }

  Timer? _pollingTimer;

  Future<void> _onOrderCheckRequested(OrderCheckRequested event, Emitter<CheckOrderStatusState> emit) async {
    emit(CheckOrderStatusState.initial());
    emit(state.copyWith(isLoading: true));

    const maxRetries = 10;
    const pollingInterval = Duration(seconds: 5);
    int retryCount = 0;

    void startPolling() {
      _pollingTimer = Timer.periodic(pollingInterval, (_) {
        if (!state.isSuccess && retryCount < maxRetries) {
          add(_PollingTriggered(paymentIntentId: event.paymentIntentId, retryCount: retryCount));
        } else {
          _pollingTimer?.cancel();
        }
      });
    }

    add(_PollingTriggered(paymentIntentId: event.paymentIntentId, retryCount: retryCount));

    startPolling();
  }

  Future<void> _onPollingTriggered(_PollingTriggered event, Emitter<CheckOrderStatusState> emit) async {
    try {
      final response = await ordersRepository.checkOrderStatus(paymentIntentId: event.paymentIntentId);

      if (response.success && response.order != null) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          checkOrderStatusResponse: response,
          isFailure: false,
        ));
        _pollingTimer?.cancel();
      } else if (event.retryCount >= 10) {
        emit(state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: "Max retries exceeded",
        ));
        _pollingTimer?.cancel();
      }
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isFailure: true,
        errorMessage: error.toString(),
      ));
      _pollingTimer?.cancel();
    }
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}

class _PollingTriggered extends CheckOrderStatusEvent {
  final String paymentIntentId;
  final int retryCount;

  const _PollingTriggered({
    required this.paymentIntentId,
    required this.retryCount,
  });

  @override
  List<Object?> get props => [paymentIntentId, retryCount];
}