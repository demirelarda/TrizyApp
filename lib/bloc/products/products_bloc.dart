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
    emit(ProductsState.initial());
    emit(state.copyWith(isLoading: true));
    try {

      late ProductsResponse response;

      if(event.categoryId != null){
        // get products by category
        response = await productsRepository.getProductsByCategory(categoryId: event.categoryId!, page: event.page);
      }
      else if (event.query != null){
        // search products
        response = await productsRepository.searchProducts(query: event.query!, page: event.page);
      }
      else if (event.query != null && event.categoryId != null){
        // search products with a category filter
        response = await productsRepository.searchProducts(query: event.query!, categoryId: event.categoryId, page: event.page);
      }

      emit(state.copyWith(isLoading: false, isSuccess: true, productsResponse: response, errorMessage: null, isFailure: false));


    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}