import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/cart/operations/cart_operation_event.dart';
import 'package:trizy_app/bloc/cart/operations/cart_operation_state.dart';
import 'package:trizy_app/repositories/cart_repository.dart';

class CartOperationBloc extends Bloc<CartOperationEvent, CartOperationState> {
  final CartRepository cartRepository = GetIt.instance<CartRepository>();

  CartOperationBloc() : super(CartOperationState.initial()) {
    on<AddItemEvent>(_onAddItemEvent);
    on<DeleteItemEvent>(_onDeleteItemEvent);
    on<DecrementQuantityEvent>(_onDecrementQuantityEvent);
  }

  Future<void> _onAddItemEvent(AddItemEvent event, Emitter<CartOperationState> emit) async {
    emit(CartOperationState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await cartRepository.addItemToCart(request: event.request);
      emit(state.copyWith(isLoading: false, isSuccess: true, cartOperationResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


  Future<void> _onDeleteItemEvent(DeleteItemEvent event, Emitter<CartOperationState> emit) async {
    emit(CartOperationState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await cartRepository.deleteItemFromCart(productId: event.productId);
      emit(state.copyWith(isLoading: false, isSuccess: true, cartOperationResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


  Future<void> _onDecrementQuantityEvent(DecrementQuantityEvent event, Emitter<CartOperationState> emit) async {
    emit(CartOperationState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await cartRepository.decrementItemQuantity(productId: event.productId);
      emit(state.copyWith(isLoading: false, isSuccess: true, cartOperationResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


}