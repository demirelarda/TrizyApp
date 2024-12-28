import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/trial/trial_products_event.dart';
import 'package:trizy_app/bloc/trial/trial_products_state.dart';
import '../../models/trialproduct/trial_products_response.dart';
import '../../repositories/trial_product_repository.dart';


class TrialProductsBloc extends Bloc<TrialProductsEvent, TrialProductsState> {
  final TrialProductsRepository trialProductsRepository = GetIt.instance<TrialProductsRepository>();

  TrialProductsBloc() : super(TrialProductsState.initial()) {
    on<TrialProductsRequested>(_onTrialProductsRequested);
  }

  Future<void> _onTrialProductsRequested(TrialProductsRequested event, Emitter<TrialProductsState> emit) async {
    // If this is the first page we can show a loading indicator and reset state accordingly
    // for subsequent pages we just append the data
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else {
      // for subsequent pages show loading but don't reset products
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }

    try {
      late TrialProductsResponse response;

      if (event.categoryId != null && event.query != null) {
        // Search trial products with a category filter
        response = await trialProductsRepository.searchTrialProducts(
          query: event.query!,
          categoryId: event.categoryId,
          page: event.page,
        );
      } else if (event.categoryId != null) {
        // Get trial products by category
        response = await trialProductsRepository.getTrialProductsByCategory(
          categoryId: event.categoryId!,
          page: event.page,
        );
      } else if (event.query != null) {
        // Search trial products
        response = await trialProductsRepository.searchTrialProducts(
          query: event.query!,
          page: event.page,
        );
      } else {
        // Get the latest trial products
        response = await trialProductsRepository.getLatestTrialProducts(page: event.page);
      }

      if (event.page > 1 && state.trialProductsResponse != null) {
        // Append new trial products to the existing list
        final oldTrialProducts = state.trialProductsResponse!.trialProducts;
        final newTrialProducts = response.trialProducts;
        final combinedTrialProducts = [...oldTrialProducts, ...newTrialProducts];

        final updatedResponse = TrialProductsResponse(
          success: response.success,
          trialProducts: combinedTrialProducts,
          pagination: response.pagination,
          subCategories: response.subCategories,
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          trialProductsResponse: updatedResponse,
          isFailure: false,
          errorMessage: null,
        ));
      } else {
        // First page load or resetting the trial products list
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          trialProductsResponse: response,
          isFailure: false,
          errorMessage: null,
        ));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}