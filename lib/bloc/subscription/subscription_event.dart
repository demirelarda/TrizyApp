import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/subscription/request/create_subscription_request.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}


class CreateSubscriptionEvent extends SubscriptionEvent {

  final CreateSubscriptionRequest request;

  const CreateSubscriptionEvent({required this.request});

  @override
  List<Object?> get props => [request];

}


class GetSubscriptionStatusEvent extends SubscriptionEvent {

  const GetSubscriptionStatusEvent();

  @override
  List<Object?> get props => [];

}


class CancelSubscriptionEvent extends SubscriptionEvent {

  final String subscriptionId;

  const CancelSubscriptionEvent({required this.subscriptionId});

  @override
  List<Object?> get props => [subscriptionId];

}