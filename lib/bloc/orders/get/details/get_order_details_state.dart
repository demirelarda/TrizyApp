import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/order/order_details_response.dart';

class GetOrderDetailsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final OrderDetailsResponse? orderDetailsResponse;
  final String? errorMessage;

  const GetOrderDetailsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.orderDetailsResponse,
    this.errorMessage,
  });

  factory GetOrderDetailsState.initial() {
    return const GetOrderDetailsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      orderDetailsResponse: null,
      errorMessage: null,
    );
  }

  GetOrderDetailsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    OrderDetailsResponse? orderDetailsResponse,
    String? errorMessage,
  }) {
    return GetOrderDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      orderDetailsResponse: orderDetailsResponse ?? this.orderDetailsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, orderDetailsResponse, errorMessage];
}