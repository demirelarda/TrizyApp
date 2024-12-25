import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/order/get_user_orders_response.dart';

class GetOrdersState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final GetUserOrdersResponse? getUserOrdersResponse;
  final String? errorMessage;

  const GetOrdersState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.getUserOrdersResponse,
    this.errorMessage,
  });

  factory GetOrdersState.initial() {
    return const GetOrdersState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      getUserOrdersResponse: null,
      errorMessage: null,
    );
  }

  GetOrdersState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    GetUserOrdersResponse? getUserOrdersResponse,
    String? errorMessage,
  }) {
    return GetOrdersState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      getUserOrdersResponse: getUserOrdersResponse ?? this.getUserOrdersResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, getUserOrdersResponse, errorMessage];
}