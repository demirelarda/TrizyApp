import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/review/get/reviewable/get_reviewable_products_event.dart';
import 'package:trizy_app/bloc/review/get/reviewable/get_reviewable_products_state.dart';
import 'package:trizy_app/repositories/review_repository.dart';

class GetReviewableProductsBloc extends Bloc<GetReviewableProductsEvent, GetReviewableProductsState> {
  final ReviewRepository reviewRepository = GetIt.instance<ReviewRepository>();

  GetReviewableProductsBloc() : super(GetReviewableProductsState.initial()) {
    on<ReviewableProductsRequested>(_onReviewableProductsRequested);
  }

  Future<void> _onReviewableProductsRequested(ReviewableProductsRequested event, Emitter<GetReviewableProductsState> emit) async {
    emit(GetReviewableProductsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await reviewRepository.getReviewableProducts(orderId: event.orderId);
      emit(state.copyWith(isLoading: false, isSuccess: true, getReviewableProductsResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}