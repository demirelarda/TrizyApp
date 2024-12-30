import 'package:equatable/equatable.dart';

abstract class GetReviewableProductsEvent extends Equatable {
  const GetReviewableProductsEvent();

  @override
  List<Object?> get props => [];
}

class ReviewableProductsRequested extends GetReviewableProductsEvent {

  final String orderId;

  const ReviewableProductsRequested({required this.orderId});

  @override
  List<Object?> get props => [];

}