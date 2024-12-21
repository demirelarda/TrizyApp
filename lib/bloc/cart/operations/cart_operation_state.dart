import '../../../models/cart/response/cart_operation_response.dart';

enum CartOperation { none, increment, decrement, remove }

class CartOperationState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final CartOperationResponse? cartOperationResponse;
  final String? currentProductId;
  final CartOperation currentOperation;

  CartOperationState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    required this.errorMessage,
    required this.cartOperationResponse,
    required this.currentProductId,
    required this.currentOperation,
  });

  factory CartOperationState.initial() {
    return CartOperationState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
      cartOperationResponse: null,
      currentProductId: null,
      currentOperation: CartOperation.none,
    );
  }

  CartOperationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    CartOperationResponse? cartOperationResponse,
    String? currentProductId,
    CartOperation? currentOperation,
  }) {
    return CartOperationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      cartOperationResponse: cartOperationResponse ?? this.cartOperationResponse,
      currentProductId: currentProductId,
      currentOperation: currentOperation ?? this.currentOperation,
    );
  }
}