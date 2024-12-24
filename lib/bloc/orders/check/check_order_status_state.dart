import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/order/check_order_status_response.dart';

class CheckOrderStatusState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CheckOrderStatusResponse? checkOrderStatusResponse;
  final String? errorMessage;

  const CheckOrderStatusState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.checkOrderStatusResponse,
    this.errorMessage,
  });

  factory CheckOrderStatusState.initial() {
    return const CheckOrderStatusState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      checkOrderStatusResponse: null,
      errorMessage: null,
    );
  }

  CheckOrderStatusState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    CheckOrderStatusResponse? checkOrderStatusResponse,
    String? errorMessage,
  }) {
    return CheckOrderStatusState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      checkOrderStatusResponse: checkOrderStatusResponse ?? this.checkOrderStatusResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, checkOrderStatusResponse, errorMessage];
}