import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/review/get/get_reviews_event.dart';
import 'package:trizy_app/bloc/review/get/get_reviews_state.dart';
import 'package:trizy_app/models/review/get_reviews_response.dart';
import 'package:trizy_app/repositories/review_repository.dart';

class GetReviewsBloc extends Bloc<GetReviewsEvent, GetReviewsState> {
  final ReviewRepository reviewRepository = GetIt.instance<ReviewRepository>();

  GetReviewsBloc() : super(GetReviewsState.initial()) {
    on<ReviewsRequested>(_onReviewsRequested);
  }

  Future<void> _onReviewsRequested(ReviewsRequested event, Emitter<GetReviewsState> emit) async {
    // If this is the first page we can show a loading indicator and reset state accordingly
    // for subsequent pages we just append the data
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else{
      // for subsequent pages show loading but don't reset reviews
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }
    try {
      final response = await reviewRepository.getProductReviews(productId: event.productId, page: event.page);

      if (event.page > 1 && state.getReviewsResponse != null) {
        // Append new reviews to the existing list
        final oldReviews = state.getReviewsResponse!.reviews;
        final newReviews = response.reviews;
        final combinedReviews = [...oldReviews, ...newReviews];

        final updatedResponse = GetReviewsResponse(
          success: response.success,
          reviews: combinedReviews,
          pagination: response.pagination,
          averageRating: response.averageRating,
          totalReviews: response.totalReviews,
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          getReviewsResponse: updatedResponse,
          isFailure: false,
          errorMessage: null,
        ));
      } else {
        // First page load or resetting the review list
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          getReviewsResponse: response,
          isFailure: false,
          errorMessage: null,
        ));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}