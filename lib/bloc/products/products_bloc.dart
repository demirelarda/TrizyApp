import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/products/products_event.dart';
import 'package:trizy_app/bloc/products/products_state.dart';
import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/repositories/products_repository.dart';

import '../../models/product/product_query_params.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final  productsRepository = GetIt.instance<ProductsRepository>();

  ProductsBloc() : super(ProductsState.initial()) {
    on<ProductsRequested>(_onProductsRequested);
    on<FetchLikedProductsFromLocal>(_onFetchLikedProducts);
    on<AddLikeEvent>(_onAddLikeEvent);
    on<RemoveLikeEvent>(_onRemoveLikeEvent);
    on<LikedProductsRequested>(_onLikedProductsRequested);
    on<FetchCartItemsFromLocal>(_onFetchCartItems);
  }

  Future<void> _onProductsRequested(ProductsRequested event, Emitter<ProductsState> emit) async {
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else {
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }

    try {
      late ProductsResponse response;

      final ProductQueryParams queryParams = ProductQueryParams(
        query: event.query,
        categoryId: event.categoryId,
        minPrice: event.queryParams?.minPrice,
        maxPrice: event.queryParams?.maxPrice,
        exactRatings: event.queryParams?.exactRatings,
        minRatingCount: event.queryParams?.minRatingCount,
        maxRatingCount: event.queryParams?.maxRatingCount,
        minLikeCount: event.queryParams?.minLikeCount,
        maxLikeCount: event.queryParams?.maxLikeCount,
        sortBy: event.queryParams?.sortBy,
      );

      if (event.query != null) {
        // Search with query and optional category
        response = await productsRepository.searchProducts(
          query: event.query!,
          categoryId: event.categoryId,
          page: event.page,
          queryParams: queryParams,
        );
      } else if (event.categoryId != null) {
        // Fetch products by category
        response = await productsRepository.getProductsByCategory(
          categoryId: event.categoryId!,
          page: event.page,
          queryParams: queryParams,
        );
      } else {
        throw Exception("Either query or categoryId must be provided.");
      }

      if (event.page > 1 && state.productsResponse != null) {
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

  Future<void> _onFetchLikedProducts(FetchLikedProductsFromLocal event, Emitter<ProductsState> emit) async {
    try {
      final likedProducts = await productsRepository.fetchLikedProducts();
      final likedProductIds = likedProducts.map((e) => e.productId).toSet();
      emit(state.copyWith(likedProductIds: likedProductIds));
    } catch (error) {
      print("Failed to fetch liked products: $error");
    }
  }

  Future<void> _onFetchCartItems(FetchCartItemsFromLocal event, Emitter<ProductsState> emit) async {
    try {
      final itemsInCart = await productsRepository.fetchItemsInCart();
      final cartItemIds = itemsInCart.map((e) => e.productId).toSet();
      emit(state.copyWith(itemsInCart: cartItemIds));
    } catch (error) {
      print("Failed to fetch cart items: $error");
    }
  }

  Future<void> _onAddLikeEvent(AddLikeEvent event, Emitter<ProductsState> emit) async {
    try {
      await productsRepository.likeProduct(productId: event.productId);
      final updatedLikedProductIds = Set<String>.from(state.likedProductIds)..add(event.productId);
      emit(state.copyWith(likedProductIds: updatedLikedProductIds));
    } catch (error) {
      print("Failed to like product: $error");
    }
  }

  Future<void> _onRemoveLikeEvent(RemoveLikeEvent event, Emitter<ProductsState> emit) async {
    try {
      await productsRepository.removeLike(productId: event.productId);
      final updatedLikedProductIds = Set<String>.from(state.likedProductIds)..remove(event.productId);
      emit(state.copyWith(likedProductIds: updatedLikedProductIds));
    } catch (error) {
      print("Failed to remove like: $error");
    }
  }


  Future<void> _onLikedProductsRequested(LikedProductsRequested event, Emitter<ProductsState> emit) async {
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));
    } else {
      emit(state.copyWith(isLoading: true, isFailure: false, errorMessage: null));
    }

    try {
      late ProductsResponse response;

      response = await productsRepository.getLikedProducts(
        page: event.page,
      );

      if (event.page > 1 && state.productsResponse != null) {
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