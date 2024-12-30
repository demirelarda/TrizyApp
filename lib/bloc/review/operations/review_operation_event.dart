import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/review/create_review_request.dart';

abstract class ReviewOperationEvent extends Equatable {
  const ReviewOperationEvent();

  @override
  List<Object?> get props => [];
}

class CreateReviewEvent extends ReviewOperationEvent {

  final CreateReviewRequest request;

  const CreateReviewEvent({required this.request});

  @override
  List<Object?> get props => [request];

}


class DeleteReviewEvent extends ReviewOperationEvent {

  final String reviewId;

  const DeleteReviewEvent({required this.reviewId});

  @override
  List<Object?> get props => [reviewId];

}