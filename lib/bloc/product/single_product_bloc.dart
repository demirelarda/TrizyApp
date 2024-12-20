import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/product/single_product_event.dart';
import 'package:trizy_app/bloc/product/single_product_state.dart';
import 'package:trizy_app/repositories/products_repository.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final ProductsRepository productsRepository = GetIt.instance<ProductsRepository>();

  SingleProductBloc() : super(SingleProductState.initial()) {
    on<SingleProductRequested>(_onSingleProductRequested);
  }

  Future<void> _onSingleProductRequested(SingleProductRequested event, Emitter<SingleProductState> emit) async {
    emit(SingleProductState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await productsRepository.getSingleProduct(productId: event.productId);
      emit(state.copyWith(isLoading: false, isSuccess: true, productResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }

}