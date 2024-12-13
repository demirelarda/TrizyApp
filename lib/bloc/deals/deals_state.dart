import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/deal/deals_response.dart';

class DealsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final DealsResponse? deals;
  final String? errorMessage;

  const DealsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.deals,
    this.errorMessage,
  });

  factory DealsState.initial() {
    return const DealsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      deals: null,
      errorMessage: null,
    );
  }

  DealsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    DealsResponse? deals,
    String? errorMessage,
  }) {
    return DealsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      deals: deals ?? this.deals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, deals, errorMessage];
}