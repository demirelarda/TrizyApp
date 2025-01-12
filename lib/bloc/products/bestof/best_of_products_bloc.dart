import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/products/bestof/best_of_products_event.dart';
import 'package:trizy_app/bloc/products/bestof/best_of_products_state.dart';
import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/repositories/products_repository.dart';

class BestOfProductsBloc extends Bloc<BestOfProductsEvent, BestOfProductsState> {
  final  productsRepository = GetIt.instance<ProductsRepository>();

  BestOfProductsBloc() : super(BestOfProductsState.initial()) {
    on<BestProductsRequested>(_onProductsRequested);
    on<BestOfFetchLikedProductsFromLocal>(_onFetchLikedProducts);
    on<BestOfAddLikeEvent>(_onAddLikeEvent);
    on<BestOfRemoveLikeEvent>(_onRemoveLikeEvent);
    on<BestOfFetchCartItemsFromLocal>(_onFetchCartItems);
  }

  Future<void> _onProductsRequested(BestProductsRequested event, Emitter<BestOfProductsState> emit) async {

    emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false, errorMessage: null));

    try {
      late ProductsResponse response;

      response = await productsRepository.getBestOfProducts(
          period: event.period
      );

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        productsResponse: response,
        isFailure: false,
        errorMessage: null,
      ));

    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


  Future<void> _onFetchCartItems(BestOfFetchCartItemsFromLocal event, Emitter<BestOfProductsState> emit) async {
    try {
      final itemsInCart = await productsRepository.fetchItemsInCart();
      final cartItemIds = itemsInCart.map((e) => e.productId).toSet();
      emit(state.copyWith(itemsInCart: cartItemIds));
    } catch (error) {
      print("Failed to fetch cart items: $error");
    }
  }

  Future<void> _onAddLikeEvent(BestOfAddLikeEvent event, Emitter<BestOfProductsState> emit) async {
    try {
      await productsRepository.likeProduct(productId: event.productId);
      final updatedLikedProductIds = Set<String>.from(state.likedProductIds)..add(event.productId);
      emit(state.copyWith(likedProductIds: updatedLikedProductIds));
    } catch (error) {
      print("Failed to like product: $error");
    }
  }

  Future<void> _onRemoveLikeEvent(BestOfRemoveLikeEvent event, Emitter<BestOfProductsState> emit) async {
    try {
      await productsRepository.removeLike(productId: event.productId);
      final updatedLikedProductIds = Set<String>.from(state.likedProductIds)..remove(event.productId);
      emit(state.copyWith(likedProductIds: updatedLikedProductIds));
    } catch (error) {
      print("Failed to remove like: $error");
    }
  }


  Future<void> _onFetchLikedProducts(BestOfFetchLikedProductsFromLocal event, Emitter<BestOfProductsState> emit) async {
    try {
      final likedProducts = await productsRepository.fetchLikedProducts();
      final likedProductIds = likedProducts.map((e) => e.productId).toSet();
      emit(state.copyWith(likedProductIds: likedProductIds));
    } catch (error) {
      print("Failed to fetch liked products: $error");
    }
  }



}