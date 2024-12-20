import 'package:equatable/equatable.dart';

abstract class SingleProductEvent extends Equatable {
  const SingleProductEvent();

  @override
  List<Object?> get props => [];
}

class SingleProductRequested extends SingleProductEvent {

  final String productId;

  const SingleProductRequested({
    required this.productId
  });

  @override
  List<Object?> get props => [productId];

}