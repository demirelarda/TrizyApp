import 'package:equatable/equatable.dart';

abstract class CheckOrderStatusEvent extends Equatable {
  const CheckOrderStatusEvent();

  @override
  List<Object?> get props => [];
}

class OrderCheckRequested extends CheckOrderStatusEvent {

  final String paymentIntentId;

  const OrderCheckRequested({
    required this.paymentIntentId,
  });

  @override
  List<Object?> get props => [paymentIntentId];

}