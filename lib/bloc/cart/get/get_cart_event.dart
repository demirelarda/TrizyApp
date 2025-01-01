import 'package:equatable/equatable.dart';
import '../../../models/cart/cart.dart';

abstract class GetCartEvent extends Equatable {
  const GetCartEvent();

  @override
  List<Object?> get props => [];
}

class UserCartRequested extends GetCartEvent {}

class LocalCartUpdated extends GetCartEvent {
  final Cart updatedCart;
  final double cargoFeeThreshold;
  const LocalCartUpdated(this.updatedCart, this.cargoFeeThreshold);
}