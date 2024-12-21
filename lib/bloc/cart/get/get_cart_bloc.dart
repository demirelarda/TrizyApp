import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_state.dart';
import 'package:trizy_app/repositories/cart_repository.dart';

class GetCartBloc extends Bloc<GetCartEvent, GetCartState> {
  final CartRepository cartRepository = GetIt.instance<CartRepository>();

  GetCartBloc() : super(GetCartState.initial()) {
    on<UserCartRequested>(_onCartRequested);
  }

  Future<void> _onCartRequested(UserCartRequested event, Emitter<GetCartState> emit) async {
    emit(GetCartState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await cartRepository.getUserCart();
      emit(state.copyWith(isLoading: false, isSuccess: true, deals: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}