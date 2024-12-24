import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/payment/create_payment_intent_response.dart';

class PaymentState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CreatePaymentIntentResponse? createPaymentIntentResponse;
  final String? errorMessage;

  const PaymentState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.createPaymentIntentResponse,
    this.errorMessage,
  });

  factory PaymentState.initial() {
    return const PaymentState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      createPaymentIntentResponse: null,
      errorMessage: null,
    );
  }

  PaymentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    CreatePaymentIntentResponse? createPaymentIntentResponse,
    String? errorMessage,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      createPaymentIntentResponse: createPaymentIntentResponse ?? this.createPaymentIntentResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, createPaymentIntentResponse, errorMessage];
}