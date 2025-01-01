import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_bloc.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_event.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_state.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_bloc.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_event.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_state.dart';
import 'package:trizy_app/bloc/products/products_bloc.dart';
import 'package:trizy_app/bloc/products/products_event.dart';
import 'package:trizy_app/bloc/products/products_state.dart';
import 'package:trizy_app/components/product_card.dart';

class AiSuggestionsSection extends StatefulWidget {
  const AiSuggestionsSection({super.key});

  @override
  State<AiSuggestionsSection> createState() => _AiSuggestionsSectionState();
}

class _AiSuggestionsSectionState extends State<AiSuggestionsSection> {
  late AiSuggestionsBloc _aiSuggestionsBloc;
  late AddCartItemOnFeedBloc _addCartItemOnFeedBloc;
  late ProductsBloc _productsBloc;

  String? _loadingProductId;

  @override
  void initState() {
    super.initState();
    _aiSuggestionsBloc = AiSuggestionsBloc()..add(const AiSuggestionsRequested());
    _addCartItemOnFeedBloc = AddCartItemOnFeedBloc();
    _productsBloc = ProductsBloc()
      ..add(FetchLikedProductsFromLocal())
      ..add(FetchCartItemsFromLocal());
  }

  @override
  void dispose() {
    _aiSuggestionsBloc.close();
    _addCartItemOnFeedBloc.close();
    _productsBloc.close();
    super.dispose();
  }

  Future<void> _handlePop(BuildContext context, String id, String reason) async {
    final result = await context.pushNamed(
      "productDetailsPageAI",
      pathParameters: {
        "productId": id,
        "reason": reason,
      },
      extra: _productsBloc,
    );
    if (result == "back") {
      _productsBloc.add(FetchCartItemsFromLocal());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _aiSuggestionsBloc),
        BlocProvider.value(value: _addCartItemOnFeedBloc),
        BlocProvider.value(value: _productsBloc),
      ],
      child: BlocListener<AddCartItemOnFeedBloc, AddCartItemOnFeedState>(
        listener: (context, addCartState) {
          if (addCartState.isLoading) {
            setState(() {
              _loadingProductId = addCartState.currentProductId;
            });
          }

          if (addCartState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${addCartState.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _loadingProductId = null;
            });
          }

          if (addCartState.isSuccess && addCartState.response != null) {
            final productId = addCartState.currentProductId;
            if (productId != null) {
              _productsBloc.add(FetchCartItemsFromLocal());
              setState(() {
                _loadingProductId = null;
              });
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(addCartState.response!.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<AiSuggestionsBloc, AiSuggestionsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/animations/ailoading.json',
                  width: 200,
                  height: 200,
                ),
              );
            } else if (state.isFailure) {
              return Center(
                child: Text(
                  'Failed to load AI suggestions: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state.isSuccess && state.productsResponse?.products.isNotEmpty == true) {
              final products = state.productsResponse!.products;

              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, productsState) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isLiked = productsState.likedProductIds.contains(product.id);
                      final productInCart = productsState.itemsInCart.contains(product.id);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ProductCard(
                          product: product,
                          onAddToCart: () {
                            if (!productInCart) {
                              context
                                  .read<AddCartItemOnFeedBloc>()
                                  .add(AddFeedItemEvent(productId: product.id));
                            }
                          },
                          onLikeTap: () {
                            if (isLiked) {
                              _productsBloc.add(RemoveLikeEvent(productId: product.id));
                            } else {
                              _productsBloc.add(AddLikeEvent(productId: product.id));
                            }
                          },
                          onProductClicked: (productId) {
                            _handlePop(context, productId, product.reason ?? "");
                          },
                          isLiked: isLiked,
                          isLoading: (_loadingProductId == product.id),
                          productInCart: productInCart,
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('No AI suggestions available.'));
            }
          },
        ),
      ),
    );
  }
}