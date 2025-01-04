import 'package:equatable/equatable.dart';

abstract class GetOrderDetailsEvent extends Equatable {
  const GetOrderDetailsEvent();

  @override
  List<Object?> get props => [];
}

class OrderDetailsRequested extends GetOrderDetailsEvent {

  final String orderId;

  const OrderDetailsRequested({
    required this.orderId,
  });

  @override
  List<Object?> get props => [orderId];

}


class LatestOrderDetailsRequested extends GetOrderDetailsEvent {

  const LatestOrderDetailsRequested();

  @override
  List<Object?> get props => [];

}