import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/cart/response/cart_operation_response.dart';

class CartOperationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CartOperationResponse? cartOperationResponse;
  final String? errorMessage;

  const CartOperationState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.cartOperationResponse,
    this.errorMessage,
  });

  factory CartOperationState.initial() {
    return const CartOperationState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      cartOperationResponse: null,
      errorMessage: null,
    );
  }

  CartOperationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    CartOperationResponse? cartOperationResponse,
    String? errorMessage,
  }) {
    return CartOperationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      cartOperationResponse: cartOperationResponse ?? this.cartOperationResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, cartOperationResponse, errorMessage];
}