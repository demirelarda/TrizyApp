import 'package:equatable/equatable.dart';
import '../../models/subscription/subscription.dart';

enum SubscriptionOperationType {
  create,
  getStatus,
  cancel
}

class SubscriptionState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final Subscription? subscription;
  final String? subscriptionStatus;
  final String? clientSecret;
  final String? message;
  final String? errorMessage;
  final SubscriptionOperationType? operationType;

  const SubscriptionState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.message,
    this.errorMessage,
    this.operationType,
    this.subscription,
    this.clientSecret,
    this.subscriptionStatus
  });

  factory SubscriptionState.initial() {
    return const SubscriptionState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      message: null,
      errorMessage: null,
      operationType: null,
      subscription: null,
      clientSecret: null,
      subscriptionStatus: null
    );
  }

  SubscriptionState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    String? message,
    Subscription? subscription,
    String? clientSecret,
    String? subscriptionStatus,
    SubscriptionOperationType? operationType
  }) {
    return SubscriptionState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      operationType: operationType ?? this.operationType,
      subscription: subscription ?? this.subscription,
      clientSecret: clientSecret ?? this.clientSecret,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isFailure,
    errorMessage,
    message,
    operationType,
    subscription,
    clientSecret,
    subscriptionStatus
  ];
}