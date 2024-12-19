import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/products/products_event.dart';
import 'package:trizy_app/bloc/products/products_state.dart';
import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/repositories/products_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository = GetIt.instance<ProductsRepository>();

  ProductsBloc() : super(ProductsState.initial()) {
    on<ProductsRequested>(_onProductsRequested);
  }

  Future<void> _onProductsRequested(ProductsRequested event, Emitter<ProductsState> emit) async {
    // If this is the first page we can show a loading indicator and reset state accordingly
    // for subsequent pages we just append the data
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else {
      // for subsequent pages show loading but don't reset products
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }

    try {
      late ProductsResponse response;

      if (event.categoryId != null && event.query != null) {
        // search products with a category filter
        response = await productsRepository.searchProducts(
          query: event.query!,
          categoryId: event.categoryId,
          page: event.page,
        );
      } else if (event.categoryId != null) {
        // get products by category
        response = await productsRepository.getProductsByCategory(
          categoryId: event.categoryId!,
          page: event.page,
        );
      } else if (event.query != null) {
        // search products
        response = await productsRepository.searchProducts(
          query: event.query!,
          page: event.page,
        );
      }

      if (event.page > 1 && state.productsResponse != null) {
        // Append new products to the existing list
        final oldProducts = state.productsResponse!.products;
        final newProducts = response.products;
        final combinedProducts = [...oldProducts, ...newProducts];

        final updatedResponse = ProductsResponse(
          success: response.success,
          products: combinedProducts,
          pagination: response.pagination,
          subCategories: response.subCategories,
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          productsResponse: updatedResponse,
          isFailure: false,
          errorMessage: null,
        ));
      } else {
        // First page load or resetting the product list
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          productsResponse: response,
          isFailure: false,
          errorMessage: null,
        ));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}