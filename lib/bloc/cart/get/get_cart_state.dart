import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/cart/response/get_cart_response.dart';

class GetCartState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final GetCartResponse? cartResponse;
  final String? errorMessage;

  const GetCartState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.cartResponse,
    this.errorMessage,
  });

  factory GetCartState.initial() {
    return const GetCartState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      cartResponse: null,
      errorMessage: null,
    );
  }

  GetCartState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    GetCartResponse? cartResponse,
    String? errorMessage,
  }) {
    return GetCartState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      cartResponse: cartResponse ?? this.cartResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, cartResponse, errorMessage];
}