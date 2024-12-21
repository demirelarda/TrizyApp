import 'package:trizy_app/models/cart/response/add_item_to_cart_on_feed_response.dart';

class AddCartItemOnFeedState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final AddItemToCartOnFeedResponse? response;
  final String? currentProductId;

  AddCartItemOnFeedState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    required this.errorMessage,
    required this.response,
    required this.currentProductId,
  });

  factory AddCartItemOnFeedState.initial() {
    return AddCartItemOnFeedState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
      response: null,
      currentProductId: null
    );
  }

  AddCartItemOnFeedState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    AddItemToCartOnFeedResponse? response,
    String? currentProductId
  }) {
    return AddCartItemOnFeedState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
      currentProductId: currentProductId,
    );
  }
}