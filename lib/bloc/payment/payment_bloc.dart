import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/payment/payment_event.dart';
import 'package:trizy_app/bloc/payment/payment_state.dart';
import 'package:trizy_app/repositories/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository = GetIt.instance<PaymentRepository>();

  PaymentBloc() : super(PaymentState.initial()) {
    on<PaymentIntentRequested>(_onPaymentIntentRequested);
  }

  Future<void> _onPaymentIntentRequested(PaymentIntentRequested event, Emitter<PaymentState> emit) async {
    emit(PaymentState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await paymentRepository.createPaymentIntent();
      emit(state.copyWith(isLoading: false, isSuccess: true, createPaymentIntentResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}