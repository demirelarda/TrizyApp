import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_state.dart';
import 'package:trizy_app/repositories/cart_repository.dart';

import '../../../models/cart/response/get_cart_response.dart';

class GetCartBloc extends Bloc<GetCartEvent, GetCartState> {
  final CartRepository cartRepository = GetIt.instance<CartRepository>();

  GetCartBloc() : super(GetCartState.initial()) {
    on<UserCartRequested>(_onCartRequested);
    on<LocalCartUpdated>(_onLocalCartUpdated);
  }

  Future<void> _onCartRequested(UserCartRequested event, Emitter<GetCartState> emit) async {
    emit(GetCartState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await cartRepository.getUserCart();
      emit(state.copyWith(isLoading: false, isSuccess: true, cartResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }


  void _onLocalCartUpdated(
      LocalCartUpdated event,
      Emitter<GetCartState> emit,
      ) {
    final currentState = state;

    if (currentState.isSuccess && currentState.cartResponse != null) {
      final newCartResponse = currentState.cartResponse!.copyWith(
        cart: event.updatedCart,
      );

      emit(
        currentState.copyWith(
          cartResponse: newCartResponse,
          isLoading: false,
          isFailure: false,
          isSuccess: true,
          errorMessage: '',
        ),
      );
    } else {
      // If the state wasn’t success or cartResponse was null, just create a new GetCartResponse.
      final newResponse = GetCartResponse(
        success: true,
        cart: event.updatedCart,
      );

      emit(
        currentState.copyWith(
          cartResponse: newResponse,
          isLoading: false,
          isFailure: false,
          isSuccess: true,
          errorMessage: '',
        ),
      );
    }
  }


}