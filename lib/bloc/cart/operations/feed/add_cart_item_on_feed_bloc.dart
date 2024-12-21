import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_state.dart';
import '../../../../repositories/cart_repository.dart';
import 'add_cart_item_on_feed_event.dart';

class AddCartItemOnFeedBloc
    extends Bloc<AddCartItemOnFeedEvent, AddCartItemOnFeedState> {
  final CartRepository cartRepository = GetIt.instance<CartRepository>();

  AddCartItemOnFeedBloc() : super(AddCartItemOnFeedState.initial()) {
    on<AddFeedItemEvent>(_onAddFeedItemEvent);
  }

  Future<void> _onAddFeedItemEvent(
      AddFeedItemEvent event,
      Emitter<AddCartItemOnFeedState> emit,
      ) async {
    emit(state.copyWith(
      isLoading: true,
      currentProductId: event.productId,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
      response: null,
    ));

    try {
      final response = await cartRepository.addItemOnFeed(
        productId: event.productId,
      );
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        isFailure: false,
        errorMessage: '',
        currentProductId: event.productId,
        response: response,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        isFailure: true,
        errorMessage: error.toString(),
        currentProductId: null,
        response: null,
      ));
    }
  }
}