import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/review/operations/review_operation_event.dart';
import 'package:trizy_app/bloc/review/operations/review_operation_state.dart';
import 'package:trizy_app/repositories/review_repository.dart';
import 'package:get_it/get_it.dart';

class ReviewOperationBloc extends Bloc<ReviewOperationEvent, ReviewOperationState> {
  final ReviewRepository reviewRepository = GetIt.instance<ReviewRepository>();

  ReviewOperationBloc() : super(ReviewOperationState.initial()) {
    on<CreateReviewEvent>(_onCreateReview);
    on<DeleteReviewEvent>(_onDeleteReview);
  }

  Future<void> _onCreateReview(
      CreateReviewEvent event, Emitter<ReviewOperationState> emit) async {
    emit(state.copyWith(isLoading: true, currentOperation: ReviewOperation.create));

    try {
      final response = await reviewRepository.createReview(request: event.request);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        isFailure: false,
        reviewOperationResponse: response,
        currentOperation: ReviewOperation.create,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: error.toString(),
        currentOperation: ReviewOperation.none,
      ));
    }
  }

  Future<void> _onDeleteReview(
      DeleteReviewEvent event, Emitter<ReviewOperationState> emit) async {
    emit(state.copyWith(isLoading: true, currentOperation: ReviewOperation.delete));

    try {
      final response = await reviewRepository.deleteReview(reviewId: event.reviewId);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        isFailure: false,
        reviewOperationResponse: response,
        currentOperation: ReviewOperation.delete,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: error.toString(),
        currentOperation: ReviewOperation.none,
      ));
    }
  }
}