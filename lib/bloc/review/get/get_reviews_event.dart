import 'package:equatable/equatable.dart';

abstract class GetReviewsEvent extends Equatable {
  const GetReviewsEvent();

  @override
  List<Object?> get props => [];
}

class ReviewsRequested extends GetReviewsEvent {

  final String productId;
  final int page;

  const ReviewsRequested({
    required this.productId,
    required this.page
  });

  @override
  List<Object?> get props => [productId, page];

}